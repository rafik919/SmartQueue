import { Injectable, Logger } from '@nestjs/common';
import { PrismaService } from '../../database/prisma.service';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class NotificationsService {
  private readonly logger = new Logger(NotificationsService.name);

  constructor(
    private prisma: PrismaService,
    private config: ConfigService,
  ) {}

  async sendTicketCreated(ticket: any, userId: string) {
    await this.save({
      userId,
      ticketId: ticket.id,
      type: 'TICKET_CREATED',
      title: `Ticket confirmé — ${ticket.code}`,
      body: `Vous êtes en position d'attente pour ${ticket.service?.name ?? 'le service'}`,
      data: { ticketId: ticket.id, type: 'TICKET_CREATED' },
    });
    await this.sendPush(userId, {
      title: `Ticket confirmé — ${ticket.code}`,
      body: `Vous êtes en attente pour ${ticket.service?.name ?? 'le service'}`,
      data: { ticketId: ticket.id, type: 'TICKET_CREATED' },
    });
  }

  async sendTicketCalled(ticket: any) {
    const counterName = ticket.counter?.name ?? 'guichet';
    await this.save({
      userId: ticket.customerId,
      ticketId: ticket.id,
      type: 'TICKET_CALLED',
      title: `C'est votre tour ! (${ticket.code})`,
      body: `Rendez-vous au ${counterName}`,
      data: { ticketId: ticket.id, counterName, type: 'TICKET_CALLED' },
    });
    await this.sendPush(ticket.customerId, {
      title: `C'est votre tour ! (${ticket.code})`,
      body: `Rendez-vous au ${counterName}`,
      data: { ticketId: ticket.id, type: 'TICKET_CALLED' },
    });
  }

  async sendPositionReminder(ticket: any, position: number) {
    if (position > 3) return;
    const msg = position === 1 ? 'Vous êtes le prochain !' : `Plus que ${position} personnes avant vous`;
    await this.save({
      userId: ticket.customerId,
      ticketId: ticket.id,
      type: 'TICKET_REMINDER',
      title: msg,
      body: `Ticket ${ticket.code} — Préparez-vous`,
      data: { ticketId: ticket.id, position, type: 'TICKET_REMINDER' },
    });
    await this.sendPush(ticket.customerId, {
      title: msg,
      body: `Ticket ${ticket.code} — Préparez-vous`,
      data: { ticketId: ticket.id, type: 'TICKET_REMINDER' },
    });
  }

  async findByUser(userId: string, isRead?: boolean, page = 1, limit = 20) {
    const where: any = { userId };
    if (isRead !== undefined) where.isRead = isRead;
    const [items, total] = await Promise.all([
      this.prisma.notification.findMany({
        where, skip: (page - 1) * limit, take: limit,
        orderBy: { createdAt: 'desc' },
      }),
      this.prisma.notification.count({ where }),
    ]);
    return { items, total, page, limit };
  }

  async markRead(id: string, _userId: string) {
    return this.prisma.notification.update({
      where: { id },
      data: { isRead: true, readAt: new Date() } as any,
    });
  }

  async markAllRead(userId: string) {
    return this.prisma.notification.updateMany({
      where: { userId, isRead: false },
      data: { isRead: true } as any,
    });
  }

  private async save(data: {
    userId: string; ticketId?: string; type: string;
    title: string; body: string; data?: any;
  }) {
    return this.prisma.notification.create({
      data: {
        userId: data.userId,
        ticketId: data.ticketId,
        type: data.type,
        title: data.title,
        body: data.body,
        data: data.data,
        sentAt: new Date(),
      },
    });
  }

  private async sendPush(userId: string, payload: { title: string; body: string; data?: any }) {
    // FCM push — activer quand Firebase est configuré
    const projectId = this.config.get('FIREBASE_PROJECT_ID');
    if (!projectId) {
      this.logger.debug(`[FCM SKIP] ${payload.title} → userId: ${userId}`);
      return;
    }
    // TODO: implémenter l'envoi FCM avec firebase-admin
    this.logger.log(`[FCM] Sending to ${userId}: ${payload.title}`);
  }
}
