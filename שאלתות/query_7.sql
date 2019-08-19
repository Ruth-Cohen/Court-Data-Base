select P_Id, first_name, last_name
from defendant natural join person
where P_Id in(select D_Id
              from court_case
              where case_type = 'criminal')
              or P_Id IN (select D_Id from court_case
                          where extract (year from CURRENT_DATE) - extract (year from closeDate)<= 7)
order by P_Id
              
