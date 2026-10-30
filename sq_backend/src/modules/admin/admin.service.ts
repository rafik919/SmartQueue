import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../database/prisma.service';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AdminService {
  constructor(private prisma: PrismaService) {}

  async createOrganization(data: any) {
    return this.prisma.organization.create({
      data: {
        name: data.name, nameAr: data.nameAr, slug: data.slug,
        type: data.type, email: data.email, phone: data.phone,
        website: data.website, description: data.description,
      },
    });
  }

  async updateOrganization(id: string, data: any) {
    return this.prisma.organization.update({ where: { id }, data });
  }

  async deleteOrganization(id: string) {
    const branches = await this.prisma.branch.findMany({ where: { organizationId: id }, select: { id: true } });
    const branchIds = branches.map(b => b.id);
    await this.prisma.ticket.deleteMany({ where: { branchId: { in: branchIds } } });
    await this.prisma.agentSession.deleteMany({ where: { branchId: { in: branchIds } } });
    await this.prisma.counterQueue.deleteMany({ where: { counter: { branchId: { in: branchIds } } } });
    await this.prisma.counter.deleteMany({ where: { branchId: { in: branchIds } } });
    await this.prisma.queue.deleteMany({ where: { branchId: { in: branchIds } } });
    await this.prisma.openingHours.deleteMany({ where: { branchId: { in: branchIds } } });
    await this.prisma.branch.deleteMany({ where: { organizationId: id } });
    await this.prisma.userFavorite.deleteMany({ where: { organizationId: id } });
    await this.prisma.user.updateMany({ where: { organizationId: id }, data: { organizationId: null } });
    await this.prisma.organization.delete({ where: { id } });
    return { success: true };
  }

  async getOrgUsers(orgId: string) {
    return this.prisma.user.findMany({
      where: { organizationId: orgId },
      select: { id: true, email: true, firstName: true, lastName: true, role: true, isActive: true, createdAt: true },
    });
  }

  async createUser(data: any) {
    const exists = await this.prisma.user.findUnique({ where: { email: data.email } });
    if (exists) throw new BadRequestException('Email déjà utilisé');
    const hashed = await bcrypt.hash(data.password, 10);
    return this.prisma.user.create({
      data: {
        email: data.email, passwordHash: hashed,
        firstName: data.firstName, lastName: data.lastName,
        role: data.role, organizationId: data.organizationId,
      },
      select: { id: true, email: true, firstName: true, lastName: true, role: true, createdAt: true },
    });
  }

  async createBranch(data: any) {
    return this.prisma.branch.create({
      data: {
        name: data.name, address: data.address, phone: data.phone,
        wilayaId: +data.wilayaId,
        communeId: data.communeId ? +data.communeId : null,
        organizationId: data.organizationId,
      },
      include: { wilaya: true, commune: true },
    });
  }

  async updateBranch(id: string, data: any) {
    return this.prisma.branch.update({ where: { id }, data });
  }

  async deleteBranch(id: string) {
    await this.prisma.ticket.deleteMany({ where: { branchId: id } });
    await this.prisma.agentSession.deleteMany({ where: { branchId: id } });
    await this.prisma.counterQueue.deleteMany({ where: { counter: { branchId: id } } });
    await this.prisma.counter.deleteMany({ where: { branchId: id } });
    await this.prisma.queue.deleteMany({ where: { branchId: id } });
    await this.prisma.openingHours.deleteMany({ where: { branchId: id } });
    await this.prisma.branch.delete({ where: { id } });
    return { success: true };
  }

  async getStats() {
    const [totalOrgs, totalBranches, totalAgents, totalTickets, ticketsToday] = await Promise.all([
      this.prisma.organization.count(),
      this.prisma.branch.count(),
      this.prisma.user.count({ where: { role: { in: ['AGENT', 'BRANCH_MANAGER', 'ORG_ADMIN'] } } }),
      this.prisma.ticket.count(),
      this.prisma.ticket.count({ where: { createdAt: { gte: new Date(new Date().setHours(0,0,0,0)) } } }),
    ]);
    return { totalOrgs, totalBranches, totalAgents, totalTickets, ticketsToday };
  }

  async getAgentMe(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      include: {
        organization: {
          include: {
            branches: {
              include: {
                wilaya: true, commune: true,
                openingHours: { orderBy: { dayOfWeek: 'asc' } },
                queues: {
                  where: { isActive: true },
                  include: {
                    service: true,
                    tickets: { where: { status: 'WAITING' }, select: { id: true } },
                  },
                },
              },
            },
          },
        },
      },
    });
    if (!user) throw new NotFoundException('Utilisateur introuvable');
    return user;
  }

  async getAgentTickets(orgId: string, status?: string) {
    const branch = await this.prisma.branch.findFirst({ where: { organizationId: orgId } });
    if (!branch) return [];
    const where: any = { branchId: branch.id };
    if (status) where.status = status;
    else where.status = { in: ['WAITING', 'CALLED', 'IN_SERVICE'] };
    return this.prisma.ticket.findMany({
      where,
      include: {
        customer: { select: { firstName: true, lastName: true, phone: true } },
        queue: { select: { name: true, prefix: true } },
        service: { select: { name: true } },
      },
      orderBy: { createdAt: 'asc' },
    });
  }

  async getAgentStats(orgId: string) {
    const branch = await this.prisma.branch.findFirst({ where: { organizationId: orgId } });
    if (!branch) return { totalTickets: 0, completedTickets: 0, waitingTickets: 0, avgWaitMin: 0 };
    const today = new Date(new Date().setHours(0,0,0,0));
    const [totalTickets, completedTickets, waitingTickets] = await Promise.all([
      this.prisma.ticket.count({ where: { branchId: branch.id, createdAt: { gte: today } } }),
      this.prisma.ticket.count({ where: { branchId: branch.id, status: 'COMPLETED', createdAt: { gte: today } } }),
      this.prisma.ticket.count({ where: { branchId: branch.id, status: 'WAITING' } }),
    ]);
    return { totalTickets, completedTickets, waitingTickets, avgWaitMin: 8 };
  }

  async getServices(orgId: string) {
    return this.prisma.service.findMany({
      where: { organizationId: orgId },
      orderBy: { createdAt: 'asc' },
    });
  }

  async createService(data: any) {
    return this.prisma.service.create({
      data: {
        name: data.name, nameAr: data.nameAr,
        description: data.description,
        avgServiceTime: data.avgServiceTime || 10,
        organizationId: data.organizationId,
      },
    });
  }

  async updateService(id: string, data: any) {
    return this.prisma.service.update({ where: { id }, data });
  }

  async deleteService(id: string) {
    await this.prisma.queue.deleteMany({ where: { serviceId: id } });
    await this.prisma.service.delete({ where: { id } });
    return { success: true };
  }

  async getQueues(orgId: string) {
    const branch = await this.prisma.branch.findFirst({ where: { organizationId: orgId } });
    if (!branch) return [];
    return this.prisma.queue.findMany({
      where: { branchId: branch.id },
      include: {
        service: true,
        tickets: { where: { status: 'WAITING' }, select: { id: true } },
      },
      orderBy: { createdAt: 'asc' },
    });
  }

  async createQueue(data: any) {
    const branch = await this.prisma.branch.findFirst({ where: { organizationId: data.organizationId } });
    if (!branch) throw new NotFoundException('Agence introuvable');
    return this.prisma.queue.create({
      data: {
        name: data.name, prefix: data.prefix || 'A',
        avgServiceTime: data.avgServiceTime || 10,
        branchId: branch.id, serviceId: data.serviceId,
      },
      include: { service: true },
    });
  }

  async updateBranchHours(branchId: string, hours: any[]) {
    for (const h of hours) {
      await this.prisma.openingHours.upsert({
        where: { branchId_dayOfWeek: { branchId, dayOfWeek: h.dayOfWeek } },
        create: { branchId, dayOfWeek: h.dayOfWeek, openTime: h.openTime, closeTime: h.closeTime, isClosed: h.isClosed },
        update: { openTime: h.openTime, closeTime: h.closeTime, isClosed: h.isClosed },
      });
    }
    return { success: true };
  }

  async callNextTicket(queueId: string) {
    const next = await this.prisma.ticket.findFirst({
      where: { queueId, status: 'WAITING' },
      orderBy: { createdAt: 'asc' },
      include: {
        customer: { select: { firstName: true, lastName: true } },
        queue: { select: { name: true, prefix: true } },
        service: { select: { name: true } },
      },
    });
    if (!next) throw new NotFoundException('Aucun ticket en attente');
    return this.prisma.ticket.update({
      where: { id: next.id },
      data: { status: 'CALLED', calledAt: new Date() },
      include: {
        customer: { select: { firstName: true, lastName: true } },
        queue: { select: { name: true, prefix: true } },
        service: { select: { name: true } },
      },
    });
  }
}