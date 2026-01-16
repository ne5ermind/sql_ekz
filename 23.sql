select
    t.town_from,
    sum(case when datepart(hour, pit.date) % 12 = 0 then 1 else 0 end) as before_noon,
    sum(case when datepart(hour, pit.date) % 12 = 1 then 1 else 0 end) as past_noon
from Trip t
join Pass_in_trip pit on t.trip_no = pit.trip_no
group by t.town_from
