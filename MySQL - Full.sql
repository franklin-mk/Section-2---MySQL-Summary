--C7-Creating Tables ---------------------------------------------------------------------------------------|

CREATE TABLE student (
    student_id INT,
    name VARCHAR(20),
    major varchar (20),
    PRIMARY KEY(student_id)
);

DESCRIBE student;

DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL(3, 2);

ALTER TABLE student DROP COLUMN gpa;

--C8-Inseting data -----------------------------------------------------------------------------------------|

CREATE TABLE student (
    student_id INT,
    name VARCHAR(20),
    major varchar (20),
    PRIMARY KEY(student_id)
);
SELECT * FROM student;

INSERT INTO student(student_id, name) VALUES(3, 'Claire');

DESCRIBE student;

--C9-Constrains -------------------------------------------------------------------------------------------|

Drop table student;

CREATE TABLE student (
    student_id INT AUTO_INCREMENT,
    name VARCHAR(20),
    major varchar (20) DEFAULT 'undecided',
    PRIMARY KEY(student_id)
);

SELECT * FROM student;

INSERT INTO student(name, major) VALUES('Jack', 'Biology');
INSERT INTO student(name, major) VALUES('Kate', 'Sociology');
INSERT INTO student(name, major) VALUES('Claire', 'Chemistry');
INSERT INTO student(name, major) VALUES('Jack', 'Biology');
INSERT INTO student(name, major) VALUES('Mike', 'Computer Science');

DESCRIBE student;

--C10-Update & Delete --------------------------------------------------------------------------------------|

SELECT * FROM student;

UPDATE student
SET major = 'Bio', name='Tom'
WHERE student_id=4;

Delete from student
Where name="Claire";

--C11-Basic Queries -----------------------------------------------------------------------------------------|

SELECT *
FROM student
order by student_id desc, name desc
LIMIT 4;

SELECT *
FROM student
where major = "Biology" or name ="Mike";

SELECT *
FROM student
where name in ("Mike", "Jack");

SELECT *
FROM student
where name in ("Mike", "Jack") and student_id >= 3;

-- <, >, <=,>, =, <>, AND, OR

SELECT name, major
FROM student;

-- C12-Creating Company Database -----------------------------------------------------------------------------|

CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);


select * from employee;
select * from branch;
select * from client;
select * from works_with;
select * from branch_supplier;

-- C13-More Basic Queries -------------------------------------------------------------------------------------|
--Find all employees
select * from employee;

-- Find all clients
select * from client;

-- Find all branches
select * from branch;

-- Find all works with
select * from works_with;

-- Find all branch suppliers
select * from branch_supplier;

-- Find all employees ordered by salary
SELECT *
FROM employee
ORDER BY salary DESC;

-- Find all employees ordered by sex then name
SELECT *
FROM employee
ORDER BY sex asc, first_name asc, last_name;


-- Find the first 5 employees
SELECT *
FROM employee
LIMIT 5;

-- Find the first and last name of all employees
SELECT first_name, last_name
FROM employee;

-- Find the forname and surname of all employees
SELECT first_name AS forname, last_name AS surname
FROM employee;

-- Find tout all the different gender
SELECT DISTINCT sex
FROM employee;

-- C14 - Functions in SQL ------------------------------------------------------------------------------------|
--Find all number of employees
Select count(emp_id)
from employee;

--Find all number of supervisors
Select count(super_id)
from employee;

--Find the number of female employees born after 1970
Select count(emp_id)
from employee
where sex = "F" AND birth_date > '1971-01-01';

--Find average of all employee salaries
Select avg(salary)
from employee;

--Find average of all male employee salaries
Select avg(salary)
from employee
where sex ='M';

--Find SUM of all employee salaries
Select SUM(salary)
from employee;

--Find how many males and females are there --Aggregation
Select COUNT(sex), sex
from employee
GROUP BY sex;

--Find the total sales of each sales man --Aggregation
Select sum(total_sales), emp_id
from works_with
GROUP BY emp_id;

--Find the total of each client spend --Aggregation
Select sum(total_sales), client_id
from works_with
GROUP BY client_id;

ALTER TABLE employee CHANGE COLUMN birth_day birth_date DATE;

-- C15- Wild Cards --------------------------------------------------------------------------------------------|
-- % = any number of characters, _ = one character

-- Find any client's who are an LLC
SELECT *
FROM client,
WHERE client_name LIKE '%LLC';

-- Find any branch suppliers who are in the label business
select *
from branch_supplier
where supplier_name like '%Label%';

-- Find any employee born on the 10th day of the month
select *
from employee
where birth_date like '____-10%';

-- Find any clients who are schools
select *
from client
where client_name like "%school%";




-- A wildcard character is used to substitute one or more characters in a string.
-- Wildcard characters are used with the LIKE operator. 
-- The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.
/* 
    %	Represents zero or more characters
    _	Represents a single character
    []	Represents any single character within the brackets *
    ^	Represents any character not in the brackets *
    -	Represents any single character within the specified range *
    {}	Represents any escaped character **
 */


-- C16-Union -----------------------------------------------------------------------------------------------|
-- Find a list of employee and branch names --can also combine more than one
SELECT first_name AS Company_Names
FROM employee
UNION
SELECT branch_name
FROM branch 
UNION
SELECT client_name
FROM client;

-- Find a list of all clients & branch suppliers' names
SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

--Find a list of all money spent or earned by the company
SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;



-- The UNION operator is used to combine the result-set of two or more SELECT statements.
-- Every SELECT statement within UNION must have the same number of columns
-- The columns must also have similar data types
-- The columns in every SELECT statement must also be in the same order

-- C17 - Joins -----------------------------------------------------------------------------------------------|
-- Add the extra branch
INSERT INTO branch VALUES(4, "Buffalo", NULL, NULL);

-- Find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;




select * from branch;

-- A JOIN clause is used to combine rows from two or more tables, based on a related column between them.
-- -------------------------------------------- Types of joins ----------------------------------------------|
-- (INNER) JOIN: Returns records that have matching values in both tables                                    |
-- LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table  |
-- RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table |
-- FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table                |
|  ----------------------------------------------------------------------------------------------------------|


-- C18 - Nested Queries -------------------------------------------------------------------------------------|
-- Find names of all employees who have sold over 30,000 to a single client
select  employee.emp_id, employee.first_name, employee.last_name, works_with.total_sales
from employee
join works_with -- added
on employee.emp_id = works_with.emp_id  -- added
where employee.emp_id IN (
    SELECT  works_with.emp_id
    from works_with
    where  works_with.total_sales > 30000
);

-- Find all clients who are handles by the branch that Michael Scott manages
-- Assume you know Michael's ID
SELECT client.client_id, client.client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
    limit 1
);

-- Find all clients who are handles by the branch that Michael Scott manages
 -- Assume you DONT'T know Michael's ID
 SELECT client.client_id, client.client_name
 FROM client
 WHERE client.branch_id = (SELECT branch.branch_id
                           FROM branch
                           WHERE branch.mgr_id = (SELECT employee.emp_id
                                                  FROM employee
                                                  WHERE employee.first_name = 'Michael' AND employee.last_name ='Scott'
                                                  LIMIT 1));


-- Find the names of employees who work with clients handled by the scranton branch
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
                         SELECT works_with.emp_id
                         FROM works_with
                         )
AND employee.branch_id = 2;

-- Find the names of all clients who have spent more than 100,000
SELECT client.client_name
FROM client
WHERE client.client_id IN (
                          SELECT client_id
                          FROM (
                                SELECT SUM(works_with.total_sales) AS totals, client_id
                                FROM works_with
                                GROUP BY client_id) AS total_client_sales
                          WHERE totals > 100000
);


-- Nested queries are a way to perform complex queries by embedding one query within another.
-- The outer query can apply some conditions on the results of the inner query.


-- C19 - On Delete -------------------------------------------------------------------------------------------|
-- https://www.geeksforgeeks.org/difference-between-on-delete-cascade-and-on-delete-set-null-in-dbms/




-- C20 - Triggers --------------------------------------------------------------------------------------------|
-- CREATE
--     TRIGGER `event_name` BEFORE/AFTER INSERT/UPDATE/DELETE
--     ON `database`.`table`
--     FOR EACH ROW BEGIN
-- 		-- trigger body
-- 		-- this code is applied to every
-- 		-- inserted/updated/deleted row
--     END;

CREATE TABLE trigger_test (
     message VARCHAR(100)
);

DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('added new employee');
    END$$
DELIMITER ;
INSERT INTO employee
VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES(NEW.first_name);
    END$$
DELIMITER ;
INSERT INTO employee
VALUES(110, 'Kevin', 'Malone', '1978-02-19', 'M', 69000, 106, 3);

DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
         IF NEW.sex = 'M' THEN
               INSERT INTO trigger_test VALUES('added male employee');
         ELSEIF NEW.sex = 'F' THEN
               INSERT INTO trigger_test VALUES('added female');
         ELSE
               INSERT INTO trigger_test VALUES('added other employee');
         END IF;
    END$$
DELIMITER ;
INSERT INTO employee
VALUES(111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);


DROP TRIGGER my_trigger;

-- An SQL trigger is a database object that is associated with a table and 
-- automatically executes a set of SQL statements when a specific event occurs on that table.



-- C21 - ER Diagrams Intro -----------------------------------------------------------------------------------|
-- Entity = An object we want to model & store information about.
-- ER = Entity Relationship

-- Composite Attribute = An attribute that can be broken up into sub-attribute
-- Multi-value Attribute = An attribute that can have more that one vale
-- Derived Attribute = An attribute that can be derived from the other attributes
-- Multiple Entity = You can define more than one entity in the diagram
-- Relationships = defines a relations between two entities
-- Participation = All memebers mus participate in the relationship
-- Relationships Attribute = An attribute about the relationship
-- Relationship Cardinality = the numbers of instances of an entity from a relation that can  be associated with the relation.
-- Weak Entity = an entity that cannot be uniquely identified by its attributes alone
-- Identifying relationships - A relationship that serves to uniquely identify the weak entity

-- C22 - Designing an ER Diagram -----------------------------------------------------------------------------|
