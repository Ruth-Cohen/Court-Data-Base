select specialization, count(specialization) as num_lawyers
from lawyer
group by specialization
having count (*) >= all (select count (specialization)
                         from lawyer
                         group by specialization)
                         
     
