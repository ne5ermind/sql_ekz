select 
    p.name,
    count(pit.ID_psg)
from Passenger p
join Pass_in_trip pit on p.ID_psg = pit.ID_psg
where p.ID_psg in (select ID_psg from Pass_in_trip where substring(place, len(place), len(place)) in ('a', 'd'))
group by p.name;
