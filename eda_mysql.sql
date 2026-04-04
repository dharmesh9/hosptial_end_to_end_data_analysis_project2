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

-- 20. Treatment cost buckets
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

-- 21. LOS distribution buckets 
SELECT Min(LOS) AS LOS,
CASE
        WHEN LOS = 0              THEN 'Same day'
        WHEN LOS BETWEEN 1 AND 3  THEN '1-3 days'
        WHEN LOS BETWEEN 4 AND 7  THEN '4-7 days'
        WHEN LOS BETWEEN 8 AND 14 THEN '8-14 days'
        ELSE '15+ days'
    END AS los_range,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM patient),2) AS percentage
FROM patient p
GROUP BY los_range 
ORDER BY LOS;

-- 22. ER Time distribution buckets
SELECT
    CASE
        WHEN ER_Time IS NULL       THEN 'No ER'
        WHEN ER_Time < 30          THEN 'Under 30 min'
        WHEN ER_Time BETWEEN 30 AND 60 THEN '30-60 min'
        WHEN ER_Time BETWEEN 61 AND 90 THEN '61-90 min'
        ELSE 'Over 90 min'
    END AS er_range,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM patient),2) AS percentage
FROM patient 
GROUP BY er_range;
 
-- 23. Age distribution (raw, in 10-year bands)
SELECT
    CASE
        WHEN Age < 10              THEN '0-9'
        WHEN Age BETWEEN 10 AND 19 THEN '10-19'
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 69 THEN '60-69'
        ELSE '70+'
    END AS age_group,
    COUNT(*) AS total_patients
FROM patient 
GROUP BY age_group 
ORDER BY MIN(Age);

-- 24. Top 10 cities by patient count
SELECT City, COUNT(Patient_ID) AS total_patient
FROM patient p
GROUP BY City
ORDER BY total_patient DESC
LIMIT 10;

-- 25. Top 10 states by patient count
SELECT State, COUNT(Patient_ID) AS total_patient
FROM patient p
GROUP BY State
ORDER BY total_patient DESC
LIMIT 10;

-- 26. Bed occupancy distribution
SELECT Bed as Bed_Status, COUNT(Patient_ID) AS total_patient,
ROUND(COUNT(Patient_ID)*100.0/(SELECT COUNT(*) FROM patient p),2) as percentage
FROM patient p
GROUP BY Bed;

-- 27. Custom (stay duration) distribution
SELECT Custom,COUNT(Patient_ID) AS total_patient,
ROUND(COUNT(Patient_ID)*100.0/(SELECT COUNT(*) FROM patient p),2) as percentage
FROM patient p
GROUP BY Custom
ORDER BY total_patient DESC;

-- 28. Department patient count distribution
SELECT d.Department_name, COUNT(p.Patient_ID) AS total_patients
FROM patient p
JOIN department d On d.Dpt_ID = p.Dpt_ID
GROUP BY d.Department_Name
ORDER BY total_patients DESC;


-- 29. Staff patient count distribution
SELECT s.`Staff Name` as staff_name, COUNT(p.Patient_ID) as total_patients
FROM patient p
JOIN staff_details s on s.Staff_Id = p.Staff_Id
GROUP BY staff_name 
ORDER BY total_patients DESC;


-- 30. Year-wise patient volume
SELECT SUBSTRING(Admission_Dates,7,4) AS year, COUNT(*) AS total_patients
FROM patient 
GROUP BY year;

 
-- 31. Gender vs Status	_
SELECT Gender, Status, COUNT(Patient_ID) as total_patients
FROM patient p
GROUP BY 1,2
ORDER BY 1,3 DESC;

-- 32. Gender vs Average treatment cost and LOS
SELECT Gender,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost,
       ROUND(AVG(LOS),2)            AS avg_los,
       ROUND(AVG(ER_Time),2)        AS avg_er,
       ROUND(AVG(Rating),2)         AS avg_rating
FROM patient GROUP BY Gender;


-- 33. Patient type vs Status
SELECT Patient_Type, Status, COUNT(*) AS total_patients
FROM patient 
GROUP BY 1,2 
ORDER BY 1, 3 DESC;
 
-- 34. Age bucket vs Average cost and LOS
SELECT Age_Bucket,
       COUNT(*) AS total,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost,
       ROUND(AVG(LOS),2)            AS avg_los,
       ROUND(AVG(ER_Time),2)        AS avg_er
FROM patient 
GROUP BY 1 
ORDER BY 3 DESC;
 
-- 35. Age bucket vs Status
SELECT Age_Bucket, Status, COUNT(*) AS total_patients
FROM patient 
GROUP BY 1,2 
ORDER BY 1,3 DESC;

-- 36. Rating vs Feedback cross check
SELECT Rating, Feedback, COUNT(*) as total_patients
FROM patient p
GROUP BY 1,2
ORDER BY 3 DESC;
	
-- 37. FZ_Me vs Average rating and cost
SELECT FZ_Me,
       COUNT(*) AS total_patients,
       ROUND(AVG(Rating),2)         AS avg_rating,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost,
       ROUND(AVG(LOS),2)            AS avg_los
FROM patient p
GROUP BY FZ_Me 
ORDER BY avg_rating DESC;

-- 38. LOS vs Patient type and status
SELECT Patient_Type, Status,
       ROUND(AVG(LOS),2) AS avg_los,
       MAX(LOS) AS max_los,
       COUNT(*) AS total_patients
FROM patient  p
GROUP BY 1,2
ORDER BY avg_los DESC;

-- 39. Gender vs Feedback
SELECT Gender, Feedback, COUNT(*) AS total
FROM patient p
GROUP BY Gender, Feedback 
ORDER BY Gender, total DESC;

-- 40. State vs Average treatment cost (top 10 states)
SELECT State, COUNT(*) AS total_patients,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost,
       ROUND(SUM(Treatemen_Cost),2) AS total_revenue
FROM patient p
GROUP BY State 
ORDER BY total_patients DESC 
LIMIT 10;

-- 41. Status vs Average treatment cost and LOS
SELECT Status,
       COUNT(*) AS total_patients,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost,
       ROUND(AVG(LOS),2)            AS avg_los
FROM patient p GROUP BY Status 
ORDER BY avg_cost DESC;

-- 42. Feedback vs LOS
SELECT Feedback,
       ROUND(AVG(LOS),2)            AS avg_los,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost,
       ROUND(AVG(Rating),2)         AS avg_rating,
       COUNT(*) AS total_patients
FROM patient p GROUP BY Feedback ORDER BY avg_rating DESC;

-- 43. Gender vs Age bucket
SELECT Gender, Age_Bucket, COUNT(*) AS total_patients
FROM patient p
GROUP BY 1,2
ORDER BY Gender, total_patients DESC;

-- 44. Patient type vs Average rating
SELECT Patient_Type,
       ROUND(AVG(Rating),2)         AS avg_rating,
       COUNT(*) AS total_patients
FROM patient GROUP BY Patient_Type;

-- 45. Bed occupancy vs Status
SELECT Bed, Status, COUNT(*) AS total_patients
FROM patient 
GROUP BY Bed, Status 
ORDER BY Bed, total_patients DESC;

-- 46. Rating vs Status
SELECT Rating, Status, COUNT(*) AS total_patients
FROM patient p 
GROUP BY Rating, Status 
ORDER BY Rating, total_patients DESC;
 
-- 47. Age bucket vs Feedback
SELECT Age_Bucket, Feedback, COUNT(*) AS total_patients
FROM patient p
GROUP BY Age_Bucket, Feedback 
ORDER BY Age_Bucket, total_patients DESC;
 
-- 48. City vs Average treatment cost (top 10)
SELECT City,
       COUNT(*) AS total_patients,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost
FROM patient p
GROUP BY City 
ORDER BY total_patients DESC LIMIT 10;
 
-- 49. Custom (duration bucket) vs Status
SELECT Custom, Status, COUNT(*) AS total_patients
FROM patient p
GROUP BY Custom, Status 
ORDER BY Custom, total_patients DESC;
 
-- 50. Gender vs FZ_Me sentiment
SELECT Gender, FZ_Me, COUNT(*) AS total_patients,
       ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER (PARTITION BY Gender),2) AS pct_within_gender
FROM patient p
GROUP BY Gender, FZ_Me 
ORDER BY Gender, total_patients DESC;

-- 51. Full department scorecard
SELECT d.Department_Name,
       COUNT(p.Patient_ID)                                                             AS total_patients,
       ROUND(AVG(p.Treatemen_Cost),2)                                                  AS avg_cost,
       ROUND(SUM(p.Treatemen_Cost),2)                                                  AS total_revenue,
       ROUND(AVG(p.Rating),2)                                                          AS avg_rating,
       ROUND(AVG(p.LOS),2)                                                             AS avg_los,
       ROUND(AVG(p.ER_Time),2)                                                         AS avg_er_time,
       SUM(CASE WHEN p.Status='ICU'      THEN 1 ELSE 0 END)                           AS icu_count,
       SUM(CASE WHEN p.Status='Death'    THEN 1 ELSE 0 END)                           AS death_count,
       SUM(CASE WHEN p.Status='Readmit'  THEN 1 ELSE 0 END)                           AS readmit_count,
       SUM(CASE WHEN p.Status='Discharge'THEN 1 ELSE 0 END)                           AS discharge_count,
       ROUND(SUM(CASE WHEN p.FZ_Me='Postive' THEN 1 ELSE 0 END)*100.0/COUNT(*),2)    AS positive_pct,
       ROUND(SUM(CASE WHEN p.FZ_Me='Negative'THEN 1 ELSE 0 END)*100.0/COUNT(*),2)    AS negative_pct,
       ROUND(SUM(CASE WHEN p.FZ_Me='Neutral'THEN 1 ELSE 0 END)*100.0/COUNT(*),2)    AS neutral_pct
FROM patient p
JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY d.Department_Name ORDER BY total_patients DESC;

-- 52. Department vs Gender split
SELECT  p.Gender,d.Department_Name, count(Patient_ID) as total_patients
FROM patient p
JOIN department d on d.Dpt_ID = p.Dpt_ID
GROUP BY  p.Gender,d.Department_Name
ORDER BY total_patients DESC;

-- 53. Department vs Age bucket
SELECT d.Department_Name, p.Age_Bucket, COUNT(Patient_ID) as total_patients
FROM patient p
JOIN department d on d.Dpt_ID = p.Dpt_ID
GROUP BY 1,2
ORDER BY 1 DESC;

-- 54. Department vs Patient type
SELECT d.Department_Name, p.Patient_Type, count(Patient_ID) as total_patients
FROM patient p 
JOIN department d on d.Dpt_ID = p.Dpt_ID
GROUP BY 1,2
ORDER BY 1;

 
-- 55. Department revenue rank (window function)
SELECT d.Department_Name,
       ROUND(SUM(p.Treatemen_Cost),2) AS total_revenue,
       RANK() OVER (ORDER BY SUM(p.Treatemen_Cost) DESC) AS revenue_rank
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY d.Department_Name;

-- 56. Department death rate
SELECT d.Department_Name, COUNT(Patient_ID) as total_patients,
SUM(CASE WHEN p.Status = "Death" THEN 1 ELSE 0 END) as deaths,
ROUND(SUM(CASE WHEN p.Status='Death' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS death_rate_pct
FROM patient p 
JOIN department d on p.Dpt_ID =d.Dpt_ID
GROUP BY 1
ORDER BY 4 DESC;

-- 57. Department ICU rate
SELECT d.Department_Name, COUNT(*) AS total,
       SUM(CASE WHEN p.Status='ICU' THEN 1 ELSE 0 END) AS icu_count,
       ROUND(SUM(CASE WHEN p.Status='ICU' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS icu_rate_pct
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY 1 
ORDER BY 4 DESC;

-- 58. Department cost quartile (NTILE)
SELECT Department_Name, avg_cost,
       NTILE(4) OVER (ORDER BY avg_cost) AS cost_quartile
FROM (
    SELECT d.Department_Name, ROUND(AVG(p.Treatemen_Cost),2) AS avg_cost
    FROM patient p JOIN department d ON p.Dpt_ID = d.Dpt_ID
    GROUP BY d.Department_Name
) dept_avg;

-- 59. Department feedback breakdown
SELECT d.Department_Name, p.Feedback, COUNT(*) AS total
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY d.Department_Name, p.Feedback 
ORDER BY d.Department_Name, total DESC;

-- 60. Department with highest readmission count
SELECT d.Department_Name, COUNT(*) AS readmissions
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID
WHERE p.Status = 'Readmit'
GROUP BY d.Department_Name 
ORDER BY readmissions DESC;

-- 61. Average ER time per department
SELECT d.Department_Name, ROUND(AVG(p.ER_Time),2) as avg_er_time
FROM patient p 
JOIN department d on p.Dpt_ID = d.Dpt_ID
WHERE p.ER_Time IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;

-- 62. Department with lowest avg rating
SELECT d.Department_Name, ROUND(AVG(p.Rating),2) AS avg_rating
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY d.Department_Name
ORDER BY avg_rating ASC;
 
-- 63. Department with highest negative sentiment
SELECT d.Department_Name,
       SUM(CASE WHEN p.FZ_Me='Negative' THEN 1 ELSE 0 END) AS negative_count,
       ROUND(SUM(CASE WHEN p.FZ_Me='Negative' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS negative_pct
FROM patient p JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY d.Department_Name
HAVING negative_pct > 20 
ORDER BY negative_pct DESC;
 
-- 64. Department inpatient vs outpatient split
SELECT d.Department_Name,
       SUM(CASE WHEN p.Patient_Type='Inpatient'  THEN 1 ELSE 0 END) AS inpatients,
       SUM(CASE WHEN p.Patient_Type='outpatient' THEN 1 ELSE 0 END) AS outpatients,
       COUNT(*) AS total_patients
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY d.Department_Name 
ORDER BY total_patients DESC;
 
-- 65. Department average age
SELECT d.Department_Name, ROUND(AVG(p.Age),1) AS avg_age
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY d.Department_Name 
ORDER BY avg_age DESC;

-- 66. Staff full performance report
SELECT s.`Staff Name`,
       COUNT(p.Patient_ID)                                                              AS total_patients,
       ROUND(AVG(p.Treatemen_Cost),2)                                                   AS avg_cost,
       ROUND(SUM(p.Treatemen_Cost),2)                                                   AS total_revenue,
       ROUND(AVG(p.Rating),2)                                                           AS avg_rating,
       ROUND(AVG(p.LOS),2)                                                              AS avg_los,
       SUM(CASE WHEN p.Status='ICU'    THEN 1 ELSE 0 END)                              AS icu_cases,
       SUM(CASE WHEN p.Status='Death'  THEN 1 ELSE 0 END)                              AS death_cases,
       SUM(CASE WHEN p.Status='Readmit'THEN 1 ELSE 0 END)                              AS readmit_cases,
       ROUND(SUM(CASE WHEN p.FZ_Me='Postive' THEN 1 ELSE 0 END)*100.0/COUNT(*),2)     AS satisfaction_pct
FROM patient p 
JOIN staff_details s ON p.Staff_Id = s.Staff_Id
GROUP BY s.`Staff Name` 
ORDER BY satisfaction_pct DESC;

-- 67. Top staff per department by patient count
SELECT Department_Name, Staff_Name, total_patients
FROM (
    SELECT d.Department_Name, s.`Staff Name` AS Staff_Name,
           COUNT(p.Patient_ID) AS total_patients,
           RANK() OVER (PARTITION BY d.Department_Name ORDER BY COUNT(p.Patient_ID) DESC) AS rnk
    FROM patient p
    JOIN department d    ON p.Dpt_ID   = d.Dpt_ID
    JOIN staff_details s ON p.Staff_Id = s.Staff_Id
    GROUP BY d.Department_Name, s.`Staff Name`
) ranked WHERE rnk = 1;


-- 68. Staff handling both inpatients and outpatients

SELECT s.`Staff Name`,
SUM(CASE WHEN p.Patient_Type = 'Inpatient' THEN 1 ELSE 0 END) AS total_inpatients,
SUM(CASE WHEN p.Patient_Type = 'outpatient' THEN 1 ELSE 0 END) AS total_outpatients
FROM patient p 
JOIN staff_details s on p.Staff_Id = s.Staff_Id
GROUP BY s.`Staff Name`
HAVING total_inpatients > 0 AND total_outpatients > 0
ORDER BY total_inpatients,total_outpatients;

-- 69. Bottom 10 staff by avg rating
SELECT s.`Staff Name`, COUNT(p.Patient_ID) AS total, 
ROUND(AVG(p.Rating),2) AS avg_rating
FROM patient p 
JOIN staff_details s ON p.Staff_Id = s.Staff_Id
GROUP BY s.`Staff Name` 
ORDER BY avg_rating ASC LIMIT 10;

-- 70. Staff handling ICU and Death cases
SELECT s.`Staff Name`,
       SUM(CASE WHEN p.Status='ICU'   THEN 1 ELSE 0 END) AS icu_cases,
       SUM(CASE WHEN p.Status='Death' THEN 1 ELSE 0 END) AS death_cases
FROM patient p 
JOIN staff_details s ON p.Staff_Id = s.Staff_Id
GROUP BY s.`Staff Name`
HAVING icu_cases > 0 AND death_cases > 0
ORDER BY death_cases DESC;

-- 71. Staff satisfaction ranked using CTE
WITH staff_scores AS (
    SELECT s.`Staff Name`,
           COUNT(p.Patient_ID) AS total,
           ROUND(SUM(CASE WHEN p.FZ_Me='Postive' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS satisfaction_pct,
           ROUND(AVG(p.Rating),2) AS avg_rating
    FROM patient p 
    JOIN staff_details s ON p.Staff_Id = s.Staff_Id
    GROUP BY s.`Staff Name`
)
SELECT *, 
RANK() OVER (ORDER BY satisfaction_pct DESC) AS satisfaction_rank
FROM staff_scores 
ORDER BY satisfaction_rank;

 
-- 72. Staff revenue contribution %
SELECT s.`Staff Name`,
       ROUND(SUM(p.Treatemen_Cost),2) AS revenue,
       ROUND(SUM(p.Treatemen_Cost)*100.0/(SELECT SUM(Treatemen_Cost) FROM patient),2) AS revenue_pct
FROM patient p 
JOIN staff_details s ON p.Staff_Id = s.Staff_Id
GROUP BY s.`Staff Name` 
ORDER BY revenue DESC;

-- 73. Staff average ER time
SELECT s.`Staff Name`, 
ROUND(AVG(p.ER_Time),2) AS avg_er_time
FROM patient p 
JOIN staff_details s ON p.Staff_Id = s.Staff_Id
WHERE p.ER_Time IS NOT NULL
GROUP BY s.`Staff Name` 
ORDER BY avg_er_time DESC;

-- 74. Staff with highest readmission patients
SELECT s.`Staff Name`, COUNT(*) AS readmissions
FROM patient p 
JOIN staff_details s ON p.Staff_Id = s.Staff_Id
WHERE p.Status = 'Readmit'
GROUP BY s.`Staff Name` 
ORDER BY readmissions DESC;
 
-- 75. Staff with all 5-star rated patients
SELECT s.`Staff Name`, 
COUNT(*) AS five_star_patients
FROM patient p 
JOIN staff_details s ON p.Staff_Id = s.Staff_Id
WHERE p.Rating = 5
GROUP BY s.`Staff Name` 
ORDER BY five_star_patients DESC;

-- 76. Year-wise patient count and revenue
SELECT SUBSTRING(Admission_Dates,7,4) AS year,
       COUNT(*) AS total_patients,
       ROUND(SUM(Treatemen_Cost),2) AS total_revenue,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost
FROM patient p
GROUP BY year 
ORDER BY year;

-- 77. Month-wise patient count
SELECT SUBSTRING(Admission_Dates,4,2) AS month,
       COUNT(*) AS total_patients,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost
FROM patient p
GROUP BY month 
ORDER BY month;

 
-- 78. Year + month patient trend
SELECT SUBSTRING(Admission_Dates,7,4) AS year,
       SUBSTRING(Admission_Dates,4,2) AS month,
       COUNT(*) AS total_patients,
       ROUND(SUM(Treatemen_Cost),2) AS total_revenue
FROM patient p
GROUP BY year, month 
ORDER BY year, month;

-- 79. Year-wise death and ICU trend
SELECT SUBSTRING(Admission_Dates,7,4) AS year,
       SUM(CASE WHEN Status='ICU'   THEN 1 ELSE 0 END) AS icu_count,
       SUM(CASE WHEN Status='Death' THEN 1 ELSE 0 END) AS death_count,
       COUNT(*) AS total
FROM patient p
GROUP BY year 
ORDER BY year;

-- 80. Year-wise avg rating trend
SELECT SUBSTRING(Admission_Dates,7,4) AS year,
       ROUND(AVG(Rating),2) AS avg_rating,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost,
       ROUND(AVG(LOS),2) AS avg_los
FROM patient p
GROUP BY year 
ORDER BY year;

-- 81. Year-wise patient type split
SELECT SUBSTRING(Admission_Dates,7,4) AS year,
       SUM(CASE WHEN Patient_Type='Inpatient'  THEN 1 ELSE 0 END) AS inpatients,
       SUM(CASE WHEN Patient_Type='outpatient' THEN 1 ELSE 0 END) AS outpatients
FROM patient p
GROUP BY year 
ORDER BY year;

-- 82. Year-wise sentiment trend
SELECT SUBSTRING(Admission_Dates,7,4) AS year,
       SUM(CASE WHEN FZ_Me='Postive'  THEN 1 ELSE 0 END) AS positive,
       SUM(CASE WHEN FZ_Me='Negative' THEN 1 ELSE 0 END) AS negative,
       SUM(CASE WHEN FZ_Me='Neutral'  THEN 1 ELSE 0 END) AS neutral
FROM patient p 
GROUP BY year 
ORDER BY year;
 
-- 83. Month-wise ICU and Death count
SELECT SUBSTRING(Admission_Dates,4,2) AS month,
       SUM(CASE WHEN Status='ICU'   THEN 1 ELSE 0 END) AS icu_count,
       SUM(CASE WHEN Status='Death' THEN 1 ELSE 0 END) AS death_count
FROM patient p  
GROUP BY month 
 ORDER BY month;
 
-- 84. First and last admission date per department
SELECT d.Department_Name,
       MIN(p.Admission_Dates) AS first_admission,
       MAX(p.Admission_Dates) AS last_admission,
       COUNT(p.Patient_ID) AS total_patients
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY d.Department_Name;
 
-- 85. Year-wise readmission count
SELECT SUBSTRING(Admission_Dates,7,4) AS year,
       SUM(CASE WHEN Status='Readmit' THEN 1 ELSE 0 END) AS readmissions,
       COUNT(*) AS total,
       ROUND(SUM(CASE WHEN Status='Readmit' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS readmit_rate_pct
FROM patient p  
GROUP BY year 
ORDER BY year;
 
-- 86. Cumulative patients per department over time
SELECT SUBSTRING(Admission_Dates,7,4) AS year,
d.Department_Name, 
COUNT(p.Patient_ID) as total_patients,
SUM(COUNT(p.Patient_ID)) OVER (PARTITION BY d.Department_Name ORDER BY SUBSTRING(Admission_Dates,7,4)) AS cumulative_patients
FROM patient p
JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY year,d.Department_Name;

-- 87. Patient cost vs dept avg and overall avg
SELECT Patient_ID, Name, d.Department_Name, Treatemen_Cost,
       ROUND(AVG(Treatemen_Cost) OVER (PARTITION BY p.Dpt_ID),2) AS dept_avg,
       ROUND(AVG(Treatemen_Cost) OVER (),2)                       AS overall_avg,
       ROUND(Treatemen_Cost - AVG(Treatemen_Cost) OVER (PARTITION BY p.Dpt_ID),2) AS diff_from_dept_avg
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID
ORDER BY diff_from_dept_avg DESC;

-- 88. Dense rank of patients by rating within department
SELECT p.Patient_ID, p.Name, d.Department_Name, p.Rating,
       DENSE_RANK() OVER (PARTITION BY p.Dpt_ID ORDER BY p.Rating DESC) AS rating_rank
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID;

-- 89. 5-row moving average of treatment cost over admission date
SELECT Admission_Dates, Patient_ID, Name, Treatemen_Cost,
       ROUND(AVG(Treatemen_Cost) OVER (ORDER BY Admission_Dates ROWS BETWEEN 4 PRECEDING AND CURRENT ROW),2) AS moving_avg_5
FROM patient;
 
-- 90. Lead and lag on treatment cost
SELECT Patient_ID, Name, Admission_Dates, Treatemen_Cost,
       LAG(Treatemen_Cost)  OVER (ORDER BY Admission_Dates) AS prev_cost,
       LEAD(Treatemen_Cost) OVER (ORDER BY Admission_Dates) AS next_cost,
       ROUND(Treatemen_Cost - LAG(Treatemen_Cost) OVER (ORDER BY Admission_Dates),2) AS cost_change
FROM patient;

-- 91. Percentile rank of patients by treatment cost
SELECT Patient_ID, Name, Treatemen_Cost,
       ROUND(PERCENT_RANK() OVER (ORDER BY Treatemen_Cost)*100,2) AS percentile_rank
FROM patient p
ORDER BY percentile_rank DESC;
 
-- 92. NTILE 4 cost quartile per patient
SELECT Patient_ID, Name, Treatemen_Cost,
       NTILE(4) OVER (ORDER BY Treatemen_Cost) AS cost_quartile
FROM patient;
 
-- 93. Rank patients by LOS within each department
SELECT p.Patient_ID, p.Name, d.Department_Name, p.LOS,
       RANK() OVER (PARTITION BY p.Dpt_ID ORDER BY p.LOS DESC) AS los_rank
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID;
 
-- 94. Running total revenue over admission date
SELECT Admission_Dates, Patient_ID, Treatemen_Cost,
       ROUND(SUM(Treatemen_Cost) OVER (ORDER BY Admission_Dates),2) AS running_revenue
FROM patient;
 
-- 95. First and last patient per department using FIRST_VALUE / LAST_VALUE
SELECT DISTINCT d.Department_Name,
       FIRST_VALUE(p.Name) OVER (PARTITION BY p.Dpt_ID ORDER BY p.Admission_Dates)                                          AS first_patient,
       LAST_VALUE(p.Name)  OVER (PARTITION BY p.Dpt_ID ORDER BY p.Admission_Dates ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_patient
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID;
 
-- 96. Rank departments by avg rating
SELECT d.Department_Name,
       ROUND(AVG(p.Rating),2) AS avg_rating,
       RANK() OVER (ORDER BY AVG(p.Rating) DESC) AS rating_rank
FROM patient p 
JOIN department d ON p.Dpt_ID = d.Dpt_ID
GROUP BY d.Department_Name;
 
-- 97. Row number per patient within each status group
SELECT Patient_ID, Name, Status, Admission_Dates,
       ROW_NUMBER() OVER (PARTITION BY Status ORDER BY Admission_Dates) AS row_num
FROM patient;

-- 98. CTE: Departments above average patient count
WITH dept_counts AS (
    SELECT d.Department_Name, COUNT(p.Patient_ID) AS total
    FROM patient p 
    JOIN department d ON p.Dpt_ID = d.Dpt_ID
    GROUP BY d.Department_Name
)
SELECT Department_Name, total,
       ROUND((SELECT AVG(total) FROM dept_counts),2) AS overall_avg
FROM dept_counts
WHERE total > (SELECT AVG(total) FROM dept_counts)
ORDER BY total DESC;
 
-- 99. CTE: Patient cost segments
WITH cost_segments AS (
    SELECT *,
        CASE
            WHEN Treatemen_Cost < 100  THEN 'Low'
            WHEN Treatemen_Cost < 500  THEN 'Medium'
            ELSE 'High'
        END AS cost_segment
    FROM patient p
)
SELECT cost_segment, COUNT(*) AS total,
       ROUND(AVG(Rating),2) AS avg_rating,
       ROUND(AVG(LOS),2)    AS avg_los,
       ROUND(AVG(ER_Time),2) AS avg_er
FROM cost_segments 
GROUP BY cost_segment 
ORDER BY MIN(Treatemen_Cost);
 
-- 100. CTE: High risk patients (ICU or Death with high cost)
WITH high_risk AS (
    SELECT p.*, d.Department_Name
    FROM patient p 
    JOIN department d ON p.Dpt_ID = d.Dpt_ID
    WHERE p.Status IN ('ICU','Death')
)
SELECT Department_Name,
       COUNT(*) AS high_risk_count,
       ROUND(AVG(Treatemen_Cost),2) AS avg_cost,
       ROUND(AVG(LOS),2) AS avg_los
FROM high_risk
GROUP BY Department_Name
 ORDER BY high_risk_count DESC;
 