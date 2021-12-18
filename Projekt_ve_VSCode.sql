select 
	cbd.date,
 	country,
	confirmed 
from covid19_basic_differences cbd 
where 1=1
 	and confirmed is not null 
order by date;