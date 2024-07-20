/*
  Warnings:

  - You are about to drop the `Item` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Quiz` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `QuizQA` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `QuizQAAnswerDetail` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `StudentAnswerQA` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `CourseProgress` DROP FOREIGN KEY `FK_CourseProgress_Item`;

-- DropForeignKey
ALTER TABLE `Item` DROP FOREIGN KEY `FK_Item_Item`;

-- DropForeignKey
ALTER TABLE `Item` DROP FOREIGN KEY `FK_Item_Section`;

-- DropForeignKey
ALTER TABLE `ItemHistory` DROP FOREIGN KEY `FK_ItemHistory_Item`;

-- DropForeignKey
ALTER TABLE `Lecture` DROP FOREIGN KEY `FK_Lecture_Item`;

-- DropForeignKey
ALTER TABLE `Question` DROP FOREIGN KEY `FK_Question_Item`;

-- DropForeignKey
ALTER TABLE `Quiz` DROP FOREIGN KEY `FK_Quiz_Item`;

-- DropForeignKey
ALTER TABLE `QuizQA` DROP FOREIGN KEY `FK_QuizQA_Quiz`;

-- DropForeignKey
ALTER TABLE `QuizQA` DROP FOREIGN KEY `FK_QuizQA_QuizQAAnswerDetail`;

-- DropForeignKey
ALTER TABLE `QuizQAAnswerDetail` DROP FOREIGN KEY `FK_QuizQAAnswerDetail_QuizQA`;

-- DropForeignKey
ALTER TABLE `StudentAnswerQA` DROP FOREIGN KEY `FK_StudentAnswerQA_EnrollementCourse`;

-- DropForeignKey
ALTER TABLE `StudentAnswerQA` DROP FOREIGN KEY `FK_StudentAnswerQA_QuizQAAnswerDetail`;

-- DropTable
DROP TABLE `Item`;

-- DropTable
DROP TABLE `Quiz`;

-- DropTable
DROP TABLE `QuizQA`;

-- DropTable
DROP TABLE `QuizQAAnswerDetail`;

-- DropTable
DROP TABLE `StudentAnswerQA`;
