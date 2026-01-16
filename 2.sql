select
    p.Maker,
    p.Model
from Product p
where p.Maker in (
    select pr.Maker
    from Product pr
    join Printer ptr on pr.Model = ptr.Model
    where ptr.Color = 'y'
)
and p.[Type] in ('PC', 'Laptop');
