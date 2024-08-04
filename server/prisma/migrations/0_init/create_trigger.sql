use defaultdb;
-- use mysql;

-- 1.	Giá bán khoá học ở tại một thời điểm:
-- 1.1.	Trường hợp 1: Tại thời điểm không có khuyến mãi, giá bán bằng giá gốc khoá học.
-- 1.2.	Trường hợp 2: Tại thời điểm khuyến mãi, giá bán bằng giá được giảm so theo barem giảm giá khoá học khi áp dụng chương trình, số tiền này đã bao gồm 5% thuế giá trị gia tăng[2].

-- 2.	Giá khoá học học viên đã đăng ký bằng giá khoá được bán ở thời điểm tại. 
DELIMITER //
CREATE TRIGGER `kiem_tra_gia_ban_khoa_hoc` 
AFTER INSERT ON EnrollementCourse
FOR EACH ROW
BEGIN
  IF exists (
    select 1 
    from EnrollementCourse e join Course c on e.course_id = c.id 
    join Tier t on t.id = c.tier_id
    where e.final_course_price != t.price and e.course_id = NEW.course_id)
  THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Giá bán khoá học không hợp lệ';    
  END IF;
END
DELIMITER ;
-- 3.	Tổng tiền hoá đơn thanh toán tại một thời điểm bằng tổng giá khoá học mà học viên đã mua tại thời điểm đó.
