import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../database/prisma.service';

@Injectable()
export class QueuesService {
  constructor(private prisma: PrismaService) {}

  async findByBranch(branchId: string) {
    const queues = await this.prisma.queue.findMany({
      where: { branchId, isActive: true },
      include: {
        service: true,
        _count: { select: { tickets: { where: { status: 'WAITING' } } } },
      },
      orderBy: { name: 'asc' },
    });
    return queues.map((q) => ({
      ...q, waitingCount: q._count.tickets,
    }));
  }

  async findTickets(queueId: string, status = 'WAITING') {
    return this.prisma.ticket.findMany({
      where: { queueId, status: status as any },
      orderBy: { createdAt: 'asc' },
      include: {
        customer: { select: { id: true, firstName: true, lastName: true } },
      },
    });
  }

  async pause(queueId: string) {
    return this.prisma.queue.update({ where: { id: queueId }, data: { status: 'PAUSED' } });
  }

  async resume(queueId: string) {
    return this.prisma.queue.update({ where: { id: queueId }, data: { status: 'ACTIVE' } });
  }
}
