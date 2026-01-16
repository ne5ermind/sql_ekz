select
    p.name,
    t.plane,
    count(pit.ID_psg) as num_of_trips
from Passenger p
join Pass_in_trip pit on p.ID_psg = pit.ID_psg
join Trip t on pit.trip_no = t.trip_no
group by
    p.name,
    t.plane
order by
    p.name asc,
    num_of_trips desc;
