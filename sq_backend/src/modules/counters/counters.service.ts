import { Injectable, NotFoundException, Logger } from '@nestjs/common';
import { PrismaService } from '../../database/prisma.service';

@Injectable()
export class CountersService {
  private readonly logger = new Logger(CountersService.name);

  constructor(private prisma: PrismaService) {}

  async findByBranch(branchId: string) {
    return this.prisma.counter.findMany({
      where: { branchId, isActive: true },
      include: {
        counterQueues: { include: { queue: { include: { service: true } } } },
      },
      orderBy: { number: 'asc' },
    });
  }

  async openCounter(counterId: string, agentId: string, queueIds: string[]) {
    const counter = await this.prisma.counter.findUnique({ where: { id: counterId } });
    if (!counter) throw new NotFoundException('Guichet introuvable');

    // Assigner les files
    await this.prisma.counterQueue.deleteMany({ where: { counterId } });
    await this.prisma.counterQueue.createMany({
      data: queueIds.map((queueId, i) => ({ counterId, queueId, priority: i })),
    });

    const updated = await this.prisma.counter.update({
      where: { id: counterId },
      data: { status: 'OPEN', agentId },
    });

    // Créer session agent
    await this.prisma.agentSession.create({
      data: {
        agentId, branchId: counter.branchId, counterId,
      },
    });

    this.logger.log(`Counter opened: ${counter.name} by ${agentId}`);
    return updated;
  }

  async closeCounter(counterId: string, agentId: string) {
    const updated = await this.prisma.counter.update({
      where: { id: counterId },
      data: { status: 'CLOSED', agentId: null },
    });

    await this.prisma.agentSession.updateMany({
      where: { counterId, agentId, isActive: true },
      data: { endAt: new Date(), isActive: false },
    });

    return updated;
  }

  async pauseCounter(counterId: string) {
    return this.prisma.counter.update({
      where: { id: counterId },
      data: { status: 'PAUSED' },
    });
  }
}
