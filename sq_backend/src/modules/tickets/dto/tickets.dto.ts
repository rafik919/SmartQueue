import { IsString, IsOptional, IsInt, Min, Max } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateTicketDto {
  @ApiProperty() @IsString() queueId: string;
  @ApiProperty() @IsString() branchId: string;
  @ApiProperty() @IsString() serviceId: string;
  @ApiProperty({ required: false, default: 'MOBILE' })
  @IsOptional() @IsString() source?: string;
}

export class CancelTicketDto {
  @ApiProperty({ required: false })
  @IsOptional() @IsString() reason?: string;
}

export class FeedbackDto {
  @ApiProperty({ minimum: 1, maximum: 5 })
  @IsInt() @Min(1) @Max(5) rating: number;
  @ApiProperty({ required: false })
  @IsOptional() @IsString() comment?: string;
  @ApiProperty({ required: false, isArray: true })
  @IsOptional() tags?: string[];
}

export class TransferTicketDto {
  @ApiProperty() @IsString() targetQueueId: string;
  @ApiProperty({ required: false }) @IsOptional() @IsString() reason?: string;
}
