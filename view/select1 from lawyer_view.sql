select * from lawyer_view
where num_cases >= all(select num_cases
                       from lawyer_view)
