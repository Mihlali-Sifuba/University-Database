CREATE TABLE IF NOT EXISTS`university_database`.`students` (
  `student_number` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NULL,
  `surname` VARCHAR(255) NULL,
  `gender` ENUM("M", "F") NULL,
  `id_number` INT NULL,
  `date_of_birth` DATE NULL,
  `email` VARCHAR(255) NULL,
  `cellphone_number` VARCHAR(255) NULL,
  `country_id` VARCHAR(3) NULL,
  `programme_id` VARCHAR(255) NULL,
  PRIMARY KEY (`student_number`));
