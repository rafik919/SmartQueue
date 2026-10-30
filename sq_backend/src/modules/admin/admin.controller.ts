import {
  Controller, Get, Post, Patch, Delete,
  Body, Param, Query, UseGuards,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { Role } from '@prisma/client';
import { AdminService } from './admin.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { RolesGuard } from '../../common/guards/roles.guard';
import { Roles } from '../../common/decorators/roles.decorator';
import { CurrentUser } from '../../common/decorators/current-user.decorator';

@ApiTags('Admin')
@UseGuards(JwtAuthGuard, RolesGuard)
@ApiBearerAuth()
@Controller('admin')
export class AdminController {
  constructor(private adminService: AdminService) {}

  // ── Super Admin only ───────────────────────────────────────
  @Roles(Role.SUPER_ADMIN)
  @Post('organizations')
  createOrg(@Body() body: any) {
    return this.adminService.createOrganization(body);
  }

  @Roles(Role.SUPER_ADMIN)
  @Patch('organizations/:id')
  updateOrg(@Param('id') id: string, @Body() body: any) {
    return this.adminService.updateOrganization(id, body);
  }

  @Roles(Role.SUPER_ADMIN)
  @Delete('organizations/:id')
  deleteOrg(@Param('id') id: string) {
    return this.adminService.deleteOrganization(id);
  }

  @Roles(Role.SUPER_ADMIN)
  @Get('organizations/:id/users')
  getOrgUsers(@Param('id') id: string) {
    return this.adminService.getOrgUsers(id);
  }

  @Roles(Role.SUPER_ADMIN)
  @Post('users')
  createUser(@Body() body: any) {
    return this.adminService.createUser(body);
  }

  @Roles(Role.SUPER_ADMIN)
  @Post('branches')
  createBranch(@Body() body: any) {
    return this.adminService.createBranch(body);
  }

  @Roles(Role.SUPER_ADMIN)
  @Patch('branches/:id')
  updateBranch(@Param('id') id: string, @Body() body: any) {
    return this.adminService.updateBranch(id, body);
  }

  @Roles(Role.SUPER_ADMIN)
  @Delete('branches/:id')
  deleteBranch(@Param('id') id: string) {
    return this.adminService.deleteBranch(id);
  }

  @Roles(Role.SUPER_ADMIN)
  @Get('stats')
  getStats() {
    return this.adminService.getStats();
  }

  // ── Agent / Org Admin routes ───────────────────────────────
  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER, Role.AGENT)
  @Get('agent/me')
  getMe(@CurrentUser() user: any) {
    return this.adminService.getAgentMe(user.id);
  }

  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER, Role.AGENT)
  @Get('agent/tickets')
  getTickets(
    @CurrentUser() user: any,
    @Query('status') status?: string,
  ) {
    return this.adminService.getAgentTickets(user.organizationId, status);
  }

  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER, Role.AGENT)
  @Get('agent/stats')
  getAgentStats(@CurrentUser() user: any) {
    return this.adminService.getAgentStats(user.organizationId);
  }

  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER)
  @Get('agent/services')
  getServices(@CurrentUser() user: any) {
    return this.adminService.getServices(user.organizationId);
  }

  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER)
  @Post('agent/services')
  createService(@CurrentUser() user: any, @Body() body: any) {
    return this.adminService.createService({ ...body, organizationId: user.organizationId });
  }

  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER)
  @Patch('agent/services/:id')
  updateService(@Param('id') id: string, @Body() body: any) {
    return this.adminService.updateService(id, body);
  }

  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER)
  @Delete('agent/services/:id')
  deleteService(@Param('id') id: string) {
    return this.adminService.deleteService(id);
  }

  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER)
  @Get('agent/queues')
  getQueues(@CurrentUser() user: any) {
    return this.adminService.getQueues(user.organizationId);
  }

  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER)
  @Post('agent/queues')
  createQueue(@CurrentUser() user: any, @Body() body: any) {
    return this.adminService.createQueue({ ...body, organizationId: user.organizationId });
  }

  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER)
  @Patch('agent/branches/:id/hours')
  updateHours(@Param('id') id: string, @Body() body: any) {
    return this.adminService.updateBranchHours(id, body.hours);
  }

  @Roles(Role.ORG_ADMIN, Role.BRANCH_MANAGER, Role.AGENT)
  @Post('agent/tickets/call-next')
  callNext(@Body() body: any) {
    return this.adminService.callNextTicket(body.queueId);
  }
}