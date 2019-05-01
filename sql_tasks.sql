--#17 Найдите модели ПК-блокнотов, скорость которых меньше скорости любого из ПК.
--Вывести: type, model, speed
SELECT DISTINCT type,
                product.model,
                speed
FROM   product,
       laptop
WHERE  product.model = laptop.model
       AND speed < ALL (SELECT speed
                        FROM   pc)  

--#18 Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price 
SELECT DISTINCT maker,
                price
FROM   product
       JOIN printer
         ON product.model = printer.model
WHERE  color = 'y'
       AND price IN (SELECT Min(b.price)
                     FROM   (SELECT price
                             FROM   printer
                             WHERE  color = 'y') AS b)  


--#19 Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
--Вывести: maker, средний размер экрана. 
SELECT maker,
       Avg(screen) AS Avg_screen
FROM   product
       JOIN laptop
         ON product.model = laptop.model
GROUP  BY maker  

--#20 Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК. 
SELECT maker,
       Count(DISTINCT product.model) AS COUNT_model
FROM   pc,
       product
WHERE  type = 'PC'
GROUP  BY maker
HAVING Count(DISTINCT product.model) > 2  

--#21 Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
Вывести: maker, максимальная цена. 
SELECT maker, MAX(price)
FROM PC,Product
Where PC.model=Product.model
Group BY maker


--#22 Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.
SELECT speed,
       Avg(price) AS Avg_price
FROM   pc
WHERE  speed > 600
GROUP  BY speed  

--#2 Добавить в таблицу Product следующие продукты производителя Z:принтер модели 4003, ПК модели 4001 и блокнот модели 4002 
INSERT INTO product
VALUES      ('Z',
             4003,
             'Printer'),
            ('Z',
             4001,
             'PC'),
            ('Z',
             4002,
             'Laptop');  
--#4 Для каждой группы блокнотов с одинаковым номером модели добавить запись в таблицу PC со следующими характеристиками:
--код: минимальный код блокнота в группе +20;
--модель: номер модели блокнота +1000;
--скорость: максимальная скорость блокнота в группе;
--ram: максимальный объем ram блокнота в группе *2;
---hd: максимальный объем hd блокнота в группе *2;
--cd: значение по умолчанию;
--цена: максимальная цена блокнота в группе, уменьшенная в 1,5 раза.
--Замечание. Считать номер модели числом. 
INSERT INTO pc
            (code,
             model,
             speed,
             ram,
             hd,
             price)
SELECT Min(code) + 20,
       model + 1000,
       Max(speed),
       Max(ram) * 2,
       Max(hd) * 2,
       Max(price) / 1.5
FROM   laptop
GROUP  BY model  
--#5 Удалить из таблицы PC компьютеры, имеющие минимальный объем диска или памяти. 
DELETE FROM pc
WHERE  ram IN (SELECT Min(ram)
               FROM   pc)
        OR hd IN (SELECT Min(hd)
                  FROM   pc)  