-- AddForeignKey
ALTER TABLE `Section` ADD CONSTRAINT `FK_Section_Section` FOREIGN KEY (`course_id`, `order_section_id`) REFERENCES `Section`(`course_id`, `id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
