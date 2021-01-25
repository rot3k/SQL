-- Sungsoo Cho
-- Student number 121182190
-- Lab 03

-- Q1
select * from offices;

-- Q2
select employeeNumber
from employees
where officeCode = 1;

-- Q3
select customerNumber, customerName, contactFirstName, contactLastName, phone
from customers
where city = 'Paris';

-- Q4
select distinct customerNumber
from payments;

-- Q5
select customerNumber, checkNumber, amount
from payments
where amount not between 30000 and 65000
order by amount desc;

-- Q6
select *
from orders 
where status like 'Cancelled';

-- Q7
select *
from products
where productName like '%co%';

-- Q8 
select *
from customers
where contactFirstName like 's%e%';