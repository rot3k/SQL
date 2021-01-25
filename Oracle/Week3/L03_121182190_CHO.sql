--Q1
-- Write a SQL query to display the last name and hire date of all employees who were hired before the employee with ID 107 got hired. 
-- Sort the result by the hire date with the employee that was there the longest going first on list.

SELECT last_name, hire_date
FROM employees
where employee_id < ( SELECT employee_id
                      FROM employees
                      where employee_id = '107')
ORDER BY hire_date;                      

--Q2
-- Write a SQL query to display last name and salary those employees with the lowest salry Sort the result by name.
SELECT last_name, salary
FROM employees
WHERE salary = ( SELECT min(salary)
                 FROM employees)
                 
ORDER BY last_name;

--Q3
-- Write a SQL query to display the product number, product name, product type and sell price of the highest paid product(s) in each product type.  
-- Sort by product type.

SELECT prod_no, prod_name, prod_type, prod_sell 
FROM products
WHERE (prod_type, prod_sell) in (SELECT prod_type, max(prod_sell)
                               FROM products
                               GROUP BY prod_type)
                               
ORDER BY prod_type;

--Q4
-- Write a SQL query to display the product line,  and product sell price of the most expensive (highest sell price) product(s). There may be more than 1 result.
SELECT prod_line, prod_sell
FROM products
WHERE prod_sell in (SELECT max(prod_sell)
                    FROM products
                    GROUP BY prod_line);

--Q5
-- Write a SQL query to display product name and list price Prod_sell) for products in product type 
-- which have the list price less than the lowest list price in ANY product_type  
-- Sort the output by top list prices first and then by the product name.
SELECT prod_name, prod_sell
FROM products 
WHERE prod_sell < ANY 
                  (SELECT min(prod_sell)
                   FROM products
                   GROUP BY prod_type)
ORDER BY prod_sell;

-- Q6
-- Display product number, product name, and product type for products that are in the same product type as the product with the   lowest price
SELECT prod_no, prod_name, prod_type, prod_sell
FROM products
WHERE prod_type in (SELECT prod_type
                   FROM products
                   WHERE prod_sell = (SELECT min(prod_sell)
                                      FROM products));
--Q7
-- Write a query to display the tomorrow’s date in the following format:
-- September 28th of year 2006  <-- this is the format for the date you display.
-- Your result will depend on the day when you create this query.

SELECT TO_CHAR(SYSDATE + 1, 'fmMonth fmDdth "of year" YYYY')
FROM dual;

--Q8
-- Create a query that displays the (a) city names, (b) country codes or ID and (c) state/province names, 
-- but only for those cities that start with a lower case S and have at least 8 characters in their name. 
-- If city does not have a state name assigned, then put State Missing as your output on that row.

SELECT city, country_id, NVL(state_province, ' ') 
FROM locations
WHERE city like 's%'
AND length(city) > 7;






                                      


               

               
                   


                 