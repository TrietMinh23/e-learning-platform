/*
  Warnings:

  - You are about to drop the column `type` on the `Instructor` table. All the data in the column will be lost.
  - The primary key for the `Notification` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `type` on the `Notification` table. All the data in the column will be lost.
  - Added the required column `instructor_type` to the `Instructor` table without a default value. This is not possible if the table is not empty.
  - Added the required column `notification_type` to the `Notification` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Instructor` DROP COLUMN `type`,
    ADD COLUMN `instructor_type` ENUM('instructor', 'vip_instructor') NOT NULL;

-- AlterTable
ALTER TABLE `Notification` DROP PRIMARY KEY,
    DROP COLUMN `type`,
    ADD COLUMN `notification_type` ENUM('adjustment', 'promotional_program', 'course_highlight', 'price_conversion', 'start_of_course', 'end_of_course') NOT NULL,
    ADD PRIMARY KEY (`course_id`, `notification_type`);
