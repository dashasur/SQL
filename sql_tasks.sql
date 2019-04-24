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