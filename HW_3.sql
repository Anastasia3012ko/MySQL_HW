 /*
 1. Выведите Ваш возраст на текущий день в секундах
*/
SELECT 
    CONCAT(TIMESTAMPDIFF(SECOND,
                '1984-12-30',
                NOW()),
            ' Seconds') AS my_agE_IN_SEconds;

/*
2. Выведите КаКАя дата будет через 51 день
*/
SELECT DATE_ADD(CURDATE(), INTERVAL 51 DAY) AS date_in_51_day;
            
/*
3. ОТФОРМАТИРУЙТЕ пРЕДЫДУЩЕй ЗаПРОС - выведите день недели для этой даты Используйте документацию My SQL
*/
SELECT DAYNAME(DATE_ADD(CURDATE(), INTERVAL 51 DAY)) AS day_of_week_in_51_day;

/*
4. Подключитесь к базе данных northwind Выведите столбец с исходной даТОЙ СОзДАНИЯ ТРАНЗАКЦИИ TRANSACTIOn_CREATED_DAtE ИЗ тАБлицы inventory_transactions, а также столбец полученный прибавлением 3 часов к этой дате
*/
USE northwind;

SELECT 
    transaction_created_date,
    DATE_ADD(transaction_created_date,
        INTERVAL 3 HOUR)
FROM
    inventory_transactions;

/*
5. Выведите столбец с текстом  'Клиент с id <customer_id> сделал заказ <order_date>' из таблицы orders

Запрос написать двумя СПОсобами - с исПОЛЬЗОванием неявных преобразований А такжЕ С УКАЗАнием изменения типа даннЫх для стоЛБЦА CUStOmER_ID

ВНИмание В MySQL функция CAST не принимает VARCHAR в качестве параметра для длины. Вместо этого, нужно использовать CHAR для указания длины.
*/

-- 1
SELECT 
    CONCAT('Клиент с id: ', customer_id, '   сделал заказ: ',  order_date) AS client_order 
FROM
    orders;
    
-- 2
SELECT 
    CONCAT('Клиент с id: ', CAST(customer_id AS CHAR), '   сделал заказ: ',  DATE_FORMAT(order_date, '%Y-%m-%d')) AS client_order 
FROM
    orders;
