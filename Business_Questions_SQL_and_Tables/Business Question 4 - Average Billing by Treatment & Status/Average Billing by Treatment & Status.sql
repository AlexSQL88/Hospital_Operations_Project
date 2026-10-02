select * from final_hospital_data;

select 
    treatment_type, 
    payment_status, 
    round(avg(amount),2) as avg_amount
from final_hospital_data
where payment_status IN ('Paid', 'Pending', 'Failed')
group by treatment_type, payment_status
order by treatment_type, payment_status, avg_amount desc;
