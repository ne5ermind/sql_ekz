select
    p.Maker,
    p.Model,
    min(pc.Speed) as min_cpu_speed,
    max(pc.HD) as max_hd_size,
    sum(pc.Price) / COUNT(pc.Id) as avg_price
from Product p
join PC pc on p.Model = pc.Model
group by p.Maker, p.Model;
