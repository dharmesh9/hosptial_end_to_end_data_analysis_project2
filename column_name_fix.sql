-- ================================================================
--  STEP 1: RENAME COLUMNS IN ALL TABLES
-- ================================================================

USE hospital;

-- ----------------------------------------------------------------
-- bed_details: fix space in column name
-- ----------------------------------------------------------------
ALTER TABLE bed_details
    RENAME COLUMN `Bed Number` TO Bed_Number;

-- ----------------------------------------------------------------
-- staff_details: fix space in column name
-- ----------------------------------------------------------------
ALTER TABLE staff_details
    RENAME COLUMN `Staff Name` TO Staff_Name;

-- ----------------------------------------------------------------
-- patient: fix spelling mistakes + spaces in column names
-- ----------------------------------------------------------------
ALTER TABLE patient
    RENAME COLUMN `Patient_Type`   TO Patient_Type,
    RENAME COLUMN `Treatemen_cost` TO Treatment_Cost,
    RENAME COLUMN `Age_Bucket`     TO Age_Bucket,
    RENAME COLUMN `FZ_me`          TO FZ_Me,
    RENAME COLUMN `Admission_Dates`           TO Admission_Dates;

-- ----------------------------------------------------------------
-- Verify all columns after rename
-- ----------------------------------------------------------------
DESCRIBE bed_details;
DESCRIBE staff_details;
DESCRIBE department;
DESCRIBE patient;