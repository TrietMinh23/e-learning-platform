import { ArgumentsHost, Catch, ExceptionFilter } from '@nestjs/common';
import { Request, Response } from 'express';
import { UpdateValuesMissingError } from 'typeorm';

@Catch(UpdateValuesMissingError)
export class UpdateValuesMissingErrorFilter implements ExceptionFilter {
  catch(exception: UpdateValuesMissingError, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();

    console.log(exception);

    response.status(400).json({
      statusCode: 400,
      timestamp: new Date().toISOString(),
      path: request.url,
    });
  }
}
