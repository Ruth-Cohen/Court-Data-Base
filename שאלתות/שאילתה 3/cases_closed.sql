create table cases_closed as
select extract(year from closeDate) as yearClosed, count(extract(year from closeDate)) as numCasesClose
from court_case
where case_type= 'adoption'
group by extract (year from CloseDate)
