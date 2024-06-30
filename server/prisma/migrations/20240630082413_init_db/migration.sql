-- This is an empty migration.
-- use this file to create table on the database
-- drop database 'defaultdb' if exists;


-- create database 'defaultdb';


-- Triet
CREATE TABLE
  User (
    id MEDIUMINT UNSIGNED NOT NULL,
    full_name VARCHAR (52) NOT NULL,
    email VARCHAR (320) NOT NULL UNIQUE,
    position VARCHAR (50) NOT NULL,
    role ENUM('admin', 'learner', 'instructor') NOT NULL,
    CONSTRAINT PK_User PRIMARY KEY (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Admin (
    user_id MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT PK_Admin PRIMARY KEY (user_id),
    CONSTRAINT FK_User FOREIGN KEY (user_id) REFERENCES User (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Learner (
    user_id MEDIUMINT UNSIGNED NOT NULL,
    learner_default_language VARCHAR (20) NOT NULL,
    CONSTRAINT PK_Learner PRIMARY KEY (user_id),
    CONSTRAINT FK_User FOREIGN KEY (user_id) REFERENCES User (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Instructor (
    user_id MEDIUMINT UNSIGNED NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR (255) NOT NULL,
    phone VARCHAR (11) NOT NULL,
    academic_degree VARCHAR (50) NOT NULL,
    working_unit VARCHAR (100) NOT NULL,
    academic_title VARCHAR (50) NOT NULL,
    description VARCHAR (1000) NOT NULL,
    type ENUM('instructor', 'vip_instructor') NOT NULL,
    CONSTRAINT PK_Instructor PRIMARY KEY (user_id),
    CONSTRAINT FK_User FOREIGN KEY (user_id) REFERENCES User (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  VipInstructor (
    instructor_id MEDIUMINT UNSIGNED NOT NULL,
    tin_number CHAR (9) NOT NULL,
    country VARCHAR (20) NOT NULL,
    tax_filling_date DATE NOT NULL,
    zip_code VARCHAR (6) NOT NULL,
    image VARCHAR (2084) NOT NULL,
    CONSTRAINT PK_VipInstructor PRIMARY KEY (instructor_id),
    CONSTRAINT FK_Instructor FOREIGN KEY (instructor_id) REFERENCES Instructor (user_id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Category (
    category_id TINYINT UNSIGNED NOT NULL,
    category_name VARCHAR (50) NOT NULL,
    CONSTRAINT PK_Category PRIMARY KEY (category_id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  SubCategory (
    id TINYINT UNSIGNED NOT NULL,
    name VARCHAR (50) NOT NULL,
    category_id TINYINT UNSIGNED NOT NULL,
    CONSTRAINT PK_SubCategory PRIMARY KEY (id),
    CONSTRAINT FK_Category FOREIGN KEY (id) REFERENCES Category (category_id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Course (
    id MEDIUMINT UNSIGNED NOT NULL,
    title VARCHAR (60) NOT NULL,
    subtitle VARCHAR (120) NOT NULL,
    description VARCHAR (2000) NOT NULL,
    language VARCHAR (27) NOT NULL,
    requirement VARCHAR (160) NOT NULL,
    image VARCHAR (2084) NOT NULL,
    tier_id TINYINT UNSIGNED NOT NULL,
    status ENUM('pending', 'approved', 'rejected') NOT NULL,
    subcategory_id TINYINT UNSIGNED NOT NULL,
    CONSTRAINT PK_Course PRIMARY KEY (id),
    CONSTRAINT FK_SubCategory FOREIGN KEY (subcategory_id) REFERENCES SubCategory (id),
    CONSTRAINT FK_Tier FOREIGN KEY (tier_id) REFERENCES Tier (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  CourseObjective (
    course_id MEDIUMINT UNSIGNED NOT NULL,
    course_objective VARCHAR (160) NOT NULL,
    CONSTRAINT PK_CourseObjective PRIMARY KEY (course_id, course_objective),
    CONSTRAINT FK_Course FOREIGN KEY (course_id) REFERENCES Course (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Section (
    course_id MEDIUMINT UNSIGNED NOT NULL,
    id SMALLINT UNSIGNED NOT NULL,
    title VARCHAR (80) NOT NULL,
    number_of_item SMALLINT UNSIGNED NOT NULL,
    duration TIME NOT NULL,
    status ENUM('pending', 'publish', 'unpublish') NOT NULL,
    order_section_id SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT PK_Section PRIMARY KEY (course_id, section_id),
    CONSTRAINT FK_Course FOREIGN KEY (course_id) REFERENCES Course (id),
    CONSTRAINT FK_Section FOREIGN KEY (order_section_id) REFERENCES Section (section_id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Item (
    id SMALLINT UNSIGNED NOT NULL,
    section_id SMALLINT UNSIGNED NOT NULL,
    course_id MEDIUMINT UNSIGNED NOT NULL,
    title VARCHAR (80) NOT NULL,
    description VARCHAR (255) NOT NULL,
    type ENUM('lecture', 'quiz') NOT NULL,
    CONSTRAINT PK_Item PRIMARY KEY (id, section_id, course_id),
    CONSTRAINT FK_Section_id FOREIGN KEY (section_id) REFERENCES Section (id),
    CONSTRAINT FK_Section_courseId FOREIGN KEY (course_id) REFERENCES Section (course_id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  ItemHistory (
    item_id SMALLINT UNSIGNED NOT NULL,
    section_id SMALLINT UNSIGNED NOT NULL,
    course_id MEDIUMINT UNSIGNED NOT NULL,
    create_at DATETIME NOT NULL,
    CONSTRAINT PK_ItemHistory PRIMARY KEY (item_id, section_id, course_id, date_time),
    CONSTRAINT FK_Item_id FOREIGN KEY (item_id) REFERENCES Item (id),
    CONSTRAINT FK_Item_sectionId FOREIGN KEY (section_id) REFERENCES Item (section_id),
    CONSTRAINT FK_Item_courseID FOREIGN KEY (course_id) REFERENCES Item (course_id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Lecture (
    id SMALLINT UNSIGNED NOT NULL,
    resource VARCHAR (2084) NOT NULL,
    url VARCHAR (2084) NOT NULL,
    duration TIME NOT NULL,
    CONSTRAINT PK_Lecture PRIMARY KEY (id),
    CONSTRAINT FK_Item FOREIGN KEY (id) REFERENCES Item (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  LectureSubtitle (
    lecture_id SMALLINT UNSIGNED NOT NULL,
    subtitle_language VARCHAR (27) NOT NULL,
    subtitle VARCHAR (2084) NOT NULL,
    CONSTRAINT PK_LectureSubtitle PRIMARY KEY (lecture_id, subtitle_language),
    CONSTRAINT FK_Lecture FOREIGN KEY (lecture_id) REFERENCES Lecture (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Quiz (
    id SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT PK_Quiz PRIMARY KEY (id),
    CONSTRAINT FK_Item FOREIGN KEY (id) REFERENCES Item (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  QuizQA (
    quiz_id SMALLINT UNSIGNED NOT NULL,
    quiz_qa_id TINYINT UNSIGNED NOT NULL,
    question VARCHAR (600) NOT NULL,
    correct_answer VARCHAR (600) NOT NULL,
    CONSTRAINT PK_QuizQA PRIMARY KEY (quiz_id, quiz_qa_id),
    CONSTRAINT FK_Quiz FOREIGN KEY (quiz_id) REFERENCES Quiz (id),
    CONSTRAINT FK_QuizQAAnswerDetail FOREIGN KEY (correct_answer) REFERENCES QuizQAAnswerDetail (answer)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


-- QUIZ_Q & A_ANSWER_DETAIL (QuizID, QuizQ & AID, Answer, Explanation) PRIMARY KEY: QuizQ & AID,
-- QuizID FOREIGN KEYS: QuizID REFERENCES QUIZ_Q & A Quiz_Q & AID REFERENCES QUIZ_Q & A
CREATE TABLE
  QuizQAAnswerDetail (
    quiz_id SMALLINT UNSIGNED NOT NULL,
    quiz_qa_id TINYINT UNSIGNED NOT NULL,
    answer VARCHAR (600) NOT NULL,
    explanation VARCHAR (600) NOT NULL,
    CONSTRAINT PK_QuizQAAnswerDetail PRIMARY KEY (quiz_id, quiz_qa_id),
    CONSTRAINT FK_QuizQA_Id FOREIGN KEY (quiz_qa_id) REFERENCES QuizQA (quiz_qa_id),
    CONSTRAINT FK_QuizQA_quizId FOREIGN KEY (quiz_id) REFERENCES QuizQA (quiz_id),
    CONSTRAINT FK_QuizQA_answer FOREIGN KEY (answer) REFERENCES QuizQA (correct_answer)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  StudentAnswerQA (
    quiz_id SMALLINT UNSIGNED NOT NULL,
    quiz_qa_id TINYINT UNSIGNED NOT NULL,
    answer VARCHAR (600) NOT NULL,
    learner_id MEDIUMINT UNSIGNED NOT NULL,
    course_id MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT PK_StudentAnswerQA PRIMARY KEY (quiz_id, quiz_qa_id),
    CONSTRAINT FK_QuizQA_Id FOREIGN KEY (quiz_qa_id) REFERENCES QuizQA (quiz_qa_id),
    CONSTRAINT FK_QuizQA_quizId FOREIGN KEY (quiz_id) REFERENCES QuizQA (quiz_id),
    CONSTRAINT FK_QuizQAAnswerDetail FOREIGN KEY (answer) REFERENCES QuizQAAnswerDetail (answer),
    CONSTRAINT FK_QuizQA_learnerId FOREIGN KEY (learner_id) REFERENCES EnrollementCourse (learner_id),
    CONSTRAINT FK_QuizQA_courseId FOREIGN KEY (course_id) REFERENCES EnrollementCourse (course_id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Question (
    question_id SMALLINT UNSIGNED NOT NULL,
    section_id SMALLINT UNSIGNED NOT NULL,
    course_id MEDIUMINT UNSIGNED NOT NULL,
    item_id SMALLINT UNSIGNED NOT NULL,
    question_datetime DATETIME NOT NULL,
    question_message VARCHAR (600) NOT NULL,
    user_id MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT PK_Question PRIMARY KEY (question_id),
    CONSTRAINT FK_Item FOREIGN KEY (item_id) REFERENCES Item (id),
    CONSTRAINT FK_Item_section FOREIGN KEY (section_id) REFERENCES Item (section_id),
    CONSTRAINT FK_Item_course FOREIGN KEY (course_id) REFERENCES Item (course_id),
    CONSTRAINT FK_User FOREIGN KEY (user_id) REFERENCES User (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Answer (
    question_id SMALLINT UNSIGNED NOT NULL,
    answer_id SMALLINT UNSIGNED NOT NULL,
    item_id SMALLINT UNSIGNED NOT NULL,
    course_id MEDIUMINT UNSIGNED NOT NULL,
    section_id SMALLINT UNSIGNED NOT NULL,
    answer_datetime DATETIME NOT NULL,
    answer_message VARCHAR (600) NOT NULL,
    user_id MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT PK_Answer PRIMARY KEY (
      question_id,
      answer_id,
      item_id,
      course_id,
      section_id
    ),
    CONSTRAINT FK_Question FOREIGN KEY (question_id) REFERENCES Question (question_id),
    CONSTRAINT FK_Question_ItemId FOREIGN KEY (item_id) REFERENCES Question (item_id),
    CONSTRAINT FK_Question_section FOREIGN KEY (section_id) REFERENCES Question (section_id),
    CONSTRAINT FK_Question_course FOREIGN KEY (course_id) REFERENCES Question (course_id),
    CONSTRAINT FK_User FOREIGN KEY (user_id) REFERENCES User (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  ShoppingCart (
    learner_id MEDIUMINT UNSIGNED NOT NULL,
    course_id MEDIUMINT UNSIGNED NOT NULL,
    CONSTRAINT PK_ShoppingCart PRIMARY KEY (learner_id),
    CONSTRAINT FK_Learner FOREIGN KEY (learner_id) REFERENCES Learner (user_id),
    CONSTRAINT FK_Course FOREIGN KEY (course_id) REFERENCES Course (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  EnrollementCourse (
    course_id MEDIUMINT UNSIGNED NOT NULL,
    learner_id MEDIUMINT UNSIGNED NOT NULL,
    course_completion_date DATE NOT NULL,
    course_rating SMALLINT UNSIGNED NOT NULL,
    course_comment VARCHAR (2000) NOT NULL,
    final_course_price MEDIUMINT UNSIGNED NOT NULL,
    payment_id MEDIUMINT INT NOT NULL,
    CONSTRAINT PK_EnrollementCourse PRIMARY KEY (course_id),
    CONSTRAINT FK_Course FOREIGN KEY (course_id) REFERENCES Course (id),
    CONSTRAINT FK_Learner FOREIGN KEY (learner_id) REFERENCES Learner (user_id),
    CONSTRAINT FK_Payment FOREIGN KEY (payment_id) REFERENCES Payment (id)
  ) DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


-- Thu
CREATE TABLE
  CourseInstructor () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  CourseInstructorHistory () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  CourseProgress () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Adjustment () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Notification () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  PromotionalProgram () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  PromotionalProgramHistory () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  PriceConversion () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  CourseHighlight () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  Payment () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  MonthlyCourseIncome () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;


CREATE TABLE
  MonthlyCourseIncomeVipInstructor () DEFAULT CHARACTER
SET
  utf8mb4 COLLATE utf8mb4_unicode_ci;