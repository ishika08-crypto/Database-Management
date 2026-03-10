CREATE TABLE employee
(
	emp_id INT PRIMARY KEY,
    name VARCHAR(20),
    salary INT
);

INSERT INTO employee VALUES
(1,"Amit",30000),
(2,"Neema",40000),
(3,"Ravi",35000);

-- Create procedure to show all data.
DELIMITER $$
CREATE PROCEDURE show_employees()
BEGIN
    SELECT * FROM employee;
END$$
DELIMITER ;

CALL show_employees;

-- create procedure to add employee details.
DELIMITER $$
CREATE PROCEDURE add_employee
	(IN p_emp_id INT,
    IN p_name VARCHAR (20),
    IN p_salary INT)
BEGIN
	INSERT INTO employee (emp_id, name, salary)
    VALUES(p_emp_id, p_name, p_salary);
END$$
DELIMITER ;

CALL add_employee(4,"Rahul", 50000);
SELECT * FROM employee;

-- Create procedure to delete employee details by using emp_id

DELIMITER $$
CREATE PROCEDURE delete_detail(IN p_emp_id INT)
BEGIN
	DELETE FROM employee WHERE emp_id=p_emp_id;
END$$
DELIMITER ;

CALL delete_detail(1);
SELECT * FROM employee;

