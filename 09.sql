SELECT Product.Maker, PC.Model, PC.Price
FROM Product
JOIN PC ON Product.Model = PC.Model
WHERE Product.Maker IN (SELECT Product.Maker
                        FROM Product
                        JOIN Printer ON Product.Model=Printer.Model
                        WHERE Printer.Color = 'y')

UNION ALL

SELECT Product.Maker, Laptop.Model, Laptop.Price
FROM Product
JOIN Laptop ON Product.Model = Laptop.Model
WHERE Product.Maker IN (SELECT Product.Maker
                        FROM Product
                        JOIN Printer ON Product.Model=Printer.Model
                        WHERE Printer.Color = 'y')
