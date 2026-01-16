select
    pit.trip_no,
    p.name
from Pass_in_trip pit
join Passenger p on pit.ID_psg = p.ID_psg
where pit.trip_no = (
    select top 1
        trip_no
    from Pass_in_trip
    group by trip_no
    order by count(ID_psg) desc
)
order by
    pit.trip_no asc,
    p.name asc;
