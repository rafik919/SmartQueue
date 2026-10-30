import { IsEmail, IsString, MinLength, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class RegisterDto {
  @ApiProperty({ example: 'sara.benali@gmail.com' })
  @IsEmail()
  email: string;

  @ApiProperty({ example: 'Motdepasse!123' })
  @IsString()
  @MinLength(8)
  password: string;

  @ApiProperty({ example: 'Sara' })
  @IsString()
  firstName: string;

  @ApiProperty({ example: 'Benali' })
  @IsString()
  lastName: string;

  @ApiProperty({ required: false, example: '+213555001122' })
  @IsOptional()
  @IsString()
  phone?: string;
}

export class LoginDto {
  @ApiProperty({ example: 'sara.benali@gmail.com' })
  @IsEmail()
  email: string;

  @ApiProperty({ example: 'Motdepasse!123' })
  @IsString()
  password: string;
}

export class RefreshTokenDto {
  @ApiProperty()
  @IsString()
  refreshToken: string;
}

export class ForgotPasswordDto {
  @ApiProperty()
  @IsEmail()
  email: string;
}

export class RegisterFcmTokenDto {
  @ApiProperty()
  @IsString()
  token: string;
}
