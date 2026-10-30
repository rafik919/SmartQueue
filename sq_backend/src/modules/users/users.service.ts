import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../database/prisma.service';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async updateProfile(userId: string, data: any) {
    return this.prisma.user.update({
      where: { id: userId },
      data: { firstName: data.firstName, lastName: data.lastName, phone: data.phone },
      select: { id: true, email: true, firstName: true, lastName: true, phone: true },
    });
  }

  async getFavorites(userId: string) {
    const favs = await this.prisma.userFavorite.findMany({
      where: { userId },
      include: {
        organization: {
          include: {
            branches: {
              where: { isActive: true },
              select: {
                id: true, name: true,
                wilaya: { select: { id: true, name: true, code: true } },
                commune: { select: { id: true, name: true } },
              },
              take: 5,
            },
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });

    return favs.map((f) => ({
      ...f.organization,
      city: f.organization.branches[0]?.wilaya?.name ?? '',
      branches: f.organization.branches.map((b) => ({
        ...b,
        city: b.commune?.name ?? b.wilaya?.name ?? '',
        openNow: false,
      })),
    }));
  }

  async toggleFavorite(userId: string, orgId: string, add: boolean) {
    if (add) {
      await this.prisma.userFavorite.upsert({
        where: { userId_organizationId: { userId, organizationId: orgId } },
        create: { userId, organizationId: orgId },
        update: {},
      });
    } else {
      await this.prisma.userFavorite.deleteMany({
        where: { userId, organizationId: orgId },
      });
    }
    return { success: true };
  }

  async registerFcmToken(userId: string, token: string) {
    const user = await this.prisma.user.findUnique({ where: { id: userId } });
    if (!user) return;
    const tokens = [...new Set([...user.fcmTokens, token])].slice(-5);
    await this.prisma.user.update({
      where: { id: userId },
      data: { fcmTokens: tokens },
    });
  }
}
