use defaultdb;

-- truy vấn 3: Cho biết thông tin danh sách khoá học dựa vào từ khoá tìm kiếm theo tên khoá học.
DROP PROCEDURE IF EXISTS search_courses_by_keyword;
CALL search_courses_by_keyword('96cqpmjhB6');
CALL search_courses_by_keyword('9');