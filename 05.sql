select
    p.Model,
    p.Type,
    pc.Price
from Product p
join PC pc on p.Model = pc.Model
where p.Maker in (
    select p1.Maker from Product p1
    join Printer pr on p1.Model = pr.Model
    where pr.Price = (select min(Printer.Price) from Printer)
)
and pc.Price = (
    select min(pc2.Price)
    from PC pc2
    join Product p2 on pc2.Model = p2.Model
    where p2.Maker in (
        select p2.Maker from Product p2
        join Printer pr on p2.Model = pr.Model
        where pr.Price = (select min(Printer.Price) from Printer)
    )
)

UNION ALL

select
    p.Model,
    p.Type,
    lp.Price
from Product p
join Laptop lp on p.Model = lp.Model
where p.Maker in (
    select p1.Maker from Product p1
    join Printer pr on p1.Model = pr.Model
    where pr.Price = (select min(Printer.Price) from Printer)
)
and lp.Price = (
    select min(lp2.Price)
    from Laptop lp2
    join Product p2 on lp2.Model = p2.Model
    where p2.Maker in (
        select p2.Maker from Product p2
        join Printer pr on p2.Model = pr.Model
        where pr.Price = (select min(Printer.Price) from Printer)
    )
);
