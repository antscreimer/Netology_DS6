--1
CREATE TABLE 
Department (
  id integer PRIMARY KEY,
  name VARCHAR(100)
  );
  
 insert into Department values
('1', 'Therapy'),
('2', 'Neurology'),
('3', 'Cardiology'),
('4', 'Gastroenterology'),
('5', 'Hematology'),
('6', 'Oncology');


 CREATE TABLE
 Employee (
   id integer PRIMARY KEY,
   department_id integer REFERENCES department(id),
   chief_doc_id integer,
   name VARCHAR(100),
   num_public integer
   --FOREIGN KEY(id) REFERENCES department(id)
   );
  
  insert into Employee values
('1', '1', '1', 'Kate', 4),
('2', '1', '1', 'Lidia', 2),
('3', '1', '1', 'Alexey', 1),
('4', '1', '2', 'Pier', 7),
('5', '1', '2', 'Aurel', 6),
('6', '1', '2', 'Klaudia', 1),
('7', '2', '3', 'Klaus', 12),
('8', '2', '3', 'Maria', 11),
('9', '2', '4', 'Kate', 10),
('10', '3', '5', 'Peter', 8),
('11', '3', '5', 'Sergey', 9),
('12', '3', '6', 'Olga', 12),
('13', '3', '6', 'Maria', 14),
('14', '4', '7', 'Irina', 2),
('15', '4', '7', 'Grit', 10),
('16', '4', '7', 'Vanessa', 16),
('17', '5', '8', 'Sascha', 21),
('18', '5', '8', 'Ben', 22),
('19', '6', '9', 'Jessy', 19),
('20', '6', '9', 'Ann', 18);

--2.a
SELECT department.name, COUNT(chief_doc_id) as num_chief
FROM
department
LEFT JOIN Employee
ON department.id = employee.department_id
GROUP BY department.name;

--2.b
SELECT department.id, department.name, COUNT(chief_doc_id) as num_chief
FROM
department
LEFT JOIN employee
ON department.id = employee.department_id
GROUP BY department.id, department.name
HAVING COUNT(chief_doc_id) >= 3;

--2.c
WITH temp_table
AS
(SELECT department.id, department.name, sum(num_public) as sum_public
 FROM
 department
 LEFT JOIN employee
 ON department.id = employee.department_id
 GROUP BY department.id, department.name
 ORDER BY sum_public DESC
 )
 SELECT * FROM temp_table
 WHERE sum_public = (SELECT MAX(sum_public) FROM temp_table);
 
 --2.d
WITH temp_table
AS
(
SELECT department_id, department.name, employee.name,
MIN(num_public) OVER (PARTITION BY employee.department_id) as min_public, num_public
FROM department
LEFT JOIN employee
ON department.id = employee.department_id
ORDER BY department_id
)
SELECT * FROM 
temp_table
WHERE num_public = min_public;
