import { Controller, Get, Post, Body, Param, Query, UseGuards, HttpCode, HttpStatus } from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { CountersService } from './counters.service';
import { TicketsService } from '../tickets/tickets.service';
import { TicketsGateway } from '../tickets/tickets.gateway';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { CurrentUser } from '../../common/decorators/current-user.decorator';

@ApiTags('Counters')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
@Controller('counters')
export class CountersController {
  constructor(
    private countersService: CountersService,
    private ticketsService: TicketsService,
    private ticketsGateway: TicketsGateway,
  ) {}

  @Get()
  findByBranch(@Query('branchId') branchId: string) {
    return this.countersService.findByBranch(branchId);
  }

  @Post(':id/open')
  open(
    @Param('id') id: string,
    @CurrentUser('id') agentId: string,
    @Body('queueIds') queueIds: string[],
  ) {
    return this.countersService.openCounter(id, agentId, queueIds);
  }

  @Post(':id/close')
  @HttpCode(HttpStatus.OK)
  close(@Param('id') id: string, @CurrentUser('id') agentId: string) {
    return this.countersService.closeCounter(id, agentId);
  }

  @Post(':id/pause')
  @HttpCode(HttpStatus.OK)
  pause(@Param('id') id: string) {
    return this.countersService.pauseCounter(id);
  }

  @Post(':id/call-next')
  @HttpCode(HttpStatus.OK)
  async callNext(@Param('id') id: string, @CurrentUser('id') agentId: string) {
    const ticket = await this.ticketsService.callNext(id, agentId);
    this.ticketsGateway.emitTicketCalled(ticket);
    return ticket;
  }
}
