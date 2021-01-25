-- Q1
-- The user is looking for the country code and country name. Prompt for a country name. The user is only going to type in part of the country name or all of it. 
-- Assume you will test it with the letter g in lowercase
-- When you entered g   how many rows were produced

SELECT country_id, country_name
FROM countries
WHERE upper(country_name) like upper('&country_name%');
-- A: 1 rows

-- Q2
-- The answer requires the number of rows only ... not the code
-- Display cities in the locations table that is a city where no customers are in them. (use set operators to answer this question)
-- Make it ordered by city name from A to Z

SELECT city
FROM locations 
MINUS
SELECT city
FROM customers;
ORDER BY city;

select distinct city

from customers
--WHERE city = '&city'

order by 1 

--A: 16 rows

-- Q3
-- Again using SET
-- Display the product type, and the number of products  In your result, 
-- display first display Sleeping Bags, followed by Tents, followed by Sunblock

SELECT prod_type, count(prod_type)
FROM products
GROUP BY prod_type
HAVING prod_type = 'Sleeping Bags'
UNION ALL
SELECT prod_type, count(prod_type)
FROM products
GROUP BY prod_type
HAVING prod_type = 'Tents'
UNION ALL
SELECT prod_type, count(prod_type)
FROM products
GROUP BY prod_type 
HAVING prod_type = 'Sunblock' ;

--Q4
--Show the result of the UNION of employee_id and job_id for tables EMPLOYEES and JOB_HISTORY
SELECT employee_id, job_id
FROM employees
UNION
SELECT employee_id, job_id
FROM job_history;




