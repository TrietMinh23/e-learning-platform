import { MigrationInterface, QueryRunner } from "typeorm";

export class  $npmConfigName1717907894709 implements MigrationInterface {
    name = ' $npmConfigName1717907894709'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`user\` ADD \`ABCD\` varchar(52) NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE \`user\` DROP COLUMN \`ABCD\``);
    }

}
