import { Controller, Get, Post, Param, Query, UseGuards, HttpCode, HttpStatus } from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { QueuesService } from './queues.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { Public } from '../../common/decorators/public.decorator';

@ApiTags('Queues')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
@Controller('queues')
export class QueuesController {
  constructor(private service: QueuesService) {}

  @Public()
  @Get()
  findByBranch(@Query('branchId') branchId: string) {
    return this.service.findByBranch(branchId);
  }

  @Get(':id/tickets')
  findTickets(@Param('id') id: string, @Query('status') status?: string) {
    return this.service.findTickets(id, status);
  }

  @Post(':id/pause')
  @HttpCode(HttpStatus.OK)
  pause(@Param('id') id: string) { return this.service.pause(id); }

  @Post(':id/resume')
  @HttpCode(HttpStatus.OK)
  resume(@Param('id') id: string) { return this.service.resume(id); }
}
