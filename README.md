# 🏥 Hospital Health Care Management — End-to-End Data Analysis 💻📊📈

A complete end-to-end data analysis project covering a hospital health care management dataset. The workflow spans data ingestion and schema design in MySQL, column-level data cleaning, exploratory data analysis (EDA) in both SQL and Python (Pandas), and final visualisation in a Power BI dashboard. Supporting deliverables include a written project report and a presentation deck. 📚🎤

## 📁 Repository Structure 📂

```text
hospital_end_to_end_data_analysis_project2/
│
├── 📄 Raw Data
│   ├── Hospital Health Care Management Data set.xlsx   # Original source workbook 📘
│   ├── Detailed_data_dataset.csv                       # Patient records (main table) 🧑
│   ├── Department.csv                                  # Department reference data 🏥
│   ├── Staff_details.csv                               # Staff reference data 👩‍⚕️👨‍⚕️
│   └── Bed_details.csv                                 # Bed reference data 🛏️
│
├── 🗄️ SQL Scripts
│   ├── create_database_and_table.sql                   # MySQL schema — database + 4 tables 🛠️
│   ├── column_name_fix.sql                             # Post-import column rename / cleanup ✂️
│   └── eda_mysql.sql                                   # 108+ EDA queries across 8 sections 📊
│
├── 🐍 Python Notebook
│   └── eda_panda.ipynb                                 # EDA using Pandas (Jupyter Notebook) 🐍
│
└── 📦 Supporting Materials
    ├── Hospital Dashboard.pbix                         # Interactive Power BI dashboard 📊
    ├── Hospital_Project_Report.docx                    # Written project report (Word) 📝
    └── Hospital-Health-Care-Management.pptx            # Project presentation (PowerPoint) 🎤
```

## 🔍 Project Overview 👀

This project performs a full end-to-end analysis of hospital operations data. Starting from a raw Excel workbook, the data is structured into a relational MySQL database, cleaned, and then analysed across multiple dimensions — patient demographics, treatment costs, length of stay, ER wait times, staff performance, department-level metrics, and time-based trends. Insights are surfaced through SQL queries, a Python notebook, and an interactive Power BI dashboard. 📊🐍

## 🎯 Objectives 🎯

- Design a normalised MySQL relational schema to store hospital management data. 🏛️
- Clean and standardise column names after CSV import. ✨
- Perform comprehensive EDA — univariate, bivariate, and multivariate — in MySQL. 📊
- Replicate and extend key analyses in Python using Pandas. 🐍
- Build a Power BI dashboard to visualise key operational KPIs. 📊
- Document findings in a written report and presentation. 📄🎤

## 🛠️ Tools & Technologies 🧰

| Tool               | Purpose |
|--------------------|---------|
| MySQL              | Relational database, schema design, all SQL EDA 💾
| Python (Pandas)    | EDA and data exploration in Jupyter Notebook 🐍📊
| Microsoft Excel    | Source data (.xlsx) 📘
| Power BI           | Interactive dashboard (.pbix) 📊
| Jupyter Notebook   | Python analysis environment 🧑‍💻

## 🗃️ Database Schema 📚

The MySQL database is named `hospital` and consists of four tables with referential integrity enforced via foreign keys. 🏛️

### patient
Core fact table. 🧑

| Column          | Type        | Description |
|-----------------|-------------|-------------|
| Patient_ID      | BIGINT (PK) | Unique patient identifier 🔢 |
| Staff_Id        | INT (FK)    | Attending staff member 👩‍⚕️👨‍⚕️ |
| Bed_ID          | INT (FK)    | Assigned bed 🛏️ |
| Dpt_ID          | INT (FK)    | Department 🏥 |
| Name            | TEXT        | Patient name 🧑 |
| Gender          | TEXT        | Patient gender 🚹🚺 |
| Age             | BIGINT      | Patient age 🎂 |
| Age_Bucket      | TEXT        | Derived age group 👶🧒👦👩‍🦳 |
| City / State    | TEXT        | Patient location 🌍 |
| Patient_Type    | TEXT        | Inpatient or Outpatient 🏥🏠 |
| Status          | TEXT        | Discharge / ICU / Death / Readmit 🚑 |
| Treatment_Cost  | DOUBLE      | Cost of treatment 💰 |
| Bed             | TEXT        | Bed occupancy status 🛏️ |
| LOS             | BIGINT      | Length of stay (days) 📅 |
| ER_Time         | DOUBLE      | ER wait time (minutes) ⏱️ |
| Admission_Dates | TEXT        | Date of admission 📅 |
| Feedback        | TEXT        | Patient feedback category 📝 |
| Rating          | BIGINT      | Patient satisfaction rating ⭐ |
| FZ_Me           | TEXT        | Sentiment label (Positive / Negative / Neutral) 🤗😡😐 |
| Custom          | TEXT        | Stay duration bucket 📦 |

### department 🏥
| Column           | Type | Description |
|------------------|------|-------------|
| Dpt_ID           | PK   | Department ID 🔢 |
| Department_Name  | TEXT | Department name 🏥 |

### staff_details 👩‍⚕️👨‍⚕️
| Column       | Type | Description |
|--------------|------|-------------|
| Staff_Id     | PK   | Staff ID 🔢 |
| Staff_Name   | TEXT | Staff name 🧑‍⚕️ |

### bed_details 🛏️
| Column      | Type | Description |
|-------------|------|-------------|
| Bed_ID      | PK   | Bed ID 🔢 |
| Bed_Number  | TEXT | Bed number 🛏️ |

## ⚙️ Workflow ⚙️

### Step 1 — Data Source 📥
The original data is provided as `Hospital Health Care Management Data set.xlsx`. Individual tables were exported as CSV files (`Detailed_data_dataset.csv`, `Department.csv`, `Staff_details.csv`, `Bed_details.csv`) for import into MySQL. 🧾

### Step 2 — Database & Schema Setup 🛠️
`create_database_and_table.sql` creates the `hospital` database and all four tables with appropriate data types, primary keys, and foreign key constraints between the `patient` table and the three reference tables. 💾

### Step 3 — Data Cleaning 🧹
After CSV import, several column names contained spaces or spelling errors such as `Treatemen_cost`, `Staff Name`, and `Bed Number`. `column_name_fix.sql` renames all affected columns across all four tables and verifies the result with `DESCRIBE` statements. ✨

### Step 4 — SQL EDA 📊
`eda_mysql.sql` contains 1,125 lines and 108+ queries organised into 8 numbered sections.

| Section | Topic | Queries |
|---|---|---|
| 1 | Data Overview & Quality Checks 🧐 | 1–12 |
| 2 | Univariate Analysis 📊 | 13–30 |
| 3 | Bivariate Analysis 📊 | 31–50 |
| 4 | Department Deep Analysis 🏥 | 51–65 |
| 5 | Staff Deep Analysis 👩‍⚕️👨‍⚕️ | 66–75 |
| 6 | Time-Based Analysis ⏰ | 76–85 |
| 7 | Window Functions 📊 | 86–97 |
| 8 | CTE & Subquery Analysis 📊 | 98–108+ |

Key techniques used include `GROUP BY`, `JOIN`, `CASE WHEN`, `HAVING`, `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `NTILE()`, `PERCENT_RANK()`, `LAG()`, `LEAD()`, `FIRST_VALUE()`, `LAST_VALUE()`, moving averages, running totals, CTEs, and correlated subqueries. 📊

### Step 5 — Python EDA 🐍
`eda_panda.ipynb` explores the dataset using Pandas in a Jupyter Notebook environment, complementing the SQL analysis with Python-based data manipulation and visualisation. 🐍📊

### Step 6 — Power BI Dashboard 📊
`Hospital Dashboard.pbix` is an interactive Power BI dashboard built from the cleaned dataset, providing visual summaries of the hospital's key operational metrics. 📊

## 📊 Analysis Areas Covered 📊

### Patient Demographics 👥
Age distribution, gender split, geographic spread across cities and states, and patient type distribution. 📊

### Clinical Outcomes 🚑
Status breakdown, department-level death and ICU rates, year-wise death and ICU trends, and readmission rates over time. 📊

### Financial Performance 💰
Treatment cost statistics, cost distribution buckets, total and average revenue per department and staff member, year-over-year revenue growth, and top-cost patients per department. 📊

### Operational Metrics ⏱️📅
Length of stay distribution, ER wait time analysis, bed occupancy breakdown, same-day discharge count, and inpatients without a bed assigned as a data quality check. 📊

### Patient Satisfaction ⭐
Rating distribution, feedback category breakdown, sentiment analysis by department, staff, and patient type, plus correlation between cost and negative sentiment. 📊

### Department Performance 🏥
Department scorecards covering patients, revenue, average cost, average rating, average LOS, average ER time, status breakdown, sentiment split, revenue ranking, cost quartile banding, and departments with high negative sentiment above 20%. 📊

### Staff Performance 👩‍⚕️👨‍⚕️
Staff patient load, revenue contribution, satisfaction percentage, average rating, average ER time, readmission count, five-star patient count, top staff per department, and staff handling both inpatient and outpatient cases. 📊

### Time-Based Trends ⏰
Year-wise and month-wise patient volume and revenue, year-wise sentiment trends, year-wise inpatient/outpatient split, and cumulative patient counts by department. 📊

## 📦 Supporting Materials 📦

These files are deliverables documenting the project findings, not source code. 📄

- `Hospital Dashboard.pbix` — Interactive dashboard requiring Power BI Desktop. 📊
- `Hospital_Project_Report.docx` — Full written report covering methodology, analysis, and conclusions. 📄
- `Hospital-Health-Care-Management.pptx` — Presentation summarising the project for stakeholder communication. 🎤

## 🧩 Dependencies 🧰

To reproduce locally, you may need:

- MySQL 8.0 or compatible
- Python 3.8+
- Libraries: `pandas`, `sqlalchemy`, `pymysql` (for `eda_panda.ipynb`)
- Power BI Desktop (for `Hospital Dashboard.pbix`)

## ▶️ How to Reproduce 🔁

1. Set up MySQL by running `create_database_and_table.sql` to create the `hospital` database and tables. 💾
2. Import the CSV data into the corresponding tables using MySQL import utility or `LOAD DATA INFILE`. 📥
3. Run `column_name_fix.sql` to rename columns. ✨
4. Execute `eda_mysql.sql` section by section in MySQL Workbench or a compatible client. 📊
5. Open `eda_panda.ipynb` in Jupyter Notebook and run all cells. 🐍
6. Open `Hospital Dashboard.pbix` in Power BI Desktop to view the dashboard. 📊

## 👤 Author 🧑

Dharmesh Makwana — [https://github.com/dharmesh9](https://github.com/dharmesh9)
