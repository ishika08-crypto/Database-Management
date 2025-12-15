CREATE TABLE employee2
	(
		emp_id INT PRIMARY KEY AUTO_INCREMENT,
        emp_name VARCHAR(50), 
        department VARCHAR(50),
        salary INT,
        manager_id INT
	);
INSERT INTO employee2 (emp_name,department,salary,manager_id)
VALUES
("Arjun","HR",40000,null),
("Neha","IT",65000,5),
("Rohan","IT",55000,5),
("Meera","Finance",70000,null),
("Suresh","IT",90000,4),
("Alia","HR",45000,1),
("Karan","Finance",75000,4),
("Rahul","Marketing",30000,null),
("priya","marketing",35000,8),
("Varun","IT",50000,5);

SELECT * FROM employee2;

-- 1. List employees earning more than the average salary.
SELECT emp_name, salary, (SELECT AVG(salary) FROM employee2) as avg_salary
FROM employee2
WHERE salary>
(SELECT AVG(salary) FROM employee2);

-- 2. Find employees who earn the maximum salary.
SELECT emp_name, salary
FROM employee2
WHERE salary=
(SELECT MAX(salary) FROM employee2);

-- 3. Find employees working in the same department as ‘Neha’.
SELECT emp_name, salary, department
FROM employee2
WHERE department=
(SELECT department FROM employee2 WHERE emp_name="Neha");

-- 4 List employees whose salary is higher than Suresh’s salary.
SELECT emp_name, salary, department
FROM employee2
WHERE salary>
(SELECT salary FROM employee2 WHERE emp_name="Suresh");

-- 5 Show departments where the minimum salary is less than 40,000.
SELECT department, MIN(salary) AS min_salary
FROM employee2
GROUP BY department
HAVING MIN(salary) < 40000;


-- 6 Find employees who do not have a manager.
SELECT emp_name,department,manager_id
FROM employee2
WHERE emp_id IN (
SELECT emp_id from employee2 WHERE manager_id IS NULL);

-- 7 Find employees who report to the same manager as Rohan.
SELECT emp_name,department,manager_id
FROM employee2
WHERE manager_id IN (
SELECT manager_id from employee2 WHERE emp_name="Rohan");

-- 8 List employees in IT with salaries above the IT average.
SELECT emp_name,department,salary
FROM employee2
WHERE salary > (
SELECT AVG(salary) from employee2 WHERE department="IT")
AND department="IT";

-- 9 Show employees whose salary is in the bottom 3.
SELECT emp_name,department,salary
FROM employee2
WHERE salary IN (SELECT salary FROM(
SELECT salary from employee2 ORDER BY salary LIMIT 3) as s);

-- 10 Show employees whose salary is within the top 3.
SELECT emp_name,department,salary
FROM employee2
WHERE salary IN (SELECT salary FROM(
SELECT salary from employee2 ORDER BY salary DESC LIMIT 3) as s);

-- 11 Find employees earning more than the HR department 's average salary.
SELECT emp_name, department,salary,(SELECT AVG(salary) FROM employee2 WHERE department="HR") as HR_Avg
FROM employee2
WHERE salary>
(SELECT AVG(salary) FROM employee2 WHERE department="HR");

-- 12 List employees having the same salary as Priya.
SELECT emp_name, department,salary,(SELECT salary FROM employee2 WHERE emp_name="Priya") as priya_salary
FROM employee2
WHERE salary IN
(SELECT salary FROM employee2 WHERE emp_name="Priya");

-- 13 Count employees who earn below overall average.
SELECT count(*) as emp_count_below, (SELECT AVG(Salary) FROM employee2) as overall_avg_salary
FROM employee2
WHERE salary<(SELECT AVG(Salary) FROM employee2);

-- 14 Show employees whose manager earns more than 70,000.
SELECT emp_name, salary, manager_id
FROM employee2 e
WHERE e.manager_id IN (
    SELECT emp_id
    FROM employee2
    WHERE salary > 70000);

-- 15 Display employees in departments where more than 2 employees work.
SELECT emp_name, department
FROM employee2
WHERE department IN(
SELECT department FROM employee2 GROUP BY department HAVING COUNT(*)>2);

-- 16 Show departments where the average salary is above company average.
SELECT department, AVG(salary) AS avg_salary
FROM employee2
GROUP BY department
HAVING AVG(salary) > (SELECT AVG(salary) FROM employee2);

-- 17 Find the 2nd highest salary.
SELECT emp_name,salary
FROM employee2
WHERE salary=(
	SELECT MAX(salary) FROM employee2
	WHERE salary<(
		SELECT MAX(salary) FROM employee2)); 

-- 18 Employees with salaries greater than the average salary of their manager’s team.
SELECT emp_name, salary, manager_id
FROM employee2 e
WHERE salary > (
    SELECT AVG(salary)
    FROM employee2
    WHERE manager_id = e.manager_id);
    
-- 19.	Show employees who work in a department where Suresh works.
SELECT emp_name, department
FROM employee2
WHERE department=(
	SELECT department FROM employee2 WHERE emp_name="Suresh");
    
-- 20 List employees whose manager earns the maximum salary.
SELECT emp_name, salary,manager_id
FROM employee2 WHERE manager_id IN(
SELECT emp_id FROM employee2 WHERE salary=
(SELECT MAX(salary) FROM employee2));

-- 21. Show employees whose salaries appear more than once.
SELECT emp_name, department,salary
FROM employee2
WHERE salary IN(
	SELECT salary FROM employee2 GROUP BY salary HAVING count(*)>1);
    
-- 22.List employees earning less than the minimum IT salary.
SELECT emp_name, salary, department
FROM employee2
WHERE salary < (
    SELECT MIN(salary)
    FROM employee2
    WHERE department = 'IT');
    
-- 23 Show employees with salaries higher than the Finance average salary.
SELECT emp_name, salary, department
FROM employee2
WHERE salary > (
    SELECT AVG(salary)
    FROM employee2
    WHERE department= 'Finance');
    
-- 24.	Find employees earning exactly the 3rd highest salary.
SELECT emp_name, salary
FROM employee2
WHERE salary = (
    SELECT salary
    FROM employee2
    ORDER BY salary DESC
    LIMIT 1 OFFSET 2);

-- 25.	List employees having salary in the same salary group as Meera’s department.
SELECT emp_name, department,salary
FROM employee2 WHERE department IN(
SELECT department FROM employee2 WHERE salary IN(
SELECT salary FROM employee2 WHERE department IN(
SELECT department FROM employee2 WHERE emp_name="Meera")));
