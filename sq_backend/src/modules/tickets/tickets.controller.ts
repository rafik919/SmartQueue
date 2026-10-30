import {
  Controller, Post, Get, Body, Param,
  Query, UseGuards, HttpCode, HttpStatus,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { TicketsService } from './tickets.service';
import { TicketsGateway } from './tickets.gateway';
import {
  CreateTicketDto, CancelTicketDto, FeedbackDto, TransferTicketDto,
} from './dto/tickets.dto';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';

@ApiTags('Tickets')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
@Controller('tickets')
export class TicketsController {
  constructor(
    private ticketsService: TicketsService,
    private ticketsGateway: TicketsGateway,
  ) {}

  @Post()
  @ApiOperation({ summary: 'Prendre un ticket' })
  async create(@Body() dto: CreateTicketDto, @CurrentUser('id') userId: string) {
    const ticket = await this.ticketsService.create(dto, userId);
    this.ticketsGateway.emitQueueUpdate(ticket.queueId);
    return ticket;
  }

  @Get('mine')
  @ApiOperation({ summary: 'Mon historique de tickets' })
  findMine(
    @CurrentUser('id') userId: string,
    @Query('status') status?: string,
    @Query('page') page = 1,
    @Query('limit') limit = 20,
  ) {
    return this.ticketsService.findMyTickets(userId, status, +page, +limit);
  }

  @Get(':id')
  findOne(@Param('id') id: string, @CurrentUser('id') userId: string) {
    return this.ticketsService.findOne(id, userId);
  }

  @Get(':id/qr')
  getQr(@Param('id') id: string) {
    return this.ticketsService.getQrData(id);
  }

  @Post(':id/cancel')
  @HttpCode(HttpStatus.OK)
  async cancel(
    @Param('id') id: string,
    @CurrentUser('id') userId: string,
    @Body() dto: CancelTicketDto,
  ) {
    const ticket = await this.ticketsService.cancel(id, userId, dto);
    this.ticketsGateway.emitQueueUpdate(ticket.queueId);
    this.ticketsGateway.emitTicketUpdate(ticket.id, ticket);
    return ticket;
  }

  @Post(':id/feedback')
  submitFeedback(
    @Param('id') id: string,
    @CurrentUser('id') userId: string,
    @Body() dto: FeedbackDto,
  ) {
    return this.ticketsService.submitFeedback(id, userId, dto);
  }

  // ── Routes Agent ────────────────────────────────────────────────────────────
  @Post(':id/complete')
  @HttpCode(HttpStatus.OK)
  async complete(
    @Param('id') id: string,
    @CurrentUser('id') agentId: string,
    @Body('notes') notes?: string,
  ) {
    const ticket = await this.ticketsService.complete(id, agentId, notes);
    this.ticketsGateway.emitQueueUpdate(ticket.queueId);
    this.ticketsGateway.emitTicketUpdate(ticket.id, ticket);
    return ticket;
  }

  @Post(':id/mark-missed')
  @HttpCode(HttpStatus.OK)
  async markMissed(@Param('id') id: string) {
    const ticket = await this.ticketsService.markMissed(id);
    this.ticketsGateway.emitTicketUpdate(ticket.id, ticket);
    return ticket;
  }

  @Post(':id/transfer')
  @HttpCode(HttpStatus.OK)
  async transfer(
    @Param('id') id: string,
    @CurrentUser('id') agentId: string,
    @Body() dto: TransferTicketDto,
  ) {
    const newTicket = await this.ticketsService.transfer(id, agentId, dto);
    this.ticketsGateway.emitQueueUpdate(dto.targetQueueId);
    return newTicket;
  }
}
