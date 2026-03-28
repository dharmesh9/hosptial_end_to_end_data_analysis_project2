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

-- 5. Standard deviation of numeric columns
SELECT
    ROUND(STDDEV(Age), 2)            AS std_age,
    ROUND(STDDEV(Treatemen_Cost), 2) AS std_cost,
    ROUND(STDDEV(LOS), 2)            AS std_los,
    ROUND(STDDEV(ER_Time), 2)        AS std_er_time,
    ROUND(STDDEV(Rating), 2)         AS std_rating
FROM patient;


-- 6. Duplicate patient name check
SELECT Name, COUNT(*) AS occurrences
FROM patient
GROUP BY Name
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;

-- 7. Patients with zero LOS (same day discharge)
SELECT COUNT(*) AS same_day_discharge 
FROM patient 
WHERE LOS = 0;

-- 8. Patients with unusually high treatment cost (above 1000)
SELECT p.Patient_ID, p.Name, p.Age, p.Treatemen_Cost, p.Status, d.Department_Name
FROM patient p
JOIN department d ON p.Dpt_ID = d.Dpt_ID
WHERE Treatemen_Cost > 1000
ORDER BY Treatemen_Cost DESC;

-- 9. Check if all Dpt_IDs in patient exist in department table
SELECT DISTINCT p.Dpt_ID
FROM patient p
LEFT JOIN department d ON p.Dpt_ID = d.Dpt_ID
WHERE d.Dpt_ID IS NULL;
 
-- 10. Check if all Staff_Ids in patient exist in staff_details
SELECT DISTINCT p.Staff_Id
FROM patient p
LEFT JOIN staff_details s ON p.Staff_Id = s.Staff_Id
WHERE s.Staff_Id IS NULL;

-- 11. Check if all Bed_IDs in patient exist in bed_details
SELECT DISTINCT p.Bed_ID
FROM patient p
LEFT JOIN bed_details b ON p.Bed_ID = b.Bed_ID
WHERE b.Bed_ID IS NULL AND p.Bed_ID IS NOT NULL;

-- 12. Count of inpatients without a bed assigned (data anomaly)
SELECT COUNT(*) AS inpatients_no_bed
FROM patient
WHERE Patient_Type = 'Inpatient' AND Bed IS NULL;

-- 13. Age distribution by bucket with percentage
SELECT Age_Bucket, COUNT(*) AS total,
       ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM patient),2) AS percentage
FROM patient
GROUP BY Age_Bucket
ORDER BY total DESC;

-- 14. Gender distribution
SELECT Gender, COUNT(*) AS total_patients,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM patient),2) AS percentage
FROM patient p
GROUP BY Gender;

-- 15. Patient type distribution
SELECT Patient_Type, COUNT(*) AS total_patients,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM patient),2) AS percentage
FROM patient p
GROUP BY Patient_Type;

-- 16. Status distribution
SELECT Status, COUNT(*) as total_patients,
ROUND(COUNT(*)*100/(SELECT count(*) FROM patient),2) AS  percentage
FROM patient p
GROUP BY Status
ORDER BY total_patients DESC;

-- 17. Rating distribution
SELECT Rating, COUNT(*) as total_patients,
Round(COUNT(*)*100/(Select COUNT(*) FROM patient),2) AS percentage
FROM patient p
GROUP BY Rating
ORDER BY Rating DESC;

-- 18. Feedback distribution
SELECT Feedback, COUNT(*) AS total_patients,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM patient),2) AS percentage
FROM patient p
GROUP BY Feedback 
ORDER BY total_patients DESC;

-- 19. FZ_Me (sentiment) distribution
SELECT FZ_Me, COUNT(*) AS total_patients,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM patient),2) AS percentage
FROM patient 
GROUP BY FZ_Me 
ORDER BY total_patients DESC;

SELECT
    CASE
        WHEN Treatemen_Cost < 100  THEN 'Under 100'
        WHEN Treatemen_Cost < 300  THEN '100-299'
        WHEN Treatemen_Cost < 500  THEN '300-499'
        WHEN Treatemen_Cost < 700  THEN '500-699'
        WHEN Treatemen_Cost < 1000 THEN '700-999'
        ELSE '1000+'
    END AS cost_range,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM patient),2) AS percentage
FROM patient
GROUP BY cost_range ORDER BY MIN(Treatemen_Cost);