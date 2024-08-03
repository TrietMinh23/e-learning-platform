use defaultdb;

DELIMITER //
-- CREATE PROCEDURE InsertDataToUser 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToAdmin 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToLearner 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToInstructor 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToVipInstructor 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToCategory 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToSubCategory 
DELIMITER;
DELIMITER //
CREATE PROCEDURE InsertRandomCourses()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE max_count INT DEFAULT 100;
    DECLARE rand_title VARCHAR(60);
    DECLARE rand_subtitle VARCHAR(120);
    DECLARE rand_description VARCHAR(2000);
    DECLARE rand_language VARCHAR(27);
    DECLARE rand_requirement VARCHAR(160);
    DECLARE rand_image VARCHAR(2084);
    DECLARE rand_tier_id TINYINT UNSIGNED;
    DECLARE rand_status ENUM('pending', 'approved', 'rejected');
    DECLARE rand_subcategory_id TINYINT UNSIGNED;

    WHILE counter <= max_count DO
        SET rand_title = CONCAT('Course Title ', counter);
        SET rand_subtitle = CONCAT('Course Subtitle ', counter);
        SET rand_description = CONCAT('This is a description for course number ', counter, '.');
        SET rand_language = 'English'; 
        SET rand_requirement = 'Basic knowledge of the subject';
        SET rand_image = CONCAT('https://example.com/images/course', counter, '.jpg');
        
        SET rand_tier_id = (SELECT id FROM Tier ORDER BY RAND() LIMIT 1);
        SET rand_status = ELT(FLOOR(1 + (RAND() * 3)), 'pending', 'approved', 'rejected');
        SET rand_subcategory_id = (SELECT id FROM SubCategory ORDER BY RAND() LIMIT 1);

        INSERT INTO Course (title, subtitle, description, language, requirement, image, tier_id, status, subcategory_id)
        VALUES (rand_title, rand_subtitle, rand_description, rand_language, rand_requirement, rand_image, rand_tier_id, rand_status, rand_subcategory_id);

        SET counter = counter + 1;
    END WHILE;
END //

DELIMITER ;

DELIMITER //
-- CREATE PROCEDURE InsertDataToCourseObjective 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToSection
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToItem 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToItemHistory 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToLecture 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToLectureSubtitle 
DELIMITER;
DELIMITER //
CREATE PROCEDURE InsertDataToQuiz 
BEGIN
  DECLARE i SMALLINT DEFAULT 1;
  WHILE @i <= 100 DO
    -- select random section id 
    SET @section_id = (SELECT id FROM Section ORDER BY RAND() LIMIT 1);
    SET @course_id = (SELECT course_id FROM Section WHERE id = @section_id);
    insert into Quiz (id, section_id, course_id) 
    values (@i, @section_id, @course_id);
    set @i = @i + 1;
  END WHILE;
END
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToQuizQA 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToQuizQAAnswerDetail 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToStudentAnswerQA 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToQuestion 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToAnswer 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToShoppingCart 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToEnrollementCourse 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToCourseInstructor 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToCourseInstructorHistory 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToCourseProgress 
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToAdjustment  
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToNotification
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToPromotionalProgram
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToPromotionalProgramHistory
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToPriceConversion
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToCourseHighlight
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToPayment
DELIMITER;
DELIMITER //
-- CREATE PROCEDURE InsertDataToMonthlyCourseIncome
DELIMITER;
DELIMITER // 
-- create proc InsertDataToMonthlyCourseIncomeVipInstructor
DELIMITER;
