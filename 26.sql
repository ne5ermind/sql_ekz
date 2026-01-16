select
    t.trip_no,
    c.name as company_name,
    pit.date as departure_date,
    t.time_out,
    t.town_from,
    t.town_to
from Trip t
join Company c on t.ID_comp = c.ID_comp
join Pass_in_trip pit on t.trip_no = pit.trip_no
group by
    t.trip_no,
    c.name,
    pit.date,
    t.time_out,
    t.town_from,
    t.town_to
having count(pit.ID_psg) > 1;
