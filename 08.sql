select
    p.Maker,
    p.Model,
    p.Type,
    pc.Price
from Product p
join PC pc on p.Model = pc.Model
where pc.Price <= (select min(Price) from PC)

union all

select top 1
    p.Maker,
    p.Model,
    p.Type,
    lp.Price
from Product p
join Laptop lp on p.Model = lp.Model
where lp.Price <= (select min(Price) from Laptop)

union all

select top 1
    p.Maker,
    p.Model,
    p.Type,
    pr.Price
from Product p
join Printer pr on p.Model = pr.Model
where pr.Price <= (select min(Price) from Printer);
