select 
    c.name as company_name,
    sum(case when day(pit.date) % 2 = 0 then 1 else 0 end) as even_day_passangers,
    sum(case when day(pit.date) % 2 = 1 then 1 else 0 end) as odd_day_passangers
from Company c
join Trip t on c.ID_comp = t.ID_comp
join Pass_in_trip pit on t.trip_no = pit.trip_no
group by c.name;
