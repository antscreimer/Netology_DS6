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
SELECT department.id, department.name, employee.name,
MIN(num_public) OVER (PARTITION BY department.name) as min_public
FROM
department
LEFT JOIN employee
ON department.id = employee.department_id
GROUP BY department.id, department.name;
--HAVING min_public;
