-- use this file to create table on the database
drop database 'defaultdb' if exists;

create database 'defaultdb';

-- Triet
CREATE TABLE
  User () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Admin () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Learner () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Instructor () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  VipInstructor () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Category () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  SubCategory () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Course () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  CourseObjective () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Section () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Item () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  ItemHistory () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Lecture () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  LectureSubtitle () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Quiz () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  QuizQA () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  QuizQAAnswerDetail () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  StudentAnswerQA () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Question () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Answer () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  ShoppingCart () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  EnrollementCourse () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Thu
CREATE TABLE
  CourseInstructor (
    course_id MEDIUMINT UNSIGNED NOT NULL,
    instructor_id MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT PK_CourseInstructor PRIMARY KEY (course_id, instructor_id),
    CONSTRAINT FK_Course FOREIGN KEY (course_id) REFERENCES Course (id),
    CONSTRAINT FK_Instructor FOREIGN KEY (instructor_id) REFERENCES Instructor (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  CourseInstructorHistory (
    course_id MEDIUMINT UNSIGNED NOT NULL,
    instructor_id MEDIUMINT UNSIGNED NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    course_profit_percent SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT PK_CourseInstructorHistory PRIMARY KEY (course_id, instructor_id, create_at),
    CONSTRAINT FK_CourseInstructor_CourseID FOREIGN KEY (course_id) REFERENCES CourseInstructor (course_id),
    CONSTRAINT FK_CourseInstructor_InstructorID FOREIGN KEY (instructor_id) REFERENCES CourseInstructor (instructor_id),
    CHECK (
      course_profit_percent >= 0
      AND course_profit_percent <= 100
    )
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  CourseProgress (
    course_id MEDIUMINT UNSIGNED NOT NULL,
    section_id SMALLINT UNSIGNED NOT NULL,
    item_id SMALLINT UNSIGNED NOT NULL,
    learner_id MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT PK_CourseProgress PRIMARY KEY (course_id, section_id, item_id, learner_id),
    CONSTRAINT FK_EnrollementCourse_CourseID FOREIGN KEY (course_id) REFERENCES EnrollementCourse (course_id),
    CONSTRAINT FK_EnrollementCourse_LearnerID FOREIGN KEY (learner_id) REFERENCES EnrollementCourse (learner_id),
    CONSTRAINT FK_Item_SectionID FOREIGN KEY (section_id) REFERENCES Item (section_id),
    CONSTRAINT FK_Item_ItemID FOREIGN KEY (item_id) REFERENCES Item (id),
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Adjustment (
    course_id MEDIUMINT UNSIGNED NOT NULL,
    admin_id MEDIUMINT UNSIGNED NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    content VARCHAR(10000) NOT NULL,
    CONSTRAINT PK_Adjustment (course_id, admin_id, create_at),
    CONSTRAINT FK_Course FOREIGN KEY (course_id) REFERENCES Course (id),
    CONSTRAINT FK_Admin FOREIGN KEY (admin_id) REFERENCES Admin (admin_id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Notification (
    course_id MEDIUMINT UNSIGNED NOT NULL,
    type ENUM (
      'adjustment',
      'promotional_program',
      'course_highlight',
      'price_conversion',
      'start_of_course',
      'end_of_course'
    ) NOT NULL,
    content VARCHAR(10000) NOT NULL,
    CONSTRAINT PK_Notification PRIMARY KEY (course_id, type),
    CONSTRAINT FK_Course FOREIGN KEY (course_id) REFERENCES Course (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  PromotionalProgram (
    id TINYINT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    content VARCHAR(10000) NOT NULL,
    day_start DATE NOT NULL,
    day_end DATE NOT NULL,
    repeating_type ENUM ('weekly', 'monthly', 'yearly') NOT NULL,
    tier_difference TINYINT UNSIGNED NOT NULL,
    CONSTRAINT PK_PromotionalProgram PRIMARY KEY (id),
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  PromotionalProgramHistory (
    id TINYINT UNSIGNED NOT NULL,
    create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tier_difference TINYINT UNSIGNED NOT NULL,
    CONSTRAINT PK_PromotionalProgramHistory PRIMARY KEY (id, create_at),
    CONSTRAINT FK_PromotionalProgram FOREIGN KEY (id) REFERENCES PromotionalProgram (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Tier (
    id TINYINT UNSIGNED AUTO_INCREMENT,
    price MEDIUMINT UNSIGNED NOT NULL
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  CourseHighlight (
    id MEDIUMINT UNSIGNED NOT NULL,
    downloadable_documents SMALLINT UNSIGNED NOT NULL,
    students_enrolled MEDIUMINT UNSIGNED NOT NULL,
    average_rating FLOAT UNSIGNED NOT NULL,
    sale_price MEDIUMINT UNSIGNED NOT NULL,
    no_sections SMALLINT UNSIGNED NOT NULL,
    duration MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT PK_CourseHighlight PRIMARY KEY (id),
    CONSTRAINT FK_Course FOREIGN KEY (id) REFERENCES Course (id),
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  Payment (
    id MEDIUMINT UNSIGNED AUTO_INCREMENT,
    date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_price MEDIUMINT UNSIGNED NOT NULL,
    total_course MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT PK_Payment PRIMARY KEY (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  MonthlyCourseIncome (
    course_id MEDIUMINT UNSIGNED NOT NULL,
    date DATE NOT NULL,
    final_amount INT UNSIGNED NOT NULL,
    CONSTRAINT PK_MonthlyCourseIncome PRIMARY KEY (course_id, date),
    CONSTRAINT FK_Course FOREIGN KEY (course_id) REFERENCES Course (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE
  MonthlyCourseIncomeVipInstructor (
    course_id MEDIUMINT UNSIGNED NOT NULL,
    date DATE NOT NULL,
    vip_instructor_id MEDIUMINT UNSIGNED NOT NULL,
    revenue INT UNSIGNED NOT NULL,
    CONSTRAINT PK_MonthlyCourseIncomeVipInstructor PRIMARY KEY (course_id, date, vip_instructor_id),
    CONSTRAINT FK_Course FOREIGN KEY (course_id) REFERENCES MonthlyCourseIncome (course_id),
    CONSTRAINT FK_VipInstructor FOREIGN KEY (vip_instructor_id) REFERENCES VipInstructor (vip_instructor_id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;