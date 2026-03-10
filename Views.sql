CREATE DATABASE view_query;
CREATE TABLE employee
	(
		emp_id INT PRIMARY KEY,
        name VARCHAR(50),
        department VARCHAR(10),
        salary INT
	);
    
INSERT INTO employee (emp_id, name, department, salary)
VALUES
(1, "ALice", "HR", 50000),
(2, "Bob", "IT", 70000),
(3, "Charlie", "IT", 60000),
(4, "David", "HR", 55000),
(5, "Eve", "Finance", 65000);

SELECT * FROM employee;

CREATE OR REPLACE VIEW emp_view AS
SELECT name, salary FROM employee
WHERE department="HR";

SELECT * FROM emp_view;

CREATE VIEW dept_salary AS
SELECT department, SUM(salary) as salary
FROM employee
GROUP BY department;

SELECT * FROM dept_salary;

DROP VIEW IF EXISTS emp_view;