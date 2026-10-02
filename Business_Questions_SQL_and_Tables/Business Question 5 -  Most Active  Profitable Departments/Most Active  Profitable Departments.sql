select * from final_hospital_data;

select 
specialization, count(appointment_id) as number_of_appointments,
round(sum(amount),2) as amount_paid
from final_hospital_data
where payment_status = 'Paid'
group by specialization
order by amount_paid desc;




