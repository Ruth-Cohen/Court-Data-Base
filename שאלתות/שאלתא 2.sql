select case_id
from(select def_id, case_id
     from (select def_id, case_id from mistgrate_cases
           minus
           select d_id, case_id
           from court_case natural join mistgrate_cases
           where extract(year from closeDate)>2000)
     where def_id not in(select d_id
                         from (select def_id as d_id from mistgrate_cases
                               minus
                               select d_id
                               from court_case natural join mistgrate_cases
                               where extract(year from closeDate)>2000) natural join court_case
                         where extract(year from closeDate)>2000))
                         
