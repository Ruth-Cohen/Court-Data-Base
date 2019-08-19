update judge set c_id =1
where p_id in (select p_id
               from judge
               where (c_id = 2 or c_id = 3 or c_id = 4)and extract (year from CURRENT_DATE)- extract(year from startdate)>10)
