import { Controller, Get, Param, Query, UseGuards } from '@nestjs/common';
import { ApiTags, ApiOperation } from '@nestjs/swagger';
import { OrganizationsService } from './organizations.service';
import { Public } from '../../common/decorators/public.decorator';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard';

@ApiTags('Organizations')
@UseGuards(JwtAuthGuard)
@Controller('organizations')
export class OrganizationsController {
  constructor(private service: OrganizationsService) {}

  @Public()
  @Get()
  @ApiOperation({ summary: 'Liste des établissements (public)' })
  findAll(
    @Query('q') q?: string,
    @Query('wilayaId') wilayaId?: string,
    @Query('communeId') communeId?: string,
    @Query('type') type?: string,
    @Query('page') page = 1,
    @Query('limit') limit = 20,
  ) {
    return this.service.findAll({
      q, type,
      wilayaId: wilayaId ? +wilayaId : undefined,
      communeId: communeId ? +communeId : undefined,
      page: +page, limit: +limit,
    });
  }

  @Public()
  @Get('wilayas')
  @ApiOperation({ summary: 'Liste des wilayas' })
  getWilayas() {
    return this.service.getWilayas();
  }

  @Public()
  @Get('communes')
  @ApiOperation({ summary: 'Liste des communes' })
  getCommunes(@Query('wilayaId') wilayaId?: string) {
    return this.service.getCommunes(wilayaId ? +wilayaId : undefined);
  }

  @Public()
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.service.findOne(id);
  }
}
