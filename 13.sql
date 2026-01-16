SELECT Product.Maker, Product.Model, MIN(COALESCE(PC.Price, Laptop.Price, Printer.Price)) AS 'mn_price', 
MAX(COALESCE(PC.Price, Laptop.Price, Printer.Price)) 'AS mx_price', AVG(COALESCE(PC.Price, Laptop.Price, Printer.Price)) AS 'avg_price'
FROM Product
LEFT JOIN PC ON Product.Model = PC.Model
LEFT JOIN Laptop ON Product.Model = Laptop.Model
LEFT JOIN Printer ON Product.Model = Printer.Model
WHERE Product.Maker IN (SELECT Maker
                        FROM Product
                        WHERE Type IN ('PC', 'Printer')
                        GROUP BY Maker
                        HAVING COUNT(DISTINCT Type) = 2)
GROUP BY Product.Maker, Product.Model
ORDER BY Product.Maker, Product.Model
