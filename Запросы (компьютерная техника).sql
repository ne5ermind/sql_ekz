--Для запросов с компьютерной техникой

--1.	Для производителей, выпускающих ПК и ноутбуки вычислить суммарный объем памяти всех моделей. 
--Вывод: производитель, суммарный объем памяти ПК, суммарный объем памяти ноутбуков
SELECT Product.Maker, SUM(PC.Ram) AS 'sum_ram_pc', SUM(Laptop.RAM) AS 'sum_ram_laptop'
FROM Product
LEFT JOIN PC ON Product.Model = PC.Model
LEFT JOIN Laptop ON Product.Model = Laptop.Model
GROUP BY Product.Maker


--2.	Вывести список моделей ПК и ноутбуков для производителей, которые выпускают цветные принтеры.
--Вывод: производитель, номер модели
SELECT 
    Product.Maker AS 'maker',
    Product.Model AS 'num_model'
FROM Product
WHERE Product.Type IN ('PC', 'Laptop') 
    AND Product.Maker IN (SELECT Product.Maker
        FROM Product
        JOIN Printer ON Product.Model = Printer.Model
        WHERE Printer.Color = 'y')


--3.	Для моделей ПК вывести следующие сведения: производитель, номер модели, 
--минимальная частота процессора, максимальный объем жесткого диска, средняя цена
SELECT Product.Maker AS 'maker', PC.Model AS 'num_model', PC.Speed AS 'mn_speed',
PC.HD AS 'mx_hd', PC.Price AS 'price'
FROM Product
JOIN PC ON Product.Model = PC.Model


--4.	Для производителей самых дорогих ноутбуков найти самую дешевую модель ПК. 
--Вывод: производитель, номер модели самого дешевого ПК, цена.
SELECT DISTINCT t.Maker AS 'maker', t.Model AS 'num_model', t.Price AS 'price'
FROM (SELECT Product.Maker, PC.Model, PC.Price
        FROM Product
        JOIN PC ON Product.Model = PC.Model
        WHERE Product.Maker IN (SELECT Product.Maker
                                FROM Product
                                JOIN Laptop ON Product.Model = Laptop.Model
                                WHERE Laptop.Price = (SELECT MAX(Price) FROM Laptop))
        ) AS t
WHERE t.Price = (SELECT MIN(t2.Price) 
                 FROM(SELECT Product.Maker, PC.Model, PC.Price
                                FROM Product
                                JOIN PC ON Product.Model = PC.Model
                                WHERE Product.Maker IN (SELECT Product.Maker
                                FROM Product
                                JOIN Laptop ON Product.Model = Laptop.Model
                                WHERE Laptop.Price = (SELECT MAX(Price) FROM Laptop))) AS t2)
ORDER BY t.Price


--5.	Для производителя самого дешевого принтера найти самые дешевые ПК и ноутбук.
--Вывод: номер модели, тип устройства, цена
SELECT PC.Model AS 'num_model', 'PC' AS 'type', PC.Price AS 'price'
FROM Product
JOIN PC ON Product.Model = PC.Model
WHERE Product.Maker = (SELECT TOP 1 Maker 
                       FROM Product
                       JOIN Printer ON Product.Model=Printer.Model
                       ORDER BY Printer.Price)
AND PC.Price = (SELECT MIN(Price) 
                FROM Product
                JOIN PC ON Product.Model = PC.Model
                WHERE Product.Maker = (SELECT TOP 1 Maker 
                       FROM Product
                       JOIN Printer ON Product.Model=Printer.Model
                       ORDER BY Printer.Price))
UNION ALL

SELECT Laptop.Model AS 'num_model', 'Laptop' AS 'type', Laptop.Price AS 'price'
FROM Product
JOIN Laptop ON Product.Model = Laptop.Model
WHERE Product.Maker = (SELECT TOP 1 Maker 
                       FROM Product
                       JOIN Printer ON Product.Model=Printer.Model
                       ORDER BY Printer.Price)
AND Laptop.Price = (SELECT MIN(Laptop.Price) 
                FROM Laptop
                JOIN Product ON Laptop.Model = Product.Model
                WHERE Product.Maker IN (SELECT Product.Maker 
                       FROM Product
                       JOIN Printer ON Product.Model=Printer.Model
                       WHERE Printer.Price = (SELECT MIN(Printer.Price) FROM Printer)))


--6.	Найти среднюю цену каждой модели среди всех типов устройств.
--Вывод: производитель, номер модели, средняя цена модели
SELECT Product.Maker AS 'maker', Product.Model AS 'num_model', AVG(COALESCE(PC.Price,Laptop.Price,Printer.Price)) AS 'avg_price'
FROM Product 
LEFT JOIN PC ON Product.Model = PC.Model
LEFT JOIN Laptop ON Product.Model = Laptop.Model
LEFT JOIN Printer ON Product.Model = Printer.Model
GROUP BY Product.Maker, Product.Model


--7.	Вывести список самых дешевых моделей устройств каждого типа.
--Вывод: производитель, тип устройства, номер модели, цена.
SELECT Product.Maker AS 'maker', Product.Model AS 'num_model', 'PC' AS 'type', PC.Price AS 'price'
FROM Product
JOIN PC ON Product.Model = PC.Model
WHERE Product.type = 'PC' AND PC.Price = (SELECT MIN(PC.Price) FROM PC)

UNION ALL

SELECT Product.Maker AS 'maker', Product.Model AS 'num_model', 'Laptop' AS 'type', Laptop.Price AS 'price'
FROM Product
JOIN Laptop ON Product.Model = Laptop.Model
WHERE Product.type = 'Laptop' AND Laptop.Price = (SELECT MIN(Laptop.Price) FROM Laptop)

UNION ALL

SELECT Product.Maker AS 'maker', Product.Model AS 'num_model', 'Printer' AS 'type', Printer.Price AS 'price'
FROM Product
JOIN Printer ON Product.Model = Printer.Model
WHERE Product.type = 'Printer' AND Printer.Price = (SELECT MIN(Printer.Price) FROM Printer)


--8.	Для производителя ПК с самым большим номером модели из таблицы PC вывести список моделей ноутбуков этого производителя. 
--Вывод: производитель, номер модели
SELECT Product.Maker, Laptop.Model
FROM Product
JOIN Laptop ON Product.Model = Laptop.Model
WHERE Product.Maker IN (SELECT Maker
                       FROM Product
                       JOIN PC ON Product.Model=PC.Model
                       WHERE Product.Model = (SELECT MAX(Model) FROM PC))


--9.	Для производителей цветных принтеров вывести список моделей остальных типов устройств (ПК и ноутбуки).
--Вывод: производитель, модель, цена.
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


--10.	Для производителей, которые производят только ПК или только принтеры 
--вывести следующую информацию: производитель, тип устройства, средняя цена всех моделей этого производителя.
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


--11.	Вывести перечень моделей ПК, скорость процессора которых больше средней скорости процессоров ноутбуков.
--Вывод: номер модели, минимальная скорость процессора, максимальная скорость процессора, средняя цена.
SELECT PC.Model, MIN(PC.Speed) AS 'mn_speed', MAX(PC.Speed) AS 'mx_speed', AVG(PC.Price) AS 'avg_price'
FROM PC
WHERE PC.Speed > (SELECT AVG(Laptop.Speed) FROM Laptop)
GROUP BY PC.Model


--12.	Для ПК и ноутбуков вывести перечень моделей, которые имеют более одного варианта исполнения.
--Вывод: номер модели, тип устройства, скорость процессора, объем памяти, объем жесткого диска, цена.
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


--13.	Для производителей, которые выпускают как минимум ПК и принтеры вывести перечень всех моделей.
--Вывод: производитель, номер модели, минимальная цена модели, максимальная цена модели, средняя цена модели.
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


--14.	Для производителей ноутбуков с самым большим размером экрана вывести список моделей всех выпускаемых типов устройств.
--Вывод: производитель, модель, цена. Упорядочить набор по возрастанию значения каждого поля.
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


