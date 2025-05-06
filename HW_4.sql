/*
Подключитесь к своей базе данных созданной на уроке.
*/ 
USE 131224_Kolobova;


/* 
Создайте таблицу, КОторая отражает погоду в Вашем городе за последние 5 дней и включает следующее столбцы. 
● Id - первичный ключ, заполняется автоматически 
● Дата - не может быть пропуском 
● Дневная температура - целое число, принимает значения от 30 до 30  
● Ночная температура - целое число, принимает значения от 30 до 30 
● Скорость ветра - подумайте какой тип данных и ограничения необходимы для этого столбца. 
*/
CREATE TABLE weather_my_city (
    id INT AUTO_INCREMENT PRIMARY KEY,
    today DATE NOT NULL,
    daytime_temperature INT CHECK (daytime_temperature BETWEEN -30 AND 30),
    nighttime_tempereture INT CHECK (nighttime_tempereture BETWEEN -30 AND 30),
    wind_speed DECIMAL(5 , 2 ) CHECK (wind_speed >= 0 AND wind_speed <= 200)
);

RENAME table weather_my_city to  weather_in_my_city;

/*
Заполните таблицу 5 строкаМИ - ЗА ПОСЛЕДНИЕ 5 ДНЕЙ.
*/
INSERT INTO weather_in_my_city (today, daytime_temperature, nighttime_tempereture, wind_speed)
VALUES
(CURDATE() - INTERVAL 4 DAY, 15, 5, 6.7),
(CURDATE() - INTERVAL 3 DAY, 13, 4, 8.5),
(CURDATE() - INTERVAL 2 DAY, 10, 5, 14.0),
(CURDATE() - INTERVAL 1 DAY, 9, 4, 12.1),
(CURDATE(), 8, 3, 13.2);

SELECT 
    *
FROM
    weather_in_my_city;

/*
Увеличьте значения ночноЙ темпераТУРы НА ГРАдУС Если скоростЬ ВЕтРА нЕ ПРЕВЫШАлА 10 м/с.
*/
UPDATE weather_in_my_city 
SET 
    nighttime_tempereture = nighttime_tempereture + 1
WHERE
    view_table_weather <= 10;
    

/*
НА ОСНОВЕ ПОЛУЧЕННОЙ ТаБлИЦЫ сОЗДаЙТЕ ПРЕДСТАВЛЕНИЕ В СвОЕЙ БАЗЕ ДаННЫХ - ВкЛЮчИТЕ ВСе СТРОКИ ТАбЛиЦЫ И ДОПоЛнИТЕЛьНО РАССЧИТАНнЫЕ СТОЛБЦЫ. 
● СРеДНЯЯ сУТОЧНАЯ ТеМпЕрАтУРА - Среднее арифМЕтИчЕСКое между ночНОй И ДнЕвной температурами  
● Столбец на основе скорости ветра - если скорость ветра не превышала 2 м/с то значение ‘штильʼ, от 2 включительно до 10 - ‘умереННЫЙ Ветерʼ, в остальных слУЧАях - ‘сильный ветерʼ. 
*/
CREATE VIEW view_table_weather AS 
SELECT 
    *, 
    (daytime_temperature + nighttime_tempereture)/ 2 AS average_daily_temperature,
    CASE 
        WHEN wind_speed < 2 THEN 'штиль'
        WHEN wind_speed BETWEEN 2 AND 10 THEN 'умеренный ветер'
        ELSE 'сильный ветер'
    END AS wind_indicators
FROM 
    weather_in_my_city;
    
 SELECT 
    *
FROM
    view_table_weather;

