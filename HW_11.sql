/*Создать кастомные функции
1. Функция для расчета площади круга*/
DROP function area_of_the_circle;
DELIMITER //

CREATE FUNCTION area_of_the_circle (r DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	RETURN PI() * r * r;
END //

DELIMITER ;

SELECT area_of_the_circle (3);

/*2. Функция для расчета гипотенузы треугольника*/

DELIMITER //

CREATE FUNCTION hypotenuse_triangle (a DECIMAL(10,2), b DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	RETURN SQRT(a*a + b*b);
END //

DELIMITER ;

SELECT hypotenuse_triangle(3, 8);

