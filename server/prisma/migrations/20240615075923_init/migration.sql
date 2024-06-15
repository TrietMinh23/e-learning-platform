/*
  Warnings:

  - You are about to drop the `Post1` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Post1` DROP FOREIGN KEY `Post1_authorId_fkey`;

-- DropTable
DROP TABLE `Post1`;
