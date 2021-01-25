-- Sungsoo Cho
-- Student number 121182190
-- Lab 04

-- Part A
-- 1. Create table the following tables and their given constraints: 
create table movies (
id int,  
title varchar(35) not null,
year int not null,
director int not null,
score decimal(3,2),
primary key (id),
constraint movies_chk_1
 check (score between 0 and 5 ));
 
create table actors (
id int,
name varchar(20) not null,
Lastname varchar(30) not null,
primary key (id));

create table castings (
movieid int,
actorid int,
primary key (movieid, actorid),
foreign key (movieid) references Movies (id),
foreign key (actorid) references Actors (id));

create table directors (
id int,
name varchar(20) not null,
Lastname varchar(30) not null,
primary key (id));

-- 2. Modify the movies table to create a foreign key constraint that refers to table directors.
alter table movies 
add constraint FK_director
foreign key (director) 
references directors (id);

-- 3. Modify the movies table to create a new constraint so the uniqueness of the movie title is guaranteed.
alter table movies
add constraint UC_title
unique (title);

-- 4. Write insert statements to add the following data to table directors and movies.
insert into directors (id, name, lastname)
values ('1010','Rob','Minkoff'),
       ('1020','Bill','Condon'),
       ('1050','Josh','Cooley'),
       ('2010','Brad','Bird'),
       ('3020','Lake','Bell');
       
insert into movies (id, title, year, director, score)
values (100,'The Lion King',2019,3020,3.50),
       (200,'Beauty and the Beast',2017,1050,4.20),
       (300,'Toy Story 4',2019,1020,4.50),
       (400,'Mission Impossible',2018,2010,5.00),
       (500,'The Secret Life of Pets',2016,1010,3.90);

-- 5. Write a SQL statement to remove all above tables. Is the order of tables important when removing? Why?
drop table castings, actors, movies, directors;
-- There are parents and child tables which are connected by foreign key. 
-- If we try to delete child table, it wouldn't work because the data from child table is referred from parents' by foreign key.
-- It means if parents table is delete first, the child table would lost their data from parents' and child table should be unusable. 
-- So we need to delete child table first then delete the parents table in this case.     

-- Part B
-- 1. Create a new empty table employee2 exactly the same as table employees.
create table employees2 as
(select * 
from employees
where employeeNumber is null);

-- 2. Modify table employee2 and add a new column username of type character to store up
-- to 40 characters to this table. The value of this column is not required and does not have
-- to be unique.
alter table employees2
add username char(40);

-- 3. Insert all student data from the employees table into your new table employee2.
insert into employees2 (employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
select *
from employees;

-- 4. In table employee2, write a SQL statement to change the first name and the last name of employee with ID 1002 to your name.
update employees2 set
firstName = 'Sungsoo', lastName = 'Cho'
where employeeNumber = 1002;

-- 5. In table employee2, generate the email address for column username for each student
-- by concatenating the first character of employee’s first name and the employee’s last
-- name. For instance, the username of employee Peter Stone will be pstone.
update employees2 set
username = concat(left(firstName,1), lastName);

-- 6. In table employee2, remove all employees with office code 4.
delete from employees2
where officeCode = 4;

-- 7. Drop table employee2.
drop table employees2;




















