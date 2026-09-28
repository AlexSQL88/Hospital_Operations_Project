USE multi_join_project;

-- Purpose:
-- Persist the validated Final_CTE as a permanent table for downstream analysis
-- and Power BI.
--
-- Interview explanation:
-- Once I was satisfied with the validation results, I persisted the final CTE
-- as a permanent table for downstream analysis.

-- Create the permanent analytical table.
CREATE TABLE final_hospital_data AS
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

SELECT *
FROM Final_CTE;

-- Verify that the permanent table was created successfully.
SELECT *
FROM final_hospital_data;
