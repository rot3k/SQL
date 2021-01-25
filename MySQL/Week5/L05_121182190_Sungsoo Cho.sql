-- Sungsoo Cho
-- Student number 121182190
-- Lab 05

-- Tasks
-- Q1. For all employees in France, display employee number, first name, last name, city, phone number and postal code
select e.employeeNumber, e.firstName, e.lastName, o.city, o.phone, o.postalCode 
from employees e, offices o
where o.country = "France";

-- Q2. Create a view (customer_order) to list all orders with the following data for all
-- customers: customerNumber, order number, order date, order line number,product name, quantity ordered, and price for each product in every order
create view customer_order as
select c.customerNumber, o.orderNumber, o.orderDate, od.orderLineNumber, p.productName, od.quantityOrdered, od.priceEach
from customers c, orders o, orderdetails od, products p;

-- Q3. Using the customer_order view, display the order information for customer number 124. Sort the output based on order number and then order line number
select *
from customer_order
where customerNumber = 124;
-- order by orderNumber, orderLineNumber; // it doesn't work

-- Q4 Display customer number, first name, last name, phone, and credit limits for all customers who do not have any orders
select c.customerNumber, c.contactFirstName, c.contactLastName, c.phone, c.creditLimit
from  customers c left join orders o
on orderNumber is null;

-- Q5 Create a view (employee_manager) to display all information of all employees and the name and the last name of their managers 
-- if there is any manager that the employee reports to
create view employee_manager as
select e1.employeeNumber, e1.lastName,e1.firstName, e1.extension, e1.email,e1.officeCode, e1.jobTitle, e1.reportsTo, 
	   e2.firstName as MGR_firstName, e2.lastName as MGR_lastName
from employees e1 inner join employees e2
on e1.reportsTo = e2.employeeNumber;
-- I wrote all columns of e1 intead of using * because i wanted to change the order of them to show the data more efficient 
-- 'MGR firstname and lastname coulums are right next to 'reportsTo' column  

-- Q6 Modify the employee_manager view so the view returns only employee information for employees who have a manager
create or replace view employee_manager as
select *
from employees 
where reportsTo is not null;

-- 07 Drop both customer_order and employee_manager views
drop view  customer_order,  employee_manager;
