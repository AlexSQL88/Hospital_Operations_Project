use multi_join_project;

SELECT 
    patient_id,
    ROUND(SUM(amount), 2) AS total_revenue,
    ROUND(
        SUM(amount) * 100.0 / SUM(SUM(amount)) OVER (), 
        2
    ) AS revenue_percentage  -- Adding a percentage column to show each patient’s share of total paid revenue
FROM final_hospital_data
WHERE payment_status = 'Paid'
GROUP BY patient_id
ORDER BY total_revenue DESC;