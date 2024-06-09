import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', length: 52, nullable: false })
  name: string;

  @Column({ type: 'varchar', length: 52, nullable: false })
  ABCD: string;

  @Column({
    type: 'varchar',
    length: 320,
    unique: true,
    nullable: false,
  })
  email: string;

  @Column({
    type: 'varchar',
    length: 64,
    nullable: false,
  })
  password: string;
}
