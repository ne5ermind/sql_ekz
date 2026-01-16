select
    c.name as company_name,
    t.plane as plane_type,
    count(pit.ID_psg) as passanger_count
from Company c
join trip t on c.ID_comp = t.ID_comp
join Pass_in_trip pit on t.trip_no = pit.trip_no
group by c.name, t.plane;
