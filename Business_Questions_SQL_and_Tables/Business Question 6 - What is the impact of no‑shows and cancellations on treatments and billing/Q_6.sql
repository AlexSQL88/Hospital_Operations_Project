select * from final_hospital_data;

select
    appointment_id,
    treatment_id,
    status,
    treatment_type
from final_hospital_data
where status in ('No-show', 'Cancelled');

select
    status,
    COUNT(*) AS appointment_count
from final_hospital_data
where status IN ('No-show', 'Cancelled')
group by status;