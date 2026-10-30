import {
  Injectable, NotFoundException, ConflictException,
  UnprocessableEntityException, Logger,
} from '@nestjs/common';
import { PrismaService } from '../../database/prisma.service';
import { BranchesService } from '../branches/branches.service';
import { NotificationsService } from '../notifications/notifications.service';
import { CreateTicketDto, CancelTicketDto, FeedbackDto, TransferTicketDto } from './dto/tickets.dto';
import { addHours } from 'date-fns';

@Injectable()
export class TicketsService {
  private readonly logger = new Logger(TicketsService.name);

  constructor(
    private prisma: PrismaService,
    private branchesService: BranchesService,
    private notificationsService: NotificationsService,
  ) {}

  // ── Créer un ticket ────────────────────────────────────────────────────────
  async create(dto: CreateTicketDto, customerId: string) {
    // 1. Vérifier ticket actif existant
    const active = await this.prisma.ticket.findFirst({
      where: {
        customerId,
        branchId: dto.branchId,
        status: { in: ['WAITING', 'CALLED', 'IN_SERVICE'] },
      },
    });
    if (active) {
      throw new ConflictException({
        message: 'Vous avez déjà un ticket actif dans cet établissement',
        code: 'TICKET_ALREADY_ACTIVE',
        ticketId: active.id,
      });
    }

    // 2. Vérifier que la file est active
    const queue = await this.prisma.queue.findUnique({
      where: { id: dto.queueId },
    });
    if (!queue || queue.status !== 'ACTIVE') {
      throw new UnprocessableEntityException('File d\'attente non disponible');
    }

    // 3. Vérifier capacité max
    if (queue.maxSize) {
      const count = await this.prisma.ticket.count({
        where: { queueId: dto.queueId, status: 'WAITING' },
      });
      if (count >= queue.maxSize) {
        throw new UnprocessableEntityException('File d\'attente pleine');
      }
    }

    // 4. Transaction atomique
    const ticket = await this.prisma.$transaction(async (tx) => {
      const updated = await tx.queue.update({
        where: { id: dto.queueId },
        data: { currentNumber: { increment: 1 } },
      });

      const number = updated.currentNumber;
      const code   = `${queue.prefix}-${String(number).padStart(4, '0')}`;

      const t = await tx.ticket.create({
        data: {
          code, number,
          status: 'WAITING',
          source: (dto.source as any) ?? 'MOBILE',
          customerId,
          queueId: dto.queueId,
          branchId: dto.branchId,
          serviceId: dto.serviceId,
          expiresAt: addHours(new Date(), 8),
        },
        include: {
          queue: { select: { id: true, name: true, prefix: true } },
          service: { select: { id: true, name: true } },
          branch: { select: { id: true, name: true, address: true, wilaya: { select: { name: true } }, commune: { select: { name: true } } } },
        },
      });

      return t;
    });

    // 5. Recalculer positions
    await this.recalculatePositions(dto.queueId);

    // 6. Notification de confirmation
    await this.notificationsService.sendTicketCreated(ticket, customerId);

    this.logger.log(`Ticket créé: ${ticket.code} par ${customerId}`);
    return this.enrichTicket(ticket.id);
  }

  // ── Obtenir ticket ─────────────────────────────────────────────────────────
  async findOne(ticketId: string, _userId?: string) {
    const ticket = await this.prisma.ticket.findUnique({
      where: { id: ticketId },
      include: {
        queue: { select: { id: true, name: true, prefix: true } },
        service: { select: { id: true, name: true } },
        branch: { select: { id: true, name: true, address: true, wilaya: { select: { name: true } }, commune: { select: { name: true } } } },
        counter: { select: { id: true, name: true, number: true } },
      },
    });
    if (!ticket) throw new NotFoundException('Ticket introuvable');
    return this.enrichTicket(ticket.id);
  }

  // ── Historique client ──────────────────────────────────────────────────────
  async findMyTickets(customerId: string, status?: string, page = 1, limit = 20) {
    const where: any = { customerId };
    if (status) {
      const statuses = status.split(',');
      where.status = statuses.length === 1 ? statuses[0] : { in: statuses };
    }
    const [tickets, total] = await Promise.all([
      this.prisma.ticket.findMany({
        where,
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          queue: { select: { id: true, name: true, prefix: true } },
          service: { select: { id: true, name: true } },
          branch: { select: { id: true, name: true, address: true, wilaya: { select: { name: true } }, commune: { select: { name: true } } } },
          counter: { select: { id: true, name: true, number: true } },
        },
      }),
      this.prisma.ticket.count({ where }),
    ]);

    const enriched = await Promise.all(tickets.map((t) => this.enrichTicket(t.id)));
    return { items: enriched, total, page, limit, pages: Math.ceil(total / limit) };
  }

  // ── Annuler ticket ─────────────────────────────────────────────────────────
  async cancel(ticketId: string, customerId: string, dto: CancelTicketDto) {
    const ticket = await this.prisma.ticket.findFirst({
      where: { id: ticketId, customerId },
    });
    if (!ticket) throw new NotFoundException('Ticket introuvable');
    if (!['WAITING', 'CALLED'].includes(ticket.status)) {
      throw new UnprocessableEntityException('Ce ticket ne peut pas être annulé');
    }

    const updated = await this.prisma.ticket.update({
      where: { id: ticketId },
      data: { status: 'CANCELLED', cancelledAt: new Date(), notes: dto.reason },
    });

    await this.recalculatePositions(ticket.queueId);
    return updated;
  }

  // ── Appeler prochain ticket (Agent) ────────────────────────────────────────
  async callNext(counterId: string, agentId: string) {
    // Trouver les files assignées à ce guichet
    const counterQueues = await this.prisma.counterQueue.findMany({
      where: { counterId },
      orderBy: { priority: 'asc' },
    });

    const queueIds = counterQueues.map((cq) => cq.queueId);

    const nextTicket = await this.prisma.ticket.findFirst({
      where: { status: 'WAITING', queueId: { in: queueIds } },
      orderBy: { createdAt: 'asc' },
      include: {
        customer: { select: { id: true, firstName: true, fcmTokens: true } },
        queue: { select: { id: true, name: true } },
        service: { select: { id: true, name: true } },
        branch: { select: { id: true, name: true } },
      },
    });

    if (!nextTicket) throw new NotFoundException('File vide');

    const waitSec = Math.floor(
      (Date.now() - nextTicket.createdAt.getTime()) / 1000,
    );

    const [ticket] = await this.prisma.$transaction([
      this.prisma.ticket.update({
        where: { id: nextTicket.id },
        data: {
          status: 'CALLED',
          calledAt: new Date(),
          counterId,
          waitDurationSec: waitSec,
        },
        include: {
          counter: { select: { id: true, name: true, number: true } },
          customer: { select: { id: true, firstName: true, fcmTokens: true } },
          queue: { select: { id: true, name: true, prefix: true } },
          service: { select: { id: true, name: true } },
          branch: { select: { id: true, name: true, address: true, wilaya: { select: { name: true } }, commune: { select: { name: true } } } },
        },
      }),
      this.prisma.counter.update({
        where: { id: counterId },
        data: { status: 'BUSY', agentId },
      }),
    ]);

    await this.recalculatePositions(nextTicket.queueId);
    await this.notificationsService.sendTicketCalled(ticket as any);

    return ticket;
  }

  // ── Marquer terminé (Agent) ────────────────────────────────────────────────
  async complete(ticketId: string, agentId: string, notes?: string) {
    const ticket = await this.prisma.ticket.findUnique({
      where: { id: ticketId },
      include: { counter: true },
    });
    if (!ticket) throw new NotFoundException('Ticket introuvable');

    const serviceSec = ticket.calledAt
      ? Math.floor((Date.now() - ticket.calledAt.getTime()) / 1000)
      : undefined;

    const [updated] = await this.prisma.$transaction([
      this.prisma.ticket.update({
        where: { id: ticketId },
        data: {
          status: 'COMPLETED',
          completedAt: new Date(),
          serviceDurationSec: serviceSec,
          notes,
        },
      }),
      this.prisma.counter.update({
        where: { id: ticket.counterId! },
        data: { status: 'OPEN' },
      }),
    ]);

    // Mettre à jour temps moyen de service de la file
    if (serviceSec) {
      const queue = await this.prisma.queue.findUnique({
        where: { id: ticket.queueId },
        select: { avgServiceTime: true },
      });
      if (queue) {
        const newAvg = Math.round(
          queue.avgServiceTime * 0.8 + (serviceSec / 60) * 0.2,
        );
        await this.prisma.queue.update({
          where: { id: ticket.queueId },
          data: { avgServiceTime: newAvg },
        });
      }
    }

    return updated;
  }

  // ── Marquer absent (Agent) ─────────────────────────────────────────────────
  async markMissed(ticketId: string) {
    const ticket = await this.prisma.ticket.findUnique({ where: { id: ticketId } });
    if (!ticket) throw new NotFoundException('Ticket introuvable');

    return this.prisma.ticket.update({
      where: { id: ticketId },
      data: { status: 'MISSED', missedAt: new Date() },
    });
  }

  // ── Transférer ticket (Agent) ──────────────────────────────────────────────
  async transfer(ticketId: string, agentId: string, dto: TransferTicketDto) {
    const ticket = await this.prisma.ticket.findUnique({
      where: { id: ticketId },
      include: { queue: true },
    });
    if (!ticket) throw new NotFoundException('Ticket introuvable');

    const targetQueue = await this.prisma.queue.findUnique({
      where: { id: dto.targetQueueId },
    });
    if (!targetQueue || targetQueue.status !== 'ACTIVE') {
      throw new UnprocessableEntityException('File cible indisponible');
    }

    // Marquer l'ancien ticket comme transféré
    await this.prisma.ticket.update({
      where: { id: ticketId },
      data: { status: 'TRANSFERRED', notes: dto.reason },
    });

    // Créer nouveau ticket dans la file cible
    const updated = await this.prisma.queue.update({
      where: { id: dto.targetQueueId },
      data: { currentNumber: { increment: 1 } },
    });

    const newCode = `${targetQueue.prefix}-${String(updated.currentNumber).padStart(4, '0')}`;

    const newTicket = await this.prisma.ticket.create({
      data: {
        code: newCode,
        number: updated.currentNumber,
        status: 'WAITING',
        source: 'AGENT',
        customerId: ticket.customerId,
        queueId: dto.targetQueueId,
        branchId: ticket.branchId,
        serviceId: targetQueue.serviceId,
        expiresAt: addHours(new Date(), 4),
      },
    });

    await this.recalculatePositions(dto.targetQueueId);
    return newTicket;
  }

  // ── Soumettre feedback ─────────────────────────────────────────────────────
  async submitFeedback(ticketId: string, userId: string, dto: FeedbackDto) {
    const ticket = await this.prisma.ticket.findFirst({
      where: { id: ticketId, customerId: userId },
    });
    if (!ticket) throw new NotFoundException('Ticket introuvable');

    return this.prisma.feedback.upsert({
      where: { ticketId },
      create: {
        ticketId, userId,
        rating: dto.rating,
        comment: dto.comment,
        tags: dto.tags || [],
      },
      update: { rating: dto.rating, comment: dto.comment, tags: dto.tags || [] },
    });
  }

  // ── QR Code ────────────────────────────────────────────────────────────────
  async getQrData(ticketId: string) {
    const ticket = await this.prisma.ticket.findUnique({
      where: { id: ticketId },
      select: { id: true, code: true },
    });
    if (!ticket) throw new NotFoundException('Ticket introuvable');
    return { qrData: `${ticket.id}|${ticket.code}` };
  }

  // ── Tickets d'une file (Agent) ─────────────────────────────────────────────
  async findByQueue(queueId: string, status = 'WAITING', limit = 50) {
    const statuses = status.split(',');
    return this.prisma.ticket.findMany({
      where: {
        queueId,
        status: statuses.length === 1 ? (statuses[0] as any) : { in: statuses as any },
      },
      orderBy: { createdAt: 'asc' },
      take: limit,
      include: {
        customer: { select: { id: true, firstName: true, lastName: true } },
        service: { select: { name: true } },
      },
    });
  }

  // ── Recalculer positions ────────────────────────────────────────────────────
  async recalculatePositions(queueId: string) {
    const queue = await this.prisma.queue.findUnique({
      where: { id: queueId },
      select: { avgServiceTime: true },
    });
    if (!queue) return;

    const waiting = await this.prisma.ticket.findMany({
      where: { queueId, status: 'WAITING' },
      orderBy: { createdAt: 'asc' },
      select: { id: true },
    });

    await Promise.all(
      waiting.map((ticket, index) =>
        this.prisma.ticket.update({
          where: { id: ticket.id },
          data: {
            position: index + 1,
            estimatedWaitMin: index * queue.avgServiceTime,
          },
        }),
      ),
    );

    return waiting.length;
  }

  // ── Enrichir ticket avec données calculées ─────────────────────────────────
  private async enrichTicket(ticketId: string) {
    const ticket = await this.prisma.ticket.findUnique({
      where: { id: ticketId },
      include: {
        queue: {
          select: { id: true, name: true, prefix: true,
            _count: { select: { tickets: { where: { status: 'WAITING' } } } } },
        },
        service: { select: { id: true, name: true } },
        branch: { select: { id: true, name: true, address: true, wilaya: { select: { name: true } }, commune: { select: { name: true } } } },
        counter: { select: { id: true, name: true, number: true } },
      },
    });
    if (!ticket) throw new NotFoundException('Ticket introuvable');

    return {
      ...ticket,
      queue: {
        id: ticket.queue.id, name: ticket.queue.name, prefix: ticket.queue.prefix,
        waitingCount: ((ticket.queue as any)._count?.tickets) || 0,
      },
    };
  }
}
