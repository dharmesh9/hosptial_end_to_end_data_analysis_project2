-- 1. Total row count per table
SELECT 'patient'       AS table_name, COUNT(*) AS total_rows FROM patient UNION ALL
SELECT 'department',                  COUNT(*)               FROM department UNION ALL
SELECT 'staff_details',               COUNT(*)               FROM staff_details UNION ALL
SELECT 'bed_details',                 COUNT(*)               FROM bed_details;


-- 2. NULL check for every patient column
SELECT
    SUM(CASE WHEN Patient_ID     IS NULL THEN 1 ELSE 0 END) AS null_Patient_ID,
    SUM(CASE WHEN Staff_Id       IS NULL THEN 1 ELSE 0 END) AS null_Staff_Id,
    SUM(CASE WHEN Bed_ID         IS NULL THEN 1 ELSE 0 END) AS null_Bed_ID,
    SUM(CASE WHEN Dpt_ID         IS NULL THEN 1 ELSE 0 END) AS null_Dpt_ID,
    SUM(CASE WHEN Name           IS NULL THEN 1 ELSE 0 END) AS null_Name,
    SUM(CASE WHEN Gender         IS NULL THEN 1 ELSE 0 END) AS null_Gender,
    SUM(CASE WHEN Age            IS NULL THEN 1 ELSE 0 END) AS null_Age,
    SUM(CASE WHEN City           IS NULL THEN 1 ELSE 0 END) AS null_City,
    SUM(CASE WHEN State          IS NULL THEN 1 ELSE 0 END) AS null_State,
    SUM(CASE WHEN Status         IS NULL THEN 1 ELSE 0 END) AS null_Status,
    SUM(CASE WHEN Treatemen_Cost IS NULL THEN 1 ELSE 0 END) AS null_Cost,
    SUM(CASE WHEN Bed 			 IS NULL THEN 1 ELSE 0 END) AS null_Bed,
    SUM(CASE WHEN LOS            IS NULL THEN 1 ELSE 0 END) AS null_LOS,
    SUM(CASE WHEN ER_Time        IS NULL THEN 1 ELSE 0 END) AS null_ER_Time,
    SUM(CASE WHEN Rating         IS NULL THEN 1 ELSE 0 END) AS null_Rating,
    SUM(CASE WHEN Feedback       IS NULL THEN 1 ELSE 0 END) AS null_Feedback,
    SUM(CASE WHEN FZ_Me          IS NULL THEN 1 ELSE 0 END) AS null_FZ_Me
FROM patient;

-- 3. Distinct value counts per categorical column
SELECT
    COUNT(DISTINCT Gender)       AS distinct_gender,
    COUNT(DISTINCT Patient_Type) AS distinct_patient_type,
    COUNT(DISTINCT Status)       AS distinct_status,
    COUNT(DISTINCT Feedback)     AS distinct_feedback,
    COUNT(DISTINCT Age_Bucket)   AS distinct_age_bucket,
    COUNT(DISTINCT FZ_Me)        AS distinct_fzme,
    COUNT(DISTINCT City)         AS distinct_cities,
    COUNT(DISTINCT State)        AS distinct_states,
    COUNT(DISTINCT Dpt_ID)       AS distinct_departments,
    COUNT(DISTINCT Staff_Id)     AS distinct_staff
FROM patient;

-- 4. Numeric column statistics
SELECT
    MIN(Age)            AS min_age,    MAX(Age)            AS max_age,    ROUND(AVG(Age),2)            AS avg_age,
    MIN(Treatemen_Cost) AS min_cost,   MAX(Treatemen_Cost) AS max_cost,   ROUND(AVG(Treatemen_Cost),2) AS avg_cost,
    MIN(LOS)            AS min_los,    MAX(LOS)            AS max_los,    ROUND(AVG(LOS),2)            AS avg_los,
    MIN(ER_Time)        AS min_er,     MAX(ER_Time)        AS max_er,     ROUND(AVG(ER_Time),2)        AS avg_er,
    MIN(Rating)         AS min_rating, MAX(Rating)         AS max_rating, ROUND(AVG(Rating),2)         AS avg_rating
FROM patient;
SELECT * FROM patient;

-- 5. Standard deviation of numeric columns
SELECT
    ROUND(STDDEV(Age), 2)            AS std_age,
    ROUND(STDDEV(Treatemen_Cost), 2) AS std_cost,
    ROUND(STDDEV(LOS), 2)            AS std_los,
    ROUND(STDDEV(ER_Time), 2)        AS std_er_time,
    ROUND(STDDEV(Rating), 2)         AS std_rating
FROM patient;