select c_region as region, count(c_region) as numCases
from 
((select J_Id as P_Id, case_Id
  from persides natural join (select*
                              from court_case
                              where extract(year from  openDate)= 2017 and case_type = 'criminal'))
natural join
(select P_Id, c_region
 from judge natural join court))
group by c_region
