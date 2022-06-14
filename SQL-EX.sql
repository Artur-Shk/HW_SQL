Схема БД состоит из четырех таблиц:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. В таблице PC для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), скорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), скорость считывающего устройства - cd (например, '4x') и цена - price (в долларах). Таблица Laptop аналогична таблице РС за исключением того, что вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице Printer для каждой модели принтера указывается, является ли он цветным - color ('y', если цветной), тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.
=================================================

// 1. Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd.
SELECT model, speed, hd FROM PC WHERE price < 500;
==================================================

// 2. Найдите производителей принтеров. Вывести: maker
SELECT DISTINCT Maker FROM product WHERE type = 'printer';
===================================================  

// 3.Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.
SELECT model, ram, screen FROM laptop WHERE price > 1000;
===================================================

// 4. Найдите все записи таблицы Printer для цветных принтеров.
SELECT * FROM printer WHERE color = 'y';
===================================================

// 5. Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.
SELECT model, speed, hd FROM PC WHERE (CD = '12x' OR CD ='24x') AND price < 600;

SELECT model, speed, hd FROM PC WHERE CD IN ('12x', '24x') AND price < 600;
===================================================

// 6. Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.
SELECT DISTINCT maker, speed FROM Product INNER JOIN Laptop on Product.model = Laptop.model WHERE hd >= 10;
===================================================

// 7. Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).
SELECT DISTINCT PC.model, price FROM product JOIN PC ON product.model = PC.model WHERE maker = 'B'
UNION
SELECT DISTINCT Laptop.model, price FROM product JOIN Laptop ON product.model = Laptop.model WHERE maker = 'B'
UNION
SELECT DISTINCT Printer.model, price FROM product JOIN Printer ON product.model = Printer.model WHERE maker = 'B';
====================================================

// 8. Найдите производителя, выпускающего ПК, но не ПК-блокноты.
SELECT maker FROM product WHERE type = 'pc'
EXCEPT 
SELECT maker FROM product WHERE type = 'laptop'

SELECT DISTINCT maker FROM product WHERE type = 'PC' AND maker NOT IN (SELECT maker FROM product WHERE type = 'LAPTOP')
===================================================

// 9.Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
SELECT maker FROM product JOIN PC ON product.model = PC.model WHERE speed >= 450 GROUP BY maker
===================================================

// 10. Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price
SELECT model, price FROM printer WHERE price = (SELECT MAX(price) FROM printer);
===================================================

// 11. Найдите среднюю скорость ПК.
SELECT AVG (speed) AS AVG_Speed FROM PC
===================================================

// 12. Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.
SELECT AVG (speed) AS AVG_Speed FROM laptop WHERE price > 1000

// 13. Найдите среднюю скорость ПК, выпущенных производителем A.
SELECT AVG (speed) FROM Product JOIN PC ON Product.model = PC.model WHERE maker = 'A'
===================================================

// 14. Рассматривается БД кораблей, участвовавших во второй мировой войне. Имеются следующие отношения:
Classes (class, type, country, numGuns, bore, displacement)
Ships (name, class, launched)
Battles (name, date)
Outcomes (ship, battle, result)
Корабли в «классах» построены по одному и тому же проекту, и классу присваивается либо имя первого корабля, построенного по данному проекту, либо названию класса дается имя проекта, которое не совпадает ни с одним из кораблей в БД. Корабль, давший название классу, называется головным.
Отношение Classes содержит имя класса, тип (bb для боевого (линейного) корабля или bc для боевого крейсера), страну, в которой построен корабль, число главных орудий, калибр орудий (диаметр ствола орудия в дюймах) и водоизмещение ( вес в тоннах). В отношении Ships записаны название корабля, имя его класса и год спуска на воду. В отношение Battles включены название и дата битвы, в которой участвовали корабли, а в отношении Outcomes – результат участия данного корабля в битве (потоплен-sunk, поврежден - damaged или невредим - OK).
Замечания. 1) В отношение Outcomes могут входить корабли, отсутствующие в отношении Ships. 2) Потопленный корабль в последующих битвах участия не принимает.

// Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.
SELECT ships.class, name, country FROM Ships join Classes ON Classes.class = Ships.class WHERE numGuns >=10
====================================================

// 15. Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD
SELECT HD FROM PC GROUP BY HD HAVING COUNT (*) >=2
====================================================
\\ 16. Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.
SELECT DISTINCT PC1.model, PC2.model, PC1.speed, PC1.ram FROM PC PC1, PC PC2 WHERE PC1.speed=PC2.speed AND PC1.RAM=PC2.RAM AND PC1.model > PC2.model;
====================================================

// 17. Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК. Вывести: type, model, speed
SELECT DISTINCT type, laptop.model, speed FROM laptop JOIN product ON laptop.model=product.model WHERE speed < ALL (SELECT speed FROM PC);
====================================================

//. 18. Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
SELECT DISTINCT maker, price FROM printer JOIN product ON printer.model=product.model WHERE price = (SELECT MIN(price) FROM printer WHERE color = 'Y') AND color = 'Y' 
====================================================

// 19. Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.
SELECT maker, AVG(screen) AS Avg_screen FROM product JOIN laptop ON product.model = laptop.model GROUP BY maker;
====================================================

// 20. Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.
SELECT maker, COUNT(model) COUNT_MODEL FROM product WHERE type = 'PC' GROUP BY maker HAVING COUNT(model) >= 3;

// 21. Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
Вывести: maker, максимальная цена.
SELECT maker, MAX(price) Max_price FROM product JOIN PC ON product.model = PC.model GROUP BY maker

// 22. Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.
SELECT speed, AVG(price) Avg_price FROM PC WHERE speed > 600 GROUP BY speed

// 23. Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
SELECT maker FROM product JOIN PC ON product.model=PC.model WHERE speed >= 750
INTERSECT
SELECT maker FROM product JOIN laptop ON product.model=laptop.model WHERE speed >= 750
========================================================
// 24. Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.
WITH table_1 AS 
(SELECT model, price FROM PC
UNION
SELECT model, price FROM Laptop
UNION
SELECT model, price FROM Printer) 
SELECT model FROM table_1 WHERE price IN (SELECT MAX(price) FROM table_1)
// 25. Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
SELECT DISTINCT maker FROM product JOIN PC ON product.model=PC.model WHERE maker 
IN
(SELECT maker FROM product WHERE type = 'printer') 
AND
speed = (SELECT MAX(speed) from PC WHERE ram = (SELECT MIN(ram) from PC)) 
AND 
ram = (SELECT MIN(ram) from PC)
=======================================================
// 26. Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.

WITH TABLE_1 AS 
(SELECT price FROM product JOIN PC ON 
product.model=PC.model WHERE maker = 'A'
UNION ALL
SELECT price FROM product JOIN laptop ON product.model=laptop.model WHERE maker = 'A') 
SELECT AVG(price) AS AVG_price FROM TABLE_1 

ИЛИ ТАК

SELECT AVG(price) AS AVG_price FROM
(SELECT price FROM product JOIN PC ON 
product.model=PC.model WHERE maker = 'A'
UNION ALL
SELECT price FROM product JOIN laptop ON product.model=laptop.model WHERE maker = 'A') TABLE_1
========================================================
// 27.  Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.
SELECT  maker, AVG(hd) AS Avg_hd FROM PCJOIN product ON pc.model = product.model 
WHERE maker IN (SELECT DISTINCT maker FROM product where type = 'printer') GROUP by maker
// 28.  Используя таблицу Product, определить количество производителей, выпускающих по одной модели.
SELECT COUNT(maker) AS QTY FROM (Select maker from product GROUP BY maker HAVING COUNT(model) =1) TABLE_1

ИЛИ ТАК

SELECT COUNT(maker) AS QTY FROM product WHERE maker IN (Select maker from product GROUP BY maker HAVING COUNT(model) =1)

// 29. The firm owns several buy-back centers for collection of recyclable materials. Each of them receives funds to be paid to the recyclables  suppliers. Data on funds received is recorded in the table
Income_o(point, date, inc)
The primary key is (point, date), where point holds the identifier of the buy-back center, and date corresponds to the calendar date the funds were received. The date column doesn’t include the time part, thus, money (inc) arrives no more than once a day for each center. Information on payments to the recyclables suppliers is held in the table
Outcome_o(point, date, out)
In this table, the primary key (point, date) ensures each buy-back center reports about payments (out) no more than once a day, too.
For the case income and expenditure may occur more than once a day, another database schema with tables having a primary key consisting of the single column code is used:
Income(code, point, date, inc)
Outcome(code, point, date, out)
Here, the date column doesn’t include the time part, either.

Exercise::
Under the assumption that receipts of money (inc) and payouts (out) are registered not more than once a day for each collection point [i.e. the primary key consists of (point, date)], write a query displaying cash flow data (point, date, income, expense).
Use Income_o and Outcome_o tables.

SELECT Income_o.point, Income_o.date, inc, out FROM Income_o LEFT JOIN Outcome_o ON Income_o.point=Outcome_o.point AND Income_o.date=Outcome_o.date
UNION 
SELECT Outcome_o.point, Outcome_o.date, inc, out FROM Income_o RIGHT JOIN Outcome_o ON Income_o.point=Outcome_o.point AND Income_o.date=Outcome_o.date

// 30. Under the assumption that receipts of money (inc) and payouts (out) can be registered any number of times a day for each collection point [i.e. the code column is the primary key], display a table with one corresponding row for each operating date of each collection point.
Result set: point, date, total payout per day (out), total money intake per day (inc).
Missing values are considered to be NULL.

SELECT point, date, SUM(out) AS out, SUM(inc) AS inc
FROM (SELECT point, date, out, null AS inc FROM Outcome
UNION ALL
SELECT point, date, null AS out, inc FROM Income) TABLE_1
GROUP BY point, date