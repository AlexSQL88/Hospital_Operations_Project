📊 Hospital Management Analysis — SQL + Power BI Project
📁 Project Overview
This project analyses a hospital management dataset from Kaggle using SQL for data preparation and Power BI for data visualisation.
The goal is to simulate a real junior analyst workflow:

explore raw data

build CTE‑based SQL transformations

answer business questions

visualise insights in Power BI

organise everything clearly for portfolio presentation

📂 Dataset Description
The raw dataset contains five CSV files stored in the /raw_data folder:

appointments.csv — appointment details (patient, doctor, date, status)

patients.csv — patient demographics and insurance information

doctors.csv — doctor details (specialization, branch, experience)

treatments.csv — treatment performed for each appointment

billing.csv — financial information for each treatment

These tables form the basis of the SQL analysis.

❓ Business Questions
This project answers several realistic hospital management questions, including:

Which doctor has the most appointments

Which treatments occur most often

Which patients generate the highest revenue

What is the no‑show rate and cancellation impact

Which departments are busiest or most profitable

Each question has its own SQL query and Power BI visual.

🧩 SQL Workflow
SQL is used to clean, join, and filter the data.
The workflow follows a structured approach:

CTE #1 — Activity Dataset
Combines:

appointments

patients

doctors
Purpose: understand hospital activity (visits, doctors, branches, statuses).

CTE #2 — Clinical & Financial Dataset
Combines:

treatments

billing
Purpose: understand treatments performed and financial outcomes.

Final Join
Links CTE #1 and CTE #2 using appointment_id.
This creates a complete dataset containing:

patient info

doctor info

appointment info

treatment info

billing info

Business Question Queries
For each question, a dedicated SQL query is written using the final joined dataset.

All SQL logic (CTE #1, CTE #2, final join, and the question query) is saved in:
/filtered_data/<question_name>/

📄 Filtered Datasets
Each business question has its own folder inside /filtered_data, containing:

cte1.txt — logic for CTE #1

cte2.txt — logic for CTE #2

final_join.txt — logic combining both CTEs

query.txt — SQL query answering the question

<question_name>.csv — exported filtered dataset used in Power BI

This structure clearly separates raw data, SQL logic, and final outputs.

📊 Power BI Dashboard
Power BI is used only for visualising the filtered datasets, not for modelling the raw tables.

The dashboard includes visuals for each business question, such as:

Busiest doctors

Most common treatments

Revenue by patient

Appointment status distribution

No‑show  and  cancelled rate

Department performance

The Power BI file and a PDF export are stored in:
/project_dashboard

🛠️ Tools Used
SQL (MySQL / PostgreSQL / SQL Server — depending on your setup)

MySQL

Excel / CSV

Power BI

GitHub

🔁 How to Reproduce
Download the repository

Review raw CSVs in /raw_data

Open SQL files in /filtered_data to see the logic

Load the filtered CSVs into Power BI

Open dashboard.pbix to view the final dashboard

Use the PDF version if Power BI is unavailable

🚀 Future Improvements
Add more business questions

Introduce window functions for advanced analysis

Build a full Power BI data model using raw tables

Add DAX measures for deeper insights

Expand dashboard with drill‑downs and tooltips
