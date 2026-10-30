import {
  ExceptionFilter, Catch, ArgumentsHost,
  HttpException, HttpStatus, Logger,
} from '@nestjs/common';
import { Response } from 'express';

@Catch()
export class GlobalExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger(GlobalExceptionFilter.name);

  catch(exception: unknown, host: ArgumentsHost) {
    const ctx      = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request  = ctx.getRequest();

    const status = exception instanceof HttpException
      ? exception.getStatus()
      : HttpStatus.INTERNAL_SERVER_ERROR;

    const message = exception instanceof HttpException
      ? exception.getResponse()
      : 'Internal server error';

    const errorResponse = {
      success: false,
      error: {
        statusCode: status,
        message: typeof message === 'string'
          ? message
          : (message as any).message || 'Error',
        code: typeof message === 'object' ? (message as any).error : undefined,
        timestamp: new Date().toISOString(),
        path: request.url,
      },
    };

    if (status >= 500) {
      this.logger.error(exception);
    }

    response.status(status).json(errorResponse);
  }
}
