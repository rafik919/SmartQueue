import { Controller, Get, Param, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation } from '@nestjs/swagger';
import { BranchesService } from './branches.service';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';
import { Public } from '../../common/decorators/public.decorator';

@ApiTags('Branches')
@UseGuards(JwtAuthGuard)
@Controller('branches')
export class BranchesController {
  constructor(private service: BranchesService) {}

  @Public()
  @Get(':id')
  @ApiOperation({ summary: 'Détail agence avec files et statuts' })
  findOne(@Param('id') id: string) {
    return this.service.findOne(id);
  }
}
