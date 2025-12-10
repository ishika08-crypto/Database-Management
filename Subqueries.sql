create database laptop;
use laptop;

CREATE TABLE Subqueries
(emp_id INT Primary key,
emp_name varchar(20),
dept_id int,
salary int,
age int
);

drop table Subqueries;

insert into Subqueries (emp_id,emp_name,dept_id,salary,age)
value (1,"John",101,50000,28),
(2,"Emma",101,65000,32),
(3,"Raj",102,45000,26),
(4,"Meera",103,70000,38),
(5,"Ravi",102,48000,30),
(6,"Naina",103,52000,29),
(7,"Alex",101,50000,31);

select * from subqueries;

create table Department
(dept_id int PRIMARY KEY,
dept_name varchar(20)
);

DROP TABLE Department;

insert into Department (dept_id,dept_name)
value (101,"Sales"),
(102,"Marketing"),
(103,"Finance");

-- 1. Find employees whose salary is greater than the average.

select emp_name from subqueries
where salary > (select avg(salary) from subqueries);

-- 2. find employees who work in the Sales department.

select emp_name from subqueries
where dept_id = (select dept_id from department where dept_name="Sales");

-- 3. Find the highest paid employee.

select emp_name,salary
from subqueries
where salary = (select max(salary) from subqueries);

-- 4. Find employees older than the youngest employee.

select emp_name,age
from subqueries
where age > (select (min(age) ) from subqueries);

-- 5. list employees who earn more than john.

select emp_name,salary
from subqueries
where salary > (select (salary) from subqueries where emp_name="John");

-- 6. Find employees in departments where the average salary is above 50,000.

select emp_name
from subqueries
where dept_id in
(select dept_id
from subqueries
group by dept_id
having avg(salary)>50000);

select emp_name
from subqueries
where dept_id in(101,103);

-- 7. Find employees whose salary is second highest.

select emp_name,salary
from subqueries
where salary < 
(select max(salary) from subqueries)
order by salary desc
limit 1;

-- 8. Find employees in the same department as Emma.

select dept_id,emp_name
from subqueries
where dept_id = (select (dept_id) from subqueries where emp_name="Emma");


-- 9. list departments that have more than 2 employees.

select dept_id
from subqueries
group by dept_id
having count(dept_id)>2;


select dept_id,dept_name
from department
where dept_id in (select dept_id
from subqueries
group by dept_id
having count(dept_id)>2);

-- 10. Find employees who earn more than every employee in marketing.

select emp_name,salary
from subqueries
where salary >(
select max(salary)
from subqueries
where dept_id=(
select dept_id
from department
where dept_name="Marketing"));

-- 11. Find employees who earn minimum salary in their department.

select s.emp_name,s.salary,s.dept_id
from subqueries as s
where s.salary=
(select min(salary)
from subqueries
where dept_id = s.dept_id);


-- max

select s.emp_name,s.salary,s.dept_id
from subqueries as s
where s.salary=
(select max(salary)
from subqueries
where dept_id = s.dept_id);


-- 12. Find employees whose salary is above the depatment average.

select s.emp_name,s.salary,s.dept_id
from subqueries as s
where s.salary>
(select avg(salary)
from subqueries
where dept_id = s.dept_id);


-- 13. List employees who are younger than Emma.

select emp_name,age
from subqueries
where age >
(select age
from subqueries
where emp_name = "Emma");


-- 14. FIND EMPLOYEE WHO DO NOT WORK IN ANY DEPARTMENT PRESENT IN THE DEPARTMENT TABLE.

select s.emp_name,d.dept_name
from subqueries s
left join department d on s.dept_id=d.dept_id;

select s.emp_name,d.dept_name
from department d
right join subqueries s on d.dept_id=s.dept_id;

select emp_name,dept_id
from subqueries
where dept_id not in 
(select dept_id 
from department);


-- 15. FIND THE TOP 2 HIGHEST SALARIES USING A SUBQUERY.

select emp_name,salary
from subqueries
where emp_id in (
select emp_id
from subqueries
order by salary desc 
limit 2);

select emp_name, salary
from subqueries
order by salary desc 
limit 2;


select emp_name,salary
from subqueries
where emp_id in (select emp_id from( 
select emp_id
from subqueries
order by salary desc 
limit 2) as t);


-- find the total salary in each department.

select dept_id,sum(salary)
from subqueries
group by dept_id;


-- find the average age of employee in each department.

select dept_id,avg(age)
from subqueries
group by dept_id;


-- find the number of employees in each department.

select dept_id,count(emp_name)
from subqueries
group by dept_id;


-- find department where the average salary is greater than 50000.

select dept_id,avg(salary)
from subqueries
group by dept_id
having avg(salary)>50000;


-- find department more than 2 employees.

select dept_id,count(emp_name)
from subqueries
group by dept_id
having count(emp_name)>2;


-- find the average salary of employees group by age.

select age,emp_name,avg(salary)
from subqueries
group by age,emp_name;


-- find the number of employees between the age group of 20 to 30.

select age,count(emp_name)
from subqueries
group by age
having age between 20 and 30;


select case when age between 20 and 30 then "20-30"
when age between 31 and 40 then "31-40"
else "41-50" end as age_group, 
count(emp_name)
from subqueries
group by age_group; 


-- (<50000) low if (50000 to 60000) medium (>60000) high.

select case when salary <50000 then "low"
when salary between 50000 and 60000 then "medium"
else "high" end as salary,
emp_name,salary
from subqueries;


-- find employees who earn above their department average salary add a column yes or no.

select s.emp_name,s.salary,s.dept_id,
case when s.salary > (
select avg(salary)
from subqueries
where dept_id = s.dept_id)
then "yes"
else "no"
end as above_avg
from subqueries s;


-- 16. count employee in the department with the highest average salary.

select dept_id,count(emp_name)
from subqueries s
where salary >
(select avg(salary)
from subqueries 
where dept_id=s.dept_id)
group by dept_id;


-- 17. display employee whose salary is below department average.

select dept_id,count(emp_name)
from subqueries s
where salary <
(select avg(salary)
from subqueries
where dept_id=s.dept_id)
group by dept_id;


-- 18. Find employees whose age is greater than the average age.

select emp_name,(select avg(age) from subqueries)as average_age,age
from subqueries 
where age>
(select avg(age)
from subqueries);


-- 19. Find employees who belong to departments starting with "M".

select dept_id,emp_name
from subqueries 
where dept_id in 
(select dept_id from department where dept_name like "M%");


-- 20. Find employees who do not have the same salary as anyone else.

select emp_name,salary 
from subqueries
where salary in 
(select salary,count(salary)
from subqueries
group by salary
having count(salary) =1);



