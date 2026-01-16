select
    t.trip_no,
    c.name as company_name,
    p.name as passenger_name,
    ((day(t.time_in) - day(t.time_out)) * 24 + (datepart(hour, t.time_in) - datepart(hour, t.time_out)) + (datepart(minute, t.time_in) - datepart(minute, t.time_out)) % 60) as hours_in_plane
from Trip t
join Company c on t.ID_comp = c.ID_comp
join Pass_in_trip pit on t.trip_no = pit.trip_no
join Passenger p on pit.ID_psg = p.ID_psg
where t.time_out = (select max(time_out) from Trip)
group by 
    t.trip_no,
    c.name,
    p.name,
    ((day(t.time_in) - day(t.time_out)) * 24 + (datepart(hour, t.time_in) - datepart(hour, t.time_out)) + (datepart(minute, t.time_in) - datepart(minute, t.time_out)) % 60);
