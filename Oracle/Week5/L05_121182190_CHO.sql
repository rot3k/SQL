-- ***********************
-- Name: Sungsoo Cho
-- Student ID: 121182190
-- Date: 11/13/2020
-- Purpose: Lab 5 DBS311
-- ***********************

SET SERVEROUTPUT ON;

--Question 1
--1.	Write a stored procedure that get an integer number and prints
--The number is even. If a number is divisible by 2.
--Otherwise, it prints The number is odd.

--Q1 SOLUTION
CREATE OR REPLACE procedure calculate_even (num IN NUMBER)
AS

BEGIN
  IF MOD(num,2) = 0
  THEN DBMS_OUTPUT.PUT_LINE('The number is even');
  ELSE
  DBMS_OUTPUT.PUT_LINE('The number is odd');
  END IF;
END calculate_even; 
  
--Execution statement
BEGIN
calculate_even(&INPUT);
END;

--Question 2
--2.	Create a stored procedure named find_employee. This procedure gets an employee number and prints the following employee information:
--First name 
--Last name 
--Email
--Phone 	
--Hire date 
--Job title

--The procedure gets a value as the employee ID of type NUMBER.
--See the following example for employee ID 107: 

--First name: Summer
--Last name: Payn
--Email: summer.payne@example.com
--Phone: 515.123.8181
--Hire date: 07-JUN-16
--Job title: Public Accountant

--The procedure displays a proper error message if any error occurs.

--Q2 SOLUTION
CREATE OR REPLACE procedure find_employee (id employees.employee_id%TYPE)
IS

firstName employees.first_name%TYPE ;
lastName employees.last_name%TYPE;
emaila employees.email%TYPE;
phoneNum employees.phone_number%TYPE;
hireDate employees.hire_date%TYPE;
jobId employees.job_id%TYPE;

BEGIN
  SELECT first_name, last_name, email, phone_number, hire_date, job_id 
  INTO firstName, lastName, emaila, phoneNum, hireDate, jobId
  FROM employees
  WHERE employee_id = id;
  
  DBMS_OUTPUT.PUT_LINE('First name: '||firstName);
  DBMS_OUTPUT.PUT_LINE('Last name: '||lastName);
  DBMS_OUTPUT.PUT_LINE('Email: '||emaila||'@example.com');
  DBMS_OUTPUT.PUT_LINE('Phone: '||phoneNum);
  DBMS_OUTPUT.PUT_LINE('Hire date: '||hireDate);
  DBMS_OUTPUT.PUT_LINE('Job title: '||jobId);
  
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Employee not found.');
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('There are too many employees.');
WHEN OTHERS
THEN
  DBMS_OUTPUT.PUT_LINE('Error!');
END find_employee;

--Execution statement
BEGIN
find_employee(107);
END;

--Question 3
--3.	Every year, the company increases the price of all products in one product type. 
--For example, the company wants to increase the selling price of products in type Tents by $5. 
--Write a procedure named update_price_tents to update the price of all products in a given type and the given amount to be added to the current selling price if the price is greater than 0. 
--The procedure shows the number of updated rows if the update is successful.
--The procedure gets two parameters:
--•	Prod_type IN VARCHAR2
--•	amount 	NUMBER(9,2)
--To define the type of variables that store values of a table’ column, you can also write:
--	variable_name table_name.column_name%type;
--The above statement defines a variable of the same type as the type of the table column.
--	Example: category_id 	products.category_id%type;
--Or you need to see the table definition to find the type of the prod_type update  column. Make sure the type of your variable is compatible with the value that is stored in your variable.
--To show the number of affected rows the update query, declare a variable named rows_updated of type NUMBER and use the SQL variable sql%rowcount to set your variable. 
--Then, print its value in your stored procedure. (Something like this is in the notes supplied to you)
--Rows_updated := sql%rowcount;
--SQL%ROWCOUNT stores the number of rows affected by an INSERT, UPDATE, or DELETE.
--NOTE: Do not forget ROLLBACK;

--Q3 SOLUTION
CREATE OR REPLACE procedure update_price_tents (Prod_type products.prod_type%TYPE, amount NUMBER)
IS

rows_updated NUMBER;
BEGIN
UPDATE products 
SET prod_sell = CASE
WHEN prod_sell > 0
THEN prod_sell + amount
ELSE prod_sell
END
WHERE UPPER(prod_type) = Prod_type;
rows_updated := sql%rowcount;
DBMS_OUTPUT.PUT_LINE('# of Product type ' ||prod_type|| ' a increased selling price of ' || amount || '$ is ' || rows_updated);

EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Product not found.');   
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error!');     
END;

END update_price_tents;

--Execution statement
BEGIN
    update_price_tents('Tents','5');
END;

ROLLBACK;

--Quetion 4
--4.	Every year, the company increases the price of products by 1 or 2% (Example of 2% 
-- prod_sell * 1.02) based on if the selling price (prod_sell) is less than the average price of all products. 
--Write a stored procedure named update_low_prices_123456789 where 123456789 is replace by your student number.
--This procedure does not have any parameters. You need to find the average sell price of all products and store it into a variable of the same data type. 
--If the average price is less than or equal to $1000, then update the products selling price by 2% if that products sell price is less than the calculated average. 
--If the average price is greater than $1000, then update products selling price by 1% if the price of the products selling price is less than the calculated average. 
--The query displays an error message if any error occurs. Otherwise, it displays the number of updated rows.
--An example of an output produced by your code might be the following or perhaps nicer
--*** OUTPUT update_low_prices_123456789  STARTED ***
--Number of updates:  27

----ENDED --------
--NOTE: Do not forget ROLLBACK;

-- Q4 SOLUTION
CREATE OR REPLACE procedure update_low_prices_121182190 
AS

avgPrice products.prod_sell%TYPE;
rows_updated NUMBER;

BEGIN
SELECT avg(prod_sell) 
INTO avgPrice
FROM products;

UPDATE products
SET prod_sell = CASE 
WHEN (avgPrice < 1000 OR avgPrice = 1000) 
THEN prod_sell * 1.02 
WHEN (avgPrice > 1000)
THEN prod_sell * 1.01 
ELSE prod_sell
END
WHERE prod_sell < avgPrice;

rows_updated := sql%rowcount;

DBMS_OUTPUT.PUT_LINE('*** OUTPUT update_low_prices_121182190 STARTED ***');
DBMS_OUTPUT.PUT_LINE('Number of updates: '|| rows_updated);

EXCEPTION

WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Product not found.');   
WHEN OTHERS
THEN
  DBMS_OUTPUT.PUT_LINE('Error!');
END update_low_prices_121182190;

-- Execution Statement
BEGIN
update_low_prices_121182190();
END;

ROLLBACK;

--Question 5
--5.	The company needs a report that shows three categories of products based their prices. The company needs to know if the product price is cheap, fair, or expensive. Let us assume that
--	- If the list price is less than the (average sell price – minimum sell price) divided by 2
--		The product’s price is LOW.
--	- If the list price is greater than the maximum less the average divided by 2
--	The product’ price is HIGH.
--	- If the list price is between  o	(average price – minimum price) / 2  AND   (maximum price – average price) / 2 INCLUSIVE
--	The product’s price is fair.
-- Write a procedure named price_report_123456789  to show the number of products in each price category:
-- The following is a sample output of the procedure if no error occurs:
-- Low:  10
-- Fair: 50
-- High: 18  
-- The values in the above examples are just random values and may not match the real numbers in your result.
-- The procedure has no parameter. First, you need to find the average, minimum, and maximum prices (list_price) in your database and store them into variables avg_price, min_price, and max_price.
-- You need three more variables to store the number of products in each price category:
-- low_count
-- fair_count
-- high_count
-- Make sure you choose a proper type for each variable. You may need to define more variables based on your solution.
-- NOTE: Do not forget ROLLBACK;

--Q5 SOLUTION
CREATE OR REPLACE procedure price_report_121182190 
AS
avg_price products.prod_sell%TYPE;
min_price products.prod_sell%TYPE;
max_price products.prod_sell%TYPE;
low_count NUMBER;
fair_count NUMBER;
high_count NUMBER;

BEGIN

SELECT AVG(prod_sell), MAX(prod_sell), MIN(prod_sell)
INTO avg_price, max_price, min_price
FROM products;

SELECT COUNT(prod_sell) INTO low_count
FROM products
WHERE prod_sell < (avg_price - min_price) / 2;

SELECT COUNT(prod_sell) INTO high_count
FROM products
WHERE prod_sell > (max_price - avg_price) / 2;

SELECT COUNT(prod_sell) INTO fair_count
FROM products
WHERE prod_sell BETWEEN (avg_price - min_price) / 2 AND (MAX_price - avg_price) / 2; 

DBMS_OUTPUT.PUT_LINE('Low: '|| low_count);
DBMS_OUTPUT.PUT_LINE('Fair: '|| fair_count);
DBMS_OUTPUT.PUT_LINE('High: '|| high_count);

EXCEPTION
WHEN OTHERS
THEN
  DBMS_OUTPUT.PUT_LINE('Error!');
END;

--Execution Statement
BEGIN
price_report_121182190();
END;                  

ROLLBACK;