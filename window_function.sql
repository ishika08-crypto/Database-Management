CREATE DATABASE window_functions;
USE window_functions;
CREATE TABLE category
	(
		new_id INT,
		new_cat VARCHAR(50)
	);

INSERT INTO category (new_id,new_cat)
VALUES
(100,"Agni"),
(200,"Agni"),
(500, "Dharti"),
(700, "Dharti"),
(200,"Vayu"),
(300, "Vayu"),
(500, "Vayu");

SELECT * FROM category;
TRUNCATE category;

SELECT *,
SUM(new_id) OVER(PARTITION BY new_cat) AS "Total" FROM category;
SELECT *,
MAX(new_id) OVER(PARTITION BY new_cat) AS "Total" FROM category;
SELECT *,
MIN(new_id) OVER(PARTITION BY new_cat) AS "Total" FROM category;
SELECT *,
ROW_NUMBER() OVER(PARTITION BY new_cat) AS "Total" FROM category;
SELECT *,
    SUM(new_id) OVER(PARTITION BY new_cat) AS "Total",
	MAX(new_id) OVER(PARTITION BY new_cat) AS "Maximum",
	MIN(new_id) OVER(PARTITION BY new_cat) AS "Minimum",
	COUNT(new_cat) OVER(PARTITION BY new_cat) AS "count",
	AVG(new_id) OVER(PARTITION BY new_cat) AS "Average"
FROM category;
 
SELECT *,
	DENSE_RANK() OVER(ORDER BY new_id) AS "Dense", 
	RANK() OVER(ORDER BY new_id) AS "Rank",
    ROW_NUMBER() OVER(ORDER BY new_id) AS "Row_No",
    ROW_NUMBER() OVER(PARTITION BY new_cat) AS "Row_No_cat",
    PERCENT_RANK() OVER(PARTITION BY new_cat ORDER BY new_id) AS "Percent_Rank"
FROM category;
 
 select new_id,
first_value(new_id) over(order by new_cat) as "FIRST VALUE",
last_value(new_id) over(order by new_cat) as "LAST VALUE",
lead(new_id) over (order by new_id)as "LEAD",
lag(new_id) over (order by new_cat) as "LAG"
FROM category;

select new_id,new_cat,
  SUM(new_id) OVER(order BY new_cat rows between unbounded preceding and unbounded following) AS "Total",
  avg(new_id) OVER(order BY new_cat rows between unbounded preceding and unbounded following) AS "AVERAGE",
  COUNT(new_id) OVER(order BY new_cat rows between unbounded preceding and unbounded following) AS "COUNT",
  MIN(new_id) OVER(order BY new_cat rows between unbounded preceding and unbounded following) AS "MINIMUM",
  MAX(new_id) OVER(order BY new_cat rows between unbounded preceding and unbounded following) AS "MAXIMUM"
FROM category;


CREATE TABLE Sales (
    SaleID INT,
    SaleDate DATE,
    CustomerID INT,
    ProductID INT,
    Amount DECIMAL(10, 2)
);
 
INSERT INTO Sales (SaleID, SaleDate, CustomerID, ProductID, Amount) VALUES
(1, '2024-01-01', 101, 1001, 150.00),
(2, '2024-01-02', 102, 1002, 200.00),
(3, '2024-01-03', 101, 1001, 100.00),
(4, '2024-01-04', 103, 1003, 300.00),
(5, '2024-01-05', 102, 1002, 250.00),
(6, '2024-01-06', 101, 1001, 175.00),
(7, '2024-01-07', 104, 1004, 400.00),
(8, '2024-01-08', 105, 1005, 350.00),
(9, '2024-01-09', 102, 1002, 225.00),
(10, '2024-01-10', 101, 1001, 125.00);
 
 
-- calculate the running total of sales amount.

 select amount,
 sum(amount) OVER (ORDER BY SaleDate) AS "running_total"
FROM Sales;


-- show the running total for amount based on customer id.

 select amount,
 sum(amount) OVER (partition by CustomerId ORDER BY SaleDate) AS "running_total"
FROM Sales;


-- calculate the average sales amount over the last 3 sales.

select amount,
avg(amount) over (order by SaleDate rows between 2 preceding and current row) as LAST3AVGSALES
from Sales;


-- rank the sales by amount for each customer.

select *,
rank() over (partition by CustomerId order by amount desc ) as "RANK"
from sales;


-- 