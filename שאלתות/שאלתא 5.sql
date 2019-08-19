select P_id, first_name, last_name, closed_cases, c_region, court_type
from person natural join judge natural join court 
     natural join (select J_Id, count(J_Id) as closed_cases
                   from persides
                   natural join
                  (select case_id
                   from court_case
                   where ((CURRENT_DATE - closeDate) <= 30 AND extract (month from closeDate) = extract (month from CURRENT_DATE)))
                   group by J_Id)
where J_ID = P_ID 

