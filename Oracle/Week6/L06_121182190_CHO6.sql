-- ***********************
-- Name: Sungsoo Cho
-- ID: 121182190
-- Date: 11/20/2020
-- Purpose: Lab 6 DBS311
-- ***********************

SET SERVEROUTPUT ON;
-- Question 1 
--The company wants to calculate what the employees’ annual salary would be:
--Do NOT change any salaries in the table.
--Assume that the starting salary or sometimes called base salary was $10,000.
--Every year of employment after that, the salary increases by 5%.
--Write a stored procedure named calculate_salary which gets an employee ID from the user and for that employee, 
--calculates the salary based on the number of years the employee has been working in the company.  (Use a loop construct the calculation of the salary).
--The procedure calculates and prints the salary.
--Sample output:
--First Name: first_name 
--Last Name: last_name
--Salary: $9999,99
--If the employee does not exist, the procedure displays a proper message.

-- Q1 SOLUTION –
CREATE OR REPLACE PROCEDURE calculate_salary (id employees.employee_id%TYPE) 
AS

baseSalary NUMBER := 10000;
firstName employees.first_name%TYPE;
lastName employees.last_name%TYPE;
salary employees.salary%TYPE;
empYear NUMBER;

BEGIN
SELECT first_name, last_name, TRUNC((sysdate - hire_date)/365, 0) 
INTO firstName, lastName, empYear
FROM employees
WHERE employee_id = id;

FOR i IN 1..empYear LOOP
baseSalary := baseSalary * 1.05;
END LOOP;
DBMS_OUTPUT.PUT_LINE('First name: '||firstName);
DBMS_OUTPUT.PUT_LINE('Last name: '||lastName);
DBMS_OUTPUT.PUT_LINE('Salary: '||'$'|| round(basesalary));

EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Employee not found.');
END calculate_salary;

--Execution statement
BEGIN
   calculate_salary(&id); 
END;

-- Question 2 – 
--Write a stored procedure named employee_works_here to print the employee_id, employee Last name and department name.
--This is sample output
--Employee #		Last Name		Department Name
--9999			Able			Manufacturing
--9998			Notsoable		Shipping
--If the value of the department name is null or does not exist, display “no department”.
--The value of employee ID ranges from your Oracle id's last 2 digits  (ex: dbs311_203g37 would use 37) to employee 105.
--(NOTE: Check manually and not in the procedure, to see if your number is in the employee table. If not pick the first employee number higher that does exist)
--Since you are looping there will be missing employee numbers. At that stage you can get out of the loop that displays the data about each employee.

-- Q2 Solution –
CREATE OR REPLACE PROCEDURE employee_works_here (id employees.employee_id%TYPE) 
AS

condition BOOLEAN := true;
beginEmpId NUMBER := id;
lastName employees.last_name%TYPE;
departmentName departments.department_name%TYPE;
empId  employees.employee_id%TYPE;
endEmpId NUMBER := 105;

BEGIN
DBMS_OUTPUT.PUT_LINE('Employee #		Last Name		Department Name');

WHILE condition LOOP
SELECT e.employee_id, e.last_name, d.department_name
INTO empId, lastName, departmentName
FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id = beginEmpId;

IF departmentName IS NULL THEN departmentName := 'no department';
END IF;

--DBMS_OUTPUT.PUT_LINE(beginEmpId||'		' ||lastName||'		'|| departmentName); 
DBMS_OUTPUT.PUT_LINE(rpad(to_char(beginEmpId), 16)||rpad(lastName, 10)||'		'|| rpad(departmentName, 10)); 
beginEmpId := beginempid + 1;
IF beginEmpId = endEmpId THEN condition := false;
END IF;
END LOOP;

EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Employee not found.');
END employee_works_here;

--Execution statement
BEGIN
   employee_works_here(11); 
END;