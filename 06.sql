select
    p.Maker,
    pc.Model,
    avg(pc.Price) as avg_price
from Product p
join PC pc on p.Model = pc.Model
group by p.Maker, pc.Model

union all

select
    p.Maker,
    lp.Model,
    avg(lp.Price) as avg_price
from Product p
join Laptop lp on p.Model = lp.Model
group by p.Maker, lp.Model

union all

select
    p.Maker,
    pr.Model,
    avg(pr.Price) as avg_price
from Product p
join Printer pr on p.Model = pr.Model
group by p.Maker, pr.Model;
