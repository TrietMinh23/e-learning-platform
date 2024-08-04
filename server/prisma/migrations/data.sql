use defaultdb;

DELIMITER //
-- create procedure InsertDataToUser 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToAdmin 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToLearner 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToInstructor 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToVipInstructor 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToCategory 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToSubCategory 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToCourse 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToCourseObjective 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToSection
DELIMITER;

DELIMITER //
create procedure InsertDataToItem 
begin 
  @set i int = 1;

  while i <= 100 do 
    @set section_id int = (select id from Section order by rand() limit 1 where number_of_item <= 1400);
    @set course_id int = (select course_id from Section where id = section_id);

    insert into Item (id, section_id, course_id, title, order_item_id, description, type)
    values (i, section_id, course_id, 'Item ' + i, i, 'Description of item ' + i, 'VIDEO');
end
DELIMITER;

DELIMITER //
-- create procedure InsertDataToItemHistory 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToLecture 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToLectureSubtitle 
DELIMITER;

DELIMITER //
create procedure InsertDataToQuiz 
BEGIN   
  -- CREAETE TABLE TEMP TO SAVE ALL ITEMS HAVE TYPE = QUIZ
  CREATE TEMPORARY TABLE IF NOT EXISTS TempQuiz AS
  SELECT * FROM Item WHERE type = 'QUIZ';

  @SET i INT = 1;
  @SET total INT = (select count(*) from TempQuiz);

  WHILE i <= total DO
    INSERT INTO Quiz (id, section_id, course_id) 
    VALUES (i, );
    SET i = i + 1;
  END WHILE;
END
DELIMITER;

DELIMITER //
-- create procedure InsertDataToQuizQA 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToQuizQAAnswerDetail 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToStudentAnswerQA 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToQuestion 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToAnswer 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToShoppingCart 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToEnrollementCourse 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToCourseInstructor 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToCourseInstructorHistory 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToCourseProgress 
DELIMITER;

DELIMITER //
-- create procedure InsertDataToAdjustment  
DELIMITER;

DELIMITER //
-- create procedure InsertDataToNotification
DELIMITER;

DELIMITER //
-- create procedure InsertDataToPromotionalProgram
DELIMITER;

DELIMITER //
-- create procedure InsertDataToPromotionalProgramHistory
DELIMITER;

DELIMITER //
-- create procedure InsertDataToPriceConversion
DELIMITER;

DELIMITER //
-- create procedure InsertDataToCourseHighlight
DELIMITER;

DELIMITER //
-- create procedure InsertDataToPayment
DELIMITER;

DELIMITER //
-- create procedure InsertDataToMonthlyCourseIncome
DELIMITER;

DELIMITER //
-- create procedure InsertDataToMonthlyCourseIncomeVipInstructor
DELIMITER;
