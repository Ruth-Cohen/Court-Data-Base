create table years as
select yearClosed as y
from cases_closed
union
select yearOpend as y
from cases_opened
