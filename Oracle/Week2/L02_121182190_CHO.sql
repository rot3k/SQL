
-- Q1.
-- For each job title display the job title and the number of employees with that same title. 
-- Change the job_title column to your last name

SELECT job_id Cho, count(employee_id)
FROM employees
GROUP BY job_id;

-- Q2.
-- Display the Highest, Lowest and Average salary.  
-- Add a column that shows the difference between the highest and lowest salaries. 
-- Make sure the output looks meaningful to the user. EXAMPLE: Money should not be to 7 decimal places 

SELECT max(salary), min(salary), round(avg(salary)),  max(salary) - min(salary)
FROM employees;

-- Q3.
-- Display the customer name and the total amount the customer has ordered. But only show those customers where the total exceeds 50,000

SELECT c.cname, sum(ol.qty * ol.price)
FROM customers c
JOIN orders o
ON c.cust_no = o.cust_no
JOIN orderlines ol
ON o.order_no = ol.order_no
GROUP BY c.cname
HAVING sum(ol.qty * ol.price) > 50000;

-- Q4.
-- Display the product type name and the total dollar sales for that product type based on sales_2016 ans sales for 2015. Order by product type

SELECT prod_type, (sum(sales_2016) + sum(sales_2015))
FROM products
GROUP BY prod_type
ORDER BY prod_type;

-- Q5.

-- For each customer display the name and the number of orders issued by the customer. However, only show those customers beginning with an A. or a G   
-- If the customer does not have any orders, the result will display 0.
-- Put in customer name order

SELECT c.cname, count(o.order_no) 
FROM customers c
LEFT JOIN orders o
ON c.cust_no = o.cust_no
WHERE (substr(c.cname, 1,1) = 'A' or substr(c.cname, 1,1) = 'G')
GROUP BY c.cname
ORDER BY c.cname;

-- Q6.
-- Write a SQL query to show (a) cust_no, (b) cname (c) the total dollar sales (price * qty) and the total number of orders
-- Put the output in order by -- the number of orders
-- Output will look similar to this row
-- 1040 Vacation Central 2                       7948               5

SELECT c.cust_no, c.cname, sum(ol.qty * ol.price), count(ol.order_no)
FROM customers c
JOIN orders o
ON c.cust_no = o.cust_no
JOIN orderlines ol
ON o.order_no = ol.order_no
GROUP BY c.cname, c.cust_no
ORDER BY  count(ol.order_no);

-- Q7.
-- We are going to make the previous questions a little harder.
-- The user wanted it for customer names starting with A. However, they wanted ALL customer s even if they have not ordered anything. Put output in order of column 4

SELECT c.cust_no, c.cname, sum(ol.qty * ol.price), count(ol.order_no)
FROM customers c
LEFT JOIN orders o
ON c.cust_no = o.cust_no
LEFT JOIN orderlines ol
ON o.order_no = ol.order_no
GROUP BY c.cname, c.cust_no
HAVING c.cname like 'A%'
ORDER BY 4;


