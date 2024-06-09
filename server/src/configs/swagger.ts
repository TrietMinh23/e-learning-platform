import { INestApplication } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';

export function setupSwagger(app: INestApplication): void {
  const config = new DocumentBuilder()
    .addBearerAuth()
    .setTitle('E-Learning API')
    .setDescription('The E-Learning API description')
    .setVersion('1.0')
    .addTag('elearning')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);
}
