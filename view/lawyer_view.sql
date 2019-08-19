create view lawyer_view(l_id,first_name,last_name,num_cases,specialization,city)
as select p_id,
          first_name,
          last_name,
          count(p_id),
          specialization,
          city
from lawyer natural join person natural join (select l_id as p_id
from court_case)
group by p_id, first_name,last_name, specialization,city
