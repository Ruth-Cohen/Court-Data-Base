delete from defendant
where p_id in(select case_id 
              from court_case
              where d_id in(select p_id
                            from lawyer
                            union
                            select p_id
                            from judge))
             
