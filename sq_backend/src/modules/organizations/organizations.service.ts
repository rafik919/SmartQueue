import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../database/prisma.service';

@Injectable()
export class OrganizationsService {
  constructor(private prisma: PrismaService) {}

  async findAll(params: {
    q?: string; wilayaId?: number; communeId?: number;
    type?: string; page?: number; limit?: number;
  }) {
    const { q, wilayaId, communeId, type, page = 1, limit = 20 } = params;
    const skip = (page - 1) * limit;

    const where: any = { isActive: true };

    if (q) {
      where.OR = [
        { name: { contains: q, mode: 'insensitive' } },
        { branches: { some: { wilaya: { name: { contains: q, mode: 'insensitive' } } } } },
        { branches: { some: { commune: { name: { contains: q, mode: 'insensitive' } } } } },
      ];
    }

    if (type) where.type = type;

    // Filtrage par wilaya ou commune via les branches
    const branchWhere: any = { isActive: true };
    if (wilayaId) branchWhere.wilayaId = wilayaId;
    if (communeId) branchWhere.communeId = communeId;

    if (wilayaId || communeId) {
      where.branches = { some: branchWhere };
    }

    const [items, total] = await Promise.all([
      this.prisma.organization.findMany({
        where, skip, take: limit,
        select: {
          id: true, name: true, nameAr: true, type: true, logoUrl: true, slug: true,
          branches: {
            where: branchWhere,
            select: {
              id: true, name: true, latitude: true, longitude: true,
              wilaya: { select: { id: true, name: true, code: true } },
              commune: { select: { id: true, name: true } },
            },
            take: 5,
          },
        },
        orderBy: { name: 'asc' },
      }),
      this.prisma.organization.count({ where }),
    ]);

    // Calculer openNow pour chaque agence
    const now = new Date();
    const dayOfWeek = now.getDay();
    const timeStr = `${String(now.getHours()).padStart(2,'0')}:${String(now.getMinutes()).padStart(2,'0')}`;

    const result = await Promise.all(items.map(async (org) => {
      const branches = await Promise.all(org.branches.map(async (branch) => {
        const hours = await this.prisma.openingHours.findUnique({
          where: { branchId_dayOfWeek: { branchId: branch.id, dayOfWeek } },
        });
        const openNow = hours
          ? !hours.isClosed && timeStr >= hours.openTime && timeStr <= hours.closeTime
          : false;
        return {
          ...branch,
          city: branch.commune?.name ?? branch.wilaya?.name ?? '',
          openNow,
        };
      }));
      return {
        ...org,
        city: branches[0]?.wilaya?.name ?? '',
        branches,
      };
    }));

    return { items: result, total, page, limit, pages: Math.ceil(total / limit) };
  }

  async findOne(id: string) {
    const org = await this.prisma.organization.findUnique({
      where: { id },
      include: {
        branches: {
          where: { isActive: true },
          include: {
            wilaya: true,
            commune: true,
            queues: {
              where: { isActive: true },
              include: { service: true },
            },
          },
        },
      },
    });
    if (!org) throw new NotFoundException('Organisation introuvable');
    return org;
  }

  async getWilayas() {
    return this.prisma.wilaya.findMany({ orderBy: { id: 'asc' } });
  }

  async getCommunes(wilayaId?: number) {
    return this.prisma.commune.findMany({
      where: wilayaId ? { wilayaId } : undefined,
      orderBy: { name: 'asc' },
      include: { wilaya: { select: { id: true, name: true, code: true } } },
    });
  }
}
