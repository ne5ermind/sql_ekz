select (
    p.Maker,
    sum(case when p.Type = 'PC' then pc.Ram else 0 end) as tot_pc_ram,
    sum(case when p.Type = 'Laptop' then laptop.Ram else 0 end) as tot_lp_ram
) from Product p
left join PC pc on p.Model
left join Laptop laptop on p.Model
where p.Maker in (
    select Maker from Product where Type = 'PC'
    INTERSECT
    select Maker from Product where Type = 'PC'
) 
group by p.Maker;
