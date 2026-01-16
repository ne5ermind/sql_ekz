select
    c.name,
    month(pit.date) as flight_month,
    year(pit.date) as flight_year,
    count(pit.ID_psg) as passanger_count
from Company c
join Trip t on c.ID_comp = t.ID_comp
join Pass_in_trip pit on t.trip_no = pit.trip_no
group by 
    c.name,
    month(pit.date),
    year(pit.date) 
order by 
    flight_year asc,
    flight_month asc,
    passanger_count desc;
