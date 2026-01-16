select
    t.plane,
    t.town_from,
    count(pit.ID_psg) as number_of_passangers
from Trip t
join Pass_in_trip pit on t.trip_no = pit.trip_no
group by t.plane, t.town_from
