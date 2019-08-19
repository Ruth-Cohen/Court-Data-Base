create view  judge_view(j_id,first_name,last_name,court_region,court_type,birthdate)
as select p_id,
          first_name,
          last_name,
          c_region,
          court_type,
          birthdate
from court natural join judge natural join person 
order by first_name
