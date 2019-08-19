update court_case set verdict =1 
where d_id in (select p_id
              from defendant
              where numPriors <3 ) and case_type = 'criminal'
