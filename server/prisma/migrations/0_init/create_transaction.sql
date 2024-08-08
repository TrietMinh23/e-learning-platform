-- use mysql;
use defaultdb;

--Truy vấn 1: Xem các khóa học đã tạo .
DELIMITER //

CREATE PROCEDURE get_courses_by_instructor_id(IN instructor_id INT)
BEGIN
  -- Check if instructor exists: I checked on the client side
  -- Retrieve course details
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN 
    ROLLBACK;
    SELECT 'Error: An error occurred while retrieving the courses';
  END;

  START TRANSACTION;
  SELECT c.id, c.title, sc.name AS subcategory_name, ch.students_enrolled, 
         ch.average_rating, ch.sale_price
  FROM Course c
  JOIN SubCategory sc ON c.subcategory_id = sc.id
  JOIN CourseHighlight ch ON c.id = ch.id
  JOIN CourseInstructor ci ON c.id = ci.course_id AND ci.instructor_id = instructor_id;
  COMMIT;
END //              

DELIMITER ;

-- Truy vấn: (3) Cho biết thông tin danh sách khoá học dựa vào từ khoá tìm kiếm theo tên khoá học.DROP PROCEDURE IF EXISTS search_courses_by_keyword;
DELIMITER //

CREATE PROCEDURE search_courses_by_keyword(IN keyword VARCHAR(60))
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN 
    ROLLBACK;
    SELECT 'Error: An error occurred while retrieving the courses';
  END;

  START TRANSACTION;
  SELECT c.id, c.title, sc.name AS subcategory_name, ch.students_enrolled, 
         ch.average_rating, ch.sale_price, u.full_name
  FROM Course c
  JOIN SubCategory sc ON c.subcategory_id = sc.id
  JOIN CourseHighlight ch ON c.id = ch.id
  JOIN CourseInstructor ci on ci.course_id = c.id
  JOIN User u on u.id = ci.instructor_id 
  WHERE c.title LIKE CONCAT('%', keyword COLLATE utf8mb4_unicode_ci, '%')
    AND (u.role = 'instructor' or u.role = 'vipinstrutor')
    AND c.status = 'approved';
  COMMIT;
END //

DELIMITER ;

-- Truy vấn: (4) Cho biết danh sách các khoá học mà học viên có thể xem được.

-- -- Tạo khóa học mới 
-- DELIMITER //

-- CREATE PROCEDURE create_course(
--   IN title VARCHAR(60),
--   IN subtitle VARCHAR(120),
--   IN description VARCHAR(2000),
--   IN language VARCHAR(27),
--   IN requirement VARCHAR(160),
--   IN image VARCHAR(2084),
--   IN tier_id TINYINT UNSIGNED,
--   IN subcategory_id TINYINT UNSIGNED,
--   IN objective VARCHAR(160)
-- )
-- BEGIN
--   DECLARE course_id MEDIUMINT;
--   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION;
--   BEGIN 
--     ROLLBACK;
--     SELECT 'Error: An error occurred while creating the course';
--   END;

--   START TRANSACTION;
--   SET course_id = create_course_general(title, subtitle, description, language, requirement, image, tier_id, subcategory_id);
--   CALL create_course_objective(course_id, objective);
--   CALL create_course_highlight(course_id);
--   COMMIT;

--   SELECT 'Success: Course created successfully';
-- END //

-- DELIMITER ;

-- DELIMITER //

-- CREATE FUNCTION create_course_general(
--   IN title VARCHAR(60),
--   IN subtitle VARCHAR(120),
--   IN description VARCHAR(2000),
--   IN language VARCHAR(27),
--   IN requirement VARCHAR(160),
--   IN image VARCHAR(2084),
--   IN tier_id TINYINT UNSIGNED,
--   IN subcategory_id TINYINT UNSIGNED
-- )
-- RETURNS INT
-- BEGIN
--   DECLARE course_id INT;
--   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION;
--   BEGIN 
--     ROLLBACK;
--     SELECT 'Error: An error occurred while creating the course';
--   END;

--   START TRANSACTION;
--   INSERT INTO Course(title, subtitle, description, language, requirement, image, tier_id, subcategory_id)
--   VALUES (title, subtitle, description, language, requirement, image, tier_id, subcategory_id);
--   SET course_id = LAST_INSERT_ID();
--   COMMIT;

--   RETURN course_id;
-- END //

-- DELIMITER ;

-- -- tạo CourseObjective
-- DELIMITER //

-- CREATE PROCEDURE create_course_objective(
--   IN course_id MEDIUMINT,
--   IN objective VARCHAR(160)
-- )
-- BEGIN
--   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION;
--   BEGIN 
--     ROLLBACK;
--     SELECT 'Error: An error occurred while creating the course';
--   END;

--   START TRANSACTION;
--   INSERT INTO CourseObjective(course_id, objective)
--   VALUES (course_id, objective);
--   COMMIT;
-- END //

-- DELIMITER ;

-- -- tạo CourseHighlight
-- DELIMITER //

-- CREATE PROCEDURE create_course_highlight(
--   IN course_id MEDIUMINT,
-- )
-- BEGIN
--   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION;
--   BEGIN 
--     ROLLBACK;
--     SELECT 'Error: An error occurred while creating the course highlight';
--   END;

--   START TRANSACTION;
--   INSERT INTO CourseHighlight(id)
--   VALUES (course_id);
--   COMMIT;
-- END //

-- DELIMITER ;
-- -- tạo giảng viên trong khoá học
-- DELIMITER //

-- CREATE PROCEDURE create_course_instructor(
--   IN course_id MEDIUMINT,
--   IN instructor_id MEDIUMINT,
--   IN profit_percent SMALLINT
-- )
-- BEGIN 
--   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION;
--   BEGIN 
--     ROLLBACK;
--     SELECT 'Error: An error occurred while creating the course';
--   END;

--   START TRANSACTION;
--   INSERT INTO CourseInstructor(course_id, instructor_id, profit_percent)
--   VALUES (course_id, instructor_id, profit_percent);
--   INSERT INTO CourseInstructorHistory(course_id, instructor_id, profit_percent)
--   VALUES (course_id, instructor_id, profit_percent);
--   COMMIT;
-- END //

-- DELIMITER ;

-- -- tạo học phần trong khoá học  
-- DELIMITER //

-- CREATE PROCEDURE create_course_section(
--   IN course_id MEDIUMINT,
--   IN title VARCHAR(60),
--   IN description VARCHAR(2000)
-- )
-- BEGIN
--   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION;
--   BEGIN 
--     ROLLBACK;
--     SELECT 'Error: An error occurred while creating the course';
--   END;

--   DECLARE section_id INT;
--   if not exists (select 1 from section where course_id = course_id)
--   then 
--     SET section_id = 1;
--   else 
--     SET section_id = (select max(section_id) + 1 from section where course_id = course_id);
--   end if;    
    
--   START TRANSACTION;
--   INSERT INTO Section(course_id, id, title, description)
--   VALUES (course_id, section_id, title, description);

--   DECLARE order_section_id INT;
--   if not exists (select 1 from SectionOrder where course_id = course_id)
--   then 
--     SET order_section_id = 1;
--   else 
--     SET order_section_id = (select max(order_section_id) + 1 from SectionOrder where course_id = course_id);
--   end if;
--   INSERT INTO SectionOrder (section_id, course_id, order_section_id)
--   VALUES (section_id, course_id, order_section_id);

--   UPDATE CourseHighlight 
--   SET sections = sections + 1
--   WHERE id = course_id;
--   COMMIT;
-- END //

-- -- tạo mục học trong học phần
-- DELIMITER //

-- CREATE PROCEDURE create_course_section_item(
--   IN course_id MEDIUMINT,
--   IN section_id SMALLINT,
--   IN title VARCHAR(80),
--   IN description VARCHAR(255),
--   IN item_type ENUM('lecture', 'quiz')
-- )
-- BEGIN 
--   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION;
--   BEGIN 
--     ROLLBACK;
--     SELECT 'Error: An error occurred while creating the course';
--   END;  

--   START TRANSACTION;
--   DECLARE item_id INT;
--   if not exists (select 1 from Item where course_id = course_id and section_id = section_id)
--   then 
--     SET item_id = 1;
--   else 
--     SET item_id = (select max(item_id) + 1 from Item where course_id = course_id and section_id = section_id);
--   end if;
--   INSERT INTO Item(id, section_id, course_id, title, description, item_type)
--   VALUES (item_id, section_id, course_id, title, description, item_type);

--   DECLARE order_item_id INT;
--   if not exists (select 1 from ItemOrder where course_id = course_id and section_id = section_id)
--   then 
--     SET order_item_id = 1;
--   else 
--     SET order_item_id = (select max(order_item_id) + 1 from ItemOrder where course_id = course_id and section_id = section_id);
--   end if;
--   INSERT INTO ItemOrder (item_id, section_id, course_id, order_item_id) 
--   VALUES (item_id, section_id, course_id, order_item_id);
--   COMMIT;`
-- END

-- DELIMITER ;