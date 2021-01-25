

-- Q1.
-- Display the (1) employee_id,(2) First name Last name (as one name with a space between) and call the column Employee Name, (3) hire_date
-- Only show employees with hire dates in July 2016 to December of 2016.  You cannot use >= or similar signs
-- Sort the output by top last hire_date first (December) and then by last name.

SELECT employee_id, concat(concat(first_name,' '),last_name) "Employee Name", hire_date
FROM employees
WHERE (hire_date between '01-JUL-16' and '31-DEC-16') 
ORDER BY hire_date DESC, last_name;

-- Q2.
-- Write a query to display the tomorrow’s date. The result will depend on the day when you RUN/EXECUTE this query.  Label the column “Next Day”.

SELECT sysdate + 1 "Next Day"
FROM dual;

-- Q3.
-- Users will often use the name they are accustomed to using. You need to figure out what it is really called for the SQL to work.
-- Show the following: product ID, product name, list price (means selling price) , and the new list price increased by 2%.
-- (a) Display a new list price (selling price) as a whole number.
-- (b) show only product numbers greater than 50000 and less than 60000
-- (c) product names that start with G or AS

SELECT prod_no, prod_name, prod_sell, round(prod_sell*1.02) "New List Price"
FROM products
WHERE (prod_no between 50000 and 60000) 
and (substr(prod_name, 1,1) = 'G' or substr(prod_name, 1,2) = 'AS');

-- Q5.
-- Display the job titles (job_id) and full names of employees whose first name contains an ‘e’ or ‘E’  anywhere, and also contains an 'a' or a 'g' anywhere. 
-- The output should look SIMILAR to this sample.
-- AGAIN, NO ALIAS COLUMN NAMES

SELECT job_id,concat(concat(first_name,' '),last_name) "Full Name"
FROM employees
WHERE (LOWER (first_name) LIKE '%e%') 
AND ((first_name) like '%a%' OR (first_name) like '%g%');

-- Q6.
-- For employees whose manager ID is 124, write a query that displays the employee’s Full Name and Job ID in the following format:
-- SUMMER, PAYNE is a Public Accountant.

SELECT UPPER(last_name)||', '||UPPER(first_name)||' is a ' || INITCAP(job_id)
FROM employees
WHERE manager_id = '124';

-- Q7.
-- For each employee hired before October 2016, display (a) the employee’s last name, 
-- (b) hire date and (c) calculate the number of YEARS between TODAY and the date the employee was hired.
-- The output for column (c) should be to only 1 decimal place.
-- Put the output in order by column (c) 
-- Since there are 54 rows, this time only copy the  the first 10 to 12 rows of output.
SELECT last_name, hire_date, TRUNC((sysdate - hire_date) / 365 , 1)
FROM employees
WHERE hire_date < '01-OCT-16'
ORDER BY 3;

-- Q8.
-- Display each employee’s last name, hire date, and the review date, which is the first Tuesday after a year of service, but only for those hired after 2016. 
-- •Label the column REVIEW DAY.
-- •Format the dates to appear in the format like:
-- TUESDAY, August the Thirty-First of year 2016
-- Sort by review date
-- because this is really week 2 notes now, hee is a similar answer as a hint:
-- SELECT last_name, hire_date,
-- TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 'MONDAY'),'fmDAY, " the " Ddspth " of " Month, YYYY') as "REVIEW"
-- FROM employees

SELECT last_name, hire_date, TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 12), 'TUESDAY'), 'fmDAY, Month" the "Ddspth" of year "YYYY') "REVIEW DAY"
FROM employees
WHERE hire_date > '01-JAN-2016'
ORDER BY 3;