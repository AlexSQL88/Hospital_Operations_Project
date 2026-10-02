use multi_join_project;

select * from final_hospital_data;
-- ⭐ Business Question 1 – Who are the busiest doctors?
select doctor_id, doctor_full_name,count(appointment_id) as doctor_appointment
from final_hospital_data
group by  doctor_id, doctor_full_name
order by doctor_appointment desc;
