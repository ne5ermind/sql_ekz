SELECT PC.Model, MIN(PC.Speed) AS 'mn_speed', MAX(PC.Speed) AS 'mx_speed', AVG(PC.Price) AS 'avg_price'
FROM PC
WHERE PC.Speed > (SELECT AVG(Laptop.Speed) FROM Laptop)
GROUP BY PC.Model
