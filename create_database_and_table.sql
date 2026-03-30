CREATE DATABASE `hospital`;

CREATE TABLE `bed_details` (
  `Bed_ID` int NOT NULL,
  `Bed Number` text,
  PRIMARY KEY (`Bed_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `department` (
  `Dpt_ID` int NOT NULL,
  `Department_Name` text,
  PRIMARY KEY (`Dpt_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `staff_details` (
  `Staff_Id` int NOT NULL,
  `Staff Name` text,
  PRIMARY KEY (`Staff_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `patient` (
  `Staff_Id` int DEFAULT NULL,
  `Bed_ID` int DEFAULT NULL,
  `Dpt_ID` int DEFAULT NULL,
  `Patient_ID` bigint NOT NULL,
  `Name` text,
  `Gender` text,
  `City` text,
  `State` text,
  `Age` bigint DEFAULT NULL,
  `Patient_Type` text,
  `Status` text,
  `Treatemen_Cost` double DEFAULT NULL,
  `Bed` text,
  `LOS` bigint DEFAULT NULL,
  `ER_Time` double DEFAULT NULL,
  `Admission_Dates` text,
  `Feedback` text,
  `Rating` bigint DEFAULT NULL,
  `Age_Bucket` text,
  `Custom` text,
  `FZ_Me` text,
  PRIMARY KEY (`Patient_ID`),
  KEY `fk_patient_staff` (`Staff_Id`),
  KEY `fk_patient_bed` (`Bed_ID`),
  KEY `fk_patient_department` (`Dpt_ID`),
  CONSTRAINT `fk_patient_bed` FOREIGN KEY (`Bed_ID`) REFERENCES `bed_details` (`Bed_ID`),
  CONSTRAINT `fk_patient_department` FOREIGN KEY (`Dpt_ID`) REFERENCES `department` (`Dpt_ID`),
  CONSTRAINT `fk_patient_staff` FOREIGN KEY (`Staff_Id`) REFERENCES `staff_details` (`Staff_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
