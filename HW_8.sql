/*
1. Найдите все записи таблицы Printer для цветных принтеров.
*/

SELECT 
    *
FROM
    printer
WHERE
    color = 'y';
    
/*
2. Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).
*/

SELECT 
    p.model, pc.price AS price
FROM
    product p
        JOIN
    pc ON p.model = pc.model 
UNION SELECT 
    p.model, l.price AS price
FROM
    p
        JOIN
    laptop l ON p.model = l.model 
UNION SELECT 
    p.model, pr.price AS price
FROM
    p
        JOIN
    printer pr ON p.model = pr.model
WHERE
    p.maker = 'B';
    
/*
3.Найдите производителя, выпускающего ПК, но не ПК-блокноты.
*/
SELECT 
    maker
FROM
    products p
        JOIN
    pc ON p.model = pc.model;
    
/*
4. Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
*/
SELECT 
    p.maker
FROM
    product p
        JOIN
    pc ON pc.model = p.model
WHERE
    pc.speed >= 450;
    
/*
5 Найдите среднюю скорость ПК.
*/

SELECT 
    AVG(speed) AS average_speed
FROM
    pc;
    
/*
6 Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.

Вывести: maker, средний размер экрана.
*/

SELECT 
    p.maker, AVG(l.screen) AS average_screen_laptop
FROM
    product p
        JOIN
    laptop l ON p.model = l.model
GROUP BY maker;



