SELECT PC.Model, 'PC' AS 'type', PC.Speed, PC.Ram, PC.HD, PC.Price
FROM PC
WHERE PC.Model IN (SELECT Model
                   FROM PC
                   GROUP BY Model
                   HAVING COUNT(*) > 1)
UNION ALL
SELECT Laptop.Model, 'Laptop' AS 'type', Laptop.Speed, Laptop.Ram, Laptop.HD, Laptop.Price
FROM Laptop
WHERE Laptop.Model IN (SELECT Model
                   FROM Laptop
                   GROUP BY Model
                   HAVING COUNT(*) > 1)
