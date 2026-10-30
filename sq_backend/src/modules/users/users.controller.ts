import {
  Controller, Get, Post, Delete, Patch,
  Body, Query, Param, UseGuards,
} from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { UsersService } from './users.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';
import { TicketsService } from '../tickets/tickets.service';

@ApiTags('Users')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
@Controller('users')
export class UsersController {
  constructor(
    private usersService: UsersService,
    private ticketsService: TicketsService,
  ) {}

  @Patch('me')
  updateMe(@CurrentUser('id') userId: string, @Body() body: any) {
    return this.usersService.updateProfile(userId, body);
  }

  // ── Tickets ────────────────────────────────────────────────────────────────
  @Get('me/tickets')
  getMyTickets(
    @CurrentUser('id') userId: string,
    @Query('status') status?: string,
    @Query('page') page = 1,
    @Query('limit') limit = 20,
  ) {
    return this.ticketsService.findMyTickets(userId, status, +page, +limit);
  }

  // ── Favoris ────────────────────────────────────────────────────────────────
  @Get('me/favorites')
  getFavorites(@CurrentUser('id') userId: string) {
    return this.usersService.getFavorites(userId);
  }

  @Post('me/favorites/:orgId')
  addFavorite(
    @CurrentUser('id') userId: string,
    @Param('orgId') orgId: string,
  ) {
    return this.usersService.toggleFavorite(userId, orgId, true);
  }

  @Delete('me/favorites/:orgId')
  removeFavorite(
    @CurrentUser('id') userId: string,
    @Param('orgId') orgId: string,
  ) {
    return this.usersService.toggleFavorite(userId, orgId, false);
  }

  // ── FCM Token ──────────────────────────────────────────────────────────────
  @Post('me/fcm-token')
  registerFcmToken(
    @CurrentUser('id') userId: string,
    @Body('token') token: string,
  ) {
    return this.usersService.registerFcmToken(userId, token);
  }
}
