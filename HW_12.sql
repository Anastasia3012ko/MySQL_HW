DROP PROCEDURE increase_salary;

/*
1 Вывести id департамента , в котором работает сотрудник, в зависимости от Id сотрудника 
*/
DELIMITER $$

CREATE PROCEDURE department_id (IN employee_id INT)
BEGIN 
	SELECT department_id FROM employees WHERE id = employee_id;
END $$

DELIMITER ;

CALL department_id(5);

/*2 
Создайте хранимую процедуру get_employee_age, которая принимает id сотрудника (IN-параметр) и возвращает его возраст через OUT-параметр.
*/

DELIMITER $$

CREATE PROCEDURE get_employee_age (
	IN employee_id INT, 
    OUT employee_age INT
    )
BEGIN
	SELECT age INTO employee_age FROM employees WHERE id = employee_id ;
END $$

DELIMITER ;

CALL get_employee_age(3, @age);
SELECT @age;

/* 
3 Создайте хранимую процедуру increase_salary, которая принимает зарплату сотрудника (INOUT-параметр) и уменьшает ее на 10%.
*/

DELIMITER $$

CREATE PROCEDURE increase_salary (INOUT employee_salary DECIMAL(10, 2))
BEGIN
	SET employee_salary = employee_salary * 0.9;
END $$

DELIMITER ;

SET @salary = 30000;
CALL increase_salary (@salary);
SELECT  @salary;
