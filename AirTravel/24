select
    t.trip_no,
    c.name,
    t.town_from,
    t.town_to,
    count(distinct t.time_out) as number_of_trips,
    count(pit.ID_psg) as number_of_passangers
from Trip t
join Company c on t.ID_comp  = c.ID_comp
left join Pass_in_trip pit on t.trip_no = pit.trip_no
group by t.trip_no, c.name, t.town_from, t.town_to;
