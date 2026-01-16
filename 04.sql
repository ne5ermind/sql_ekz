select
    p.Maker,
    pc.Model as cheapest_model,
    pc.Price as min_price
from Product p
join PC pc on p.Model = pc.Model
where p.Maker in (
    select p2.Maker
    from Product p2
    join Laptop l2 on p2.Model = l2.Model
    where l2.Price = (select max(Price) from Laptop)
)
and pc.Price = (
    select min(pc3.Price)
    from PC pc3
    join Product p3 on pc3.Model = p3.Model
    where p3.Maker in (
        select p4.Maker
        from Product p4
        join Laptop l4 on p4.Model = l4.Model
        where l4.Price = (select max(Price) from Laptop)
    )
);
