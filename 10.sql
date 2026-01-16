SELECT Product.Maker, Product.Type, AVG(COALESCE(PC.Price, Printer.Price)) AS 'avg_price'
FROM Product
LEFT JOIN PC ON Product.Model = PC.Model
LEFT JOIN Printer ON Product.Model = Printer.Model
WHERE Product.Type IN ('PC', 'Printer')
    AND Product.Maker IN (SELECT Maker
                          FROM Product
                          WHERE Type IN ('PC', 'Printer')
                          GROUP BY Maker
                          HAVING COUNT(DISTINCT Type) = 1
                          )
GROUP BY Product.Maker, Product.Type
