/*
  Warnings:

  - A unique constraint covering the columns `[course_id]` on the table `CourseInstructor` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[instructor_id]` on the table `CourseInstructor` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[course_id]` on the table `MonthlyCourseIncome` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX `FK_Section_Section` ON `Section`;

-- CreateIndex
CREATE UNIQUE INDEX `CourseInstructor_course_id_key` ON `CourseInstructor`(`course_id`);

-- CreateIndex
CREATE UNIQUE INDEX `CourseInstructor_instructor_id_key` ON `CourseInstructor`(`instructor_id`);

-- CreateIndex
CREATE UNIQUE INDEX `MonthlyCourseIncome_course_id_key` ON `MonthlyCourseIncome`(`course_id`);
