SELECT Product.Maker, Product.Model, COALESCE(PC.Price, Laptop.Price, Printer.Price) AS 'price'
FROM Product
LEFT JOIN PC ON Product.Model = PC.Model
LEFT JOIN Laptop ON Product.Model = Laptop.Model
LEFT JOIN Printer ON Product.Model = Printer.Model
WHERE Product.Maker IN (SELECT Maker
                        FROM Product
                        JOIN Laptop ON Product.Model = Laptop.Model
                        WHERE Laptop.Screen = (SELECT MAX(Screen) FROM Laptop))
ORDER BY Product.Maker, Product.Model, price

