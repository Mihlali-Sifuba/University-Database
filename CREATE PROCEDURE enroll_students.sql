DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE IF NOT EXISTS `enroll_students`()
BEGIN
	  DECLARE done INT DEFAULT FALSE;
	  DECLARE student_name, student_surname VARCHAR(255);
      DECLARE student_gender VARCHAR(1);
      DECLARE student_number VARCHAR(255);
	  DECLARE cur1 CURSOR FOR SELECT name, surname, gender FROM university_database.raw_student_data;
	  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
      
      DROP TEMPORARY TABLE IF EXISTS temp_student_info;
	  CREATE TEMPORARY TABLE IF NOT EXISTS temp_student_info
      (
      `name` varchar(255) DEFAULT NULL,
      `surname` varchar(255) DEFAULT NULL,
      `gender` enum('M','F') DEFAULT NULL,
      `student_number` varchar(255) DEFAULT NULL);
      
	  OPEN cur1;
    
	  read_loop: LOOP
		FETCH cur1 INTO student_name, student_surname, student_gender;
		IF done THEN
		  LEAVE read_loop;
		END IF;
        
        SET @student_number_prefix =  CONCAT(SUBSTRING(UPPER(student_surname), 1, 1), 
											 SUBSTRING(UPPER(student_surname), 3, 1), 
                                             SUBSTRING(UPPER(student_surname), 5, 1),
                                             SUBSTRING(UPPER(student_name), 1, 3));
		SET @student_number_prefix = IF(LENGTH(@student_number_prefix) = 6, @student_number_prefix, CONCAT(@student_number_prefix, LPAD('', 6 - LENGTH(@student_number_prefix), 'X')));
		INSERT INTO temp_student_info VALUES (student_name,student_surname, student_gender, @student_number_prefix);
        
	  END LOOP;
      
      DROP TEMPORARY TABLE IF EXISTS temp_student_info_2;
      CREATE TEMPORARY TABLE IF NOT EXISTS temp_student_info_2
      SELECT
		*,
	    ROW_NUMBER() OVER(PARTITION BY temp_student_info.student_number) AS row_num
	  FROM 
		temp_student_info;
      
      INSERT INTO students (student_number, name, surname, gender, email)
      SELECT CONCAT(temp_student_info_2.student_number, LPAD(CAST(temp_student_info_2.row_num AS CHAR), 3, '0')), 
      name, surname, gender,
      CONCAT(CONCAT(temp_student_info_2.student_number, LPAD(CAST(temp_student_info_2.row_num AS CHAR), 3, '0')), "@myuniversity.ac.za")
      FROM temp_student_info_2;
	
END$$
DELIMITER ;