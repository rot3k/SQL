-- Sungsoo Cho
-- Student number 121182190
-- Lab 07

-- Q1. Create an empty table exactly the same as the employees table and name it newEmployees. 

create table newEmployees AS
select *
from employees
where 1=2;

-- Q2. Execute the following commands. 
set autocommit = off;
start transaction; 

-- Q3. Write an INSERT statement to populate the newEmployees table with the rows of the sample data.
--     Insert the NULL value for the reportsTo column. (Write a single INSERT statement to insert all the rows) 
insert into newemployees 
values (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1' , null, 'Sales Rep'),
	   (101, 'Denis' , 'Betty' , '334444' , 'bdenis@email.com' , '1' , null , 'Sales Rep'),
       (102, 'Biri' , 'Ben' , '44555' , 'bbirir@gmail.com' , '2' , null , 'Sales Rep'),
       (103, 'Newman' , 'Chad' , '66777' , 'cnewman@mail.com' , '3' , null , 'Sales Rep'),
       (104, 'Ropeburn' , 'Audrey' , '77888' , 'aropebur@gmail.com' , '1' , null , 'Sales Rep');

-- Q4. Create a report that shows all the inserted rows from the newEmployees table. How many rows are selected? 
   select * from newemployees;
   -- 5 rows are inserted
   
-- Q5. Execute the rollback command. Display all rows and columns from the newEmployees table. 
-- 	   How many rows are selected? 
rollback;
select * from newemployees;
-- There are no rows in newemployees table

-- Q6. Do Task 3. Make the insertion permanent to the table newEmployees. Display all rows and columns
--     from the newEmployee table. How many rows are selected?
insert into newemployees 
values (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1' , null, 'Sales Rep'),
	   (101, 'Denis' , 'Betty' , '334444' , 'bdenis@email.com' , '1' , null , 'Sales Rep'),
       (102, 'Biri' , 'Ben' , '44555' , 'bbirir@gmail.com' , '2' , null , 'Sales Rep'),
       (103, 'Newman' , 'Chad' , '66777' , 'cnewman@mail.com' , '3' , null , 'Sales Rep'),
       (104, 'Ropeburn' , 'Audrey' , '77888' , 'aropebur@gmail.com' , '1' , null , 'Sales Rep');
commit;

select * from newemployees;
-- 5 rows are inserted

-- Q7. Write an update statement to update the value of column jobTitle to ‘unknown’ for all the employees
--     in the newEmployees table. 
update newemployees set
jobTitle = 'unknown';

-- Q8. Make your changes permanent. 
commit;

-- Q9.  Execute the rollback command. 
rollback;

-- 9a. Display all employees from the newEmployees table whose job title is ‘unknown’. How many
-- rows are updated? 
select *
from newemployees
where jobTitle = 'unknown';
-- 5 rows are updated

-- 9b. Was the rollback command effective?
-- No. It wasn't effective

-- 9c. What was the difference between the result of the rollback execution from Task 5 and the
--     result of the rollback execution of this task?  
--     The main difference between task 5 and this task is "commit" command. 
--     If I execute "commit" comand after sql statement, updated data can be permanent and 
--     rollback doen't excute
