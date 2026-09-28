USE multi_join_project;

-- Purpose:
-- Build a combined analytical dataset from the hospital management source tables.
--
-- Interview explanation:
-- I first used CTEs to combine the source tables. I then validated the resulting
-- dataset by checking the row count, duplicate appointment IDs, treatment coverage
-- and billing coverage.

use multi_join_project;
-- First CTE combining (Appointments + Patients + Doctors)
WITH CTE_1 AS (
    SELECT
    -- Appointments info
        a.appointment_id,
        a.appointment_date,
        a.appointment_time,
        a.reason_for_visit,
        a.status,

        -- Patient info
        p.patient_id,
        CONCAT(p.first_name, ' ', p.last_name) AS patient_full_name,

        -- Doctor info
        d.doctor_id,
        CONCAT(d.first_name, ' ', d.last_name) AS doctor_full_name,
        d.specialization,
        d.hospital_branch

    FROM appointments a
    JOIN patients p
        ON a.patient_id = p.patient_id
    JOIN doctors d
        ON a.doctor_id = d.doctor_id
),
-- Second CTE combining Clinical + Financial (Treatments + Billing)
CTE_2 AS (
    SELECT
     -- Treatments info
        t.treatment_id,
        t.appointment_id,
        t.treatment_type,
        t.description,
        t.cost,
        t.treatment_date,
         -- Billing info
        b.bill_id,
        b.bill_date,
        b.amount,
        b.payment_method,
        b.payment_status

    FROM treatments t
    LEFT JOIN billing b
        ON t.treatment_id = b.treatment_id
),
-- Final CTE combining (Appointments + Patients + Doctors,Treatments, Billing)
Final_CTE AS (
    SELECT
      -- Appointments info
        CTE_1.appointment_id,
        CTE_1.appointment_date,
        CTE_1.appointment_time,
        CTE_1.reason_for_visit,
        CTE_1.status,

        -- Patient info
        CTE_1.patient_id,
        CTE_1.patient_full_name,

        -- Doctor info
        CTE_1.doctor_id,
        CTE_1.doctor_full_name,
        CTE_1.specialization,
        CTE_1.hospital_branch,

        -- Treatment info
        CTE_2.treatment_id,
        CTE_2.treatment_type,
        CTE_2.description,
        CTE_2.cost,
        CTE_2.treatment_date,

        -- Billing info
        CTE_2.bill_id,
        CTE_2.bill_date,
        CTE_2.amount,
        CTE_2.payment_method,
        CTE_2.payment_status

    FROM CTE_1
    LEFT JOIN CTE_2
        ON CTE_1.appointment_id = CTE_2.appointment_id
)

-- Validation 1: Check the total number of rows in the final dataset.
-- Expected result from this project: 200 rows.
SELECT COUNT(*) AS total_rows
FROM Final_CTE;

-- Validation 2: Check for duplicate appointment IDs.
-- Expected result from this project: 0 rows returned.
SELECT
    appointment_id,
    COUNT(*) AS number_of_rows
FROM Final_CTE
GROUP BY appointment_id
HAVING COUNT(*) > 1;

-- Validation 3: Confirm that every final row has treatment information.
-- Expected result from this project: 200 total rows and 200 rows with treatment.
SELECT
    COUNT(*) AS total_rows,
    COUNT(treatment_id) AS rows_with_treatment
FROM Final_CTE;

-- Validation 4: Confirm that every final row has billing information.
-- Expected result from this project: 200 total rows and 200 rows with billing.
SELECT
    COUNT(*) AS total_rows,
    COUNT(bill_id) AS rows_with_billing
FROM Final_CTE;

-- Review the final combined dataset after validation.
SELECT *
FROM Final_CTE;
