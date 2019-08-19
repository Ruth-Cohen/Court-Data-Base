select*
from
(select yearClosed as y, numCasesClose as num_Cases_Close
 from cases_closed 
 union
 select y, 0 as num_CasesClose 
 from(select years.y
      from years
      where years.y NOT IN (select yearClosed from cases_closed)))
natural join
(select yearOpend as y, numCasesOpen as num_Cases_Open
 from cases_opened 
 union
  select y, 0 as num_CasesOpen
  from(select years.y
       from years
       where years.y NOT IN (select yearOpend from cases_opened)))
