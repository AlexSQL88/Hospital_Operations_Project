use multi_join_project;

select * from final_hospital_data;
-- Business Question 2 – What are the most common treatments
select treatment_type, count(*) most_common_treatment
from final_hospital_data
group by treatment_type
order by most_common_treatment desc;
