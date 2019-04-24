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

--#18
Select product.maker,price
FROM (SELECT MIN(price)
FROM printer
WHERE color = 'y'
)

--#19 Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
--Вывести: maker, средний размер экрана. 
SELECT maker,
       Avg(screen) AS Avg_screen
FROM   product
       JOIN laptop
         ON product.model = laptop.model
GROUP  BY maker  