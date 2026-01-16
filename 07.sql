select
    p.Maker,
    p.Model,
    pc.Price
from Product p
join PC pc on p.Model = pc.Model
where pc.Price <= (select avg(Price) from PC)

union all

select
    p.Maker,
    p.Model,
    lp.Price
from Product p
join Laptop lp on p.Model = lp.Model
where lp.Price <= (select avg(Price) from Laptop)

union all

select
    p.Maker,
    p.Model,
    pr.Price
from Product p
join Printer pr on p.Model = pr.Model
where pr.Price <= (select avg(Price) from Printer)
