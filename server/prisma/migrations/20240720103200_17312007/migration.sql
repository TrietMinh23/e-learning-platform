/*
  Warnings:

  - You are about to drop the `CourseInstructorHistory` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `CourseInstructorHistory` DROP FOREIGN KEY `FK_CourseInstructor_CourseID`;

-- DropForeignKey
ALTER TABLE `CourseInstructorHistory` DROP FOREIGN KEY `FK_CourseInstructor_InstructorID`;

-- DropTable
DROP TABLE `CourseInstructorHistory`;
