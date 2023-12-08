CREATE TABLE IF NOT EXISTS `students` (
  `student_number` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `gender` enum('M','F') DEFAULT NULL,
  `id_number` int DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `cellphone_number` varchar(255) DEFAULT NULL,
  `country_id` varchar(3) DEFAULT NULL,
  `programme_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
