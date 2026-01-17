select
    t.town_from,
    t.town_to,
    sum(case when year(t.time_in) = 2003 and datepart(month, t.time_in) = 4 then 1 else 0 end) as from_town_in_2003_04,
    sum(case when year(t.time_out) = 2003 and datepart(month, t.time_out) = 4 then 1 else 0 end) as from_town_to_2003_04
from Trip t
GROUP by t.town_from, t.town_to;
