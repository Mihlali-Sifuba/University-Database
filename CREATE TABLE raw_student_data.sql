CREATE TABLE IF NOT EXISTS `university_database`.`raw_student_data` (
  `name` VARCHAR(255) NULL,
  `surname` VARCHAR(255) NULL,
  `gender` ENUM("M", "Y") NULL);