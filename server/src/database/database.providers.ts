import { DataSource } from 'typeorm';
import * as fs from 'fs';

export const databaseProviders = [
  {
    provide: 'DATA_SOURCE',
    useFactory: async () => {
      const dataSource = new DataSource({
        type: 'mysql',
        host: process.env.DATABASE_HOST,
        port: +process.env.DATABASE_PORT,
        username: process.env.DATABASE_USER,
        password: process.env.DATABASE_PASS,
        database: process.env.DATABASE_NAME,
        entities: [__dirname + '/../**/*.entity{.ts,.js}'],
        synchronize: true,
        ssl: {
          ca: fs.readFileSync('./src/certificates/ca.pem').toString(),
          rejectUnauthorized: true,
        },
      });

      return dataSource.initialize();
    },
  },
];
