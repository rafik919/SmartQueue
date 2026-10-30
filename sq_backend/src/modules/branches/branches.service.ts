import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../database/prisma.service';

@Injectable()
export class BranchesService {
  constructor(private prisma: PrismaService) {}

  async findOne(id: string) {
    const branch = await this.prisma.branch.findUnique({
      where: { id },
      include: {
        wilaya: true,
        commune: true,
        openingHours: { orderBy: { dayOfWeek: 'asc' } },
        queues: {
          where: { isActive: true },
          include: {
            service: true,
            tickets: {
              where: { status: 'WAITING' },
              select: { id: true },
            },
          },
        },
        counters: {
          where: { isActive: true },
          select: { id: true, name: true, number: true, status: true, agentId: true },
        },
      },
    });
    if (!branch) throw new NotFoundException('Agence introuvable');

    // Calculer openNow
    const now = new Date();
    const dayOfWeek = now.getDay();
    const timeStr = `${String(now.getHours()).padStart(2,'0')}:${String(now.getMinutes()).padStart(2,'0')}`;
    const todayHours = branch.openingHours.find((h) => h.dayOfWeek === dayOfWeek);
    const openNow = todayHours
      ? !todayHours.isClosed && timeStr >= todayHours.openTime && timeStr <= todayHours.closeTime
      : false;
    const openUntil = todayHours?.closeTime;

    // Enrichir les files avec le compte de tickets en attente
    const queues = branch.queues.map((q) => ({
      id: q.id, name: q.name, prefix: q.prefix,
      status: q.status, avgServiceTime: q.avgServiceTime,
      waitingCount: q.tickets.length,
      avgWaitMin: Math.ceil(q.tickets.length * q.avgServiceTime / Math.max(1,
        branch.counters.filter((c) => c.status === 'OPEN' || c.status === 'BUSY').length)),
      service: { id: q.service.id, name: q.service.name, icon: null, color: null },
    }));

    return {
      id: branch.id, name: branch.name, address: branch.address,
      city: branch.commune?.name ?? branch.wilaya?.name ?? '',
      wilaya: branch.wilaya ? { id: branch.wilaya.id, name: branch.wilaya.name, code: branch.wilaya.code } : null,
      commune: branch.commune ? { id: branch.commune.id, name: branch.commune.name } : null,
      phone: branch.phone,
      latitude: branch.latitude, longitude: branch.longitude,
      openNow, openUntil,
      queues,
    };
  }

  async isOpenNow(branchId: string): Promise<boolean> {
    const now = new Date();
    const dayOfWeek = now.getDay();
    const timeStr = `${String(now.getHours()).padStart(2,'0')}:${String(now.getMinutes()).padStart(2,'0')}`;
    const hours = await this.prisma.openingHours.findUnique({
      where: { branchId_dayOfWeek: { branchId, dayOfWeek } },
    });
    if (!hours) return true;
    return !hours.isClosed && timeStr >= hours.openTime && timeStr <= hours.closeTime;
  }
}
