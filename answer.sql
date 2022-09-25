--Question 1
SELECT em.nome AS empregado,
       e.nome AS chefe,
       em.salario AS emp_sal,
       e.salario AS chef_sal
FROM empregados e
JOIN empregados em ON e.emp_id = em.supervisor_id
WHERE em.salario > e.salario;

--Question 2
SELECT d.nome,
       max(e.salario)
FROM empregados e
JOIN departamentos d ON e.dep_id = d.dep_id
GROUP BY e.dep_id,
         d.nome
ORDER BY d.nome;

--Question 3
SELECT e.dep_id,
       e.nome,
       e.salario
FROM empregados e
WHERE e.salario =
    (SELECT MAX(em.salario)
     FROM empregados em
     WHERE e.dep_id = em.dep_id
     GROUP BY em.dep_id);
	 
--Question 4
SELECT e.nome
FROM
  (SELECT count(e.dep_id) AS total,
          d.dep_id,
          d.nome
   FROM empregados e
   JOIN departamentos d ON e.dep_id = d.dep_id
   GROUP BY d.dep_id
   HAVING count(*) < 3) e
ORDER BY e.nome;

--Question 6
SELECT d.nome,
       e.count
FROM
  (SELECT e.dep_id,
          count(e.dep_id)
   FROM empregados e
   GROUP BY e.dep_id) e
JOIN departamentos d ON e.dep_id = d.dep_id
ORDER BY d.nome;

--Question 7
SELECT em.nome,
       e.dep_id
FROM departamentos d
JOIN
  (SELECT count(e.dep_id),
          e.dep_id
   FROM empregados e
   GROUP BY e.dep_id
   HAVING count(*) = 1) e ON d.dep_id = e.dep_id
JOIN empregados em ON d.dep_id = em.dep_id;

--Question 8
SELECT d.nome AS departamentos,
       e.total
FROM departamentos d
JOIN
  (SELECT e.dep_id,
          sum(e.salario) AS total
   FROM empregados e
   GROUP BY e.dep_id) e ON d.dep_id = e.dep_id
ORDER BY d.nome;

--Question 9
SELECT e.nome AS empregado,
       d.nome AS departamento,
	   e.salario AS salario,
       em.avg AS media
FROM empregados e
JOIN
  (SELECT avg(em.salario),
          em.dep_id
   FROM empregados em
   GROUP BY em.dep_id) em ON em.dep_id = e.dep_id
JOIN departamentos d ON e.dep_id = d.dep_id
WHERE e.salario > em.avg
ORDER BY e.nome;

--Question 10
SELECT
	e.emp_id,
	e.nome,
	e.dep_id,
	e.salario,
	AVG (e.salario) OVER (
	   PARTITION BY e.dep_id
	) AS agv_salary
FROM
	empregados e
	INNER JOIN 
		departamentos d USING (dep_id);
		
--Question 11
WITH average_employees AS
  (SELECT d.dep_id,
          d.nome,
          avg(e.salario) AS avg_salary
   FROM empregados AS e
   JOIN departamentos AS d ON d.dep_id = e.dep_id
   GROUP BY d.dep_id)
SELECT e.nome,
       e.salario,
       e.dep_id,
       average_employees.avg_salary
FROM empregados AS e
JOIN average_employees ON e.dep_id = average_employees.dep_id
AND e.salario >= average_employees.avg_salary
ORDER BY e.dep_id,
         e.nome

--Question N
--Listar o nome do funcionario e departamento com menor salario dentro de cada departamento.
SELECT e.nome AS empregado,
	   d.nome AS departamento,	
       e.salario AS salario
FROM empregados e
JOIN departamentos d on e.dep_id = d.dep_id
WHERE e.salario =
    (SELECT MIN(em.salario)
     FROM empregados em
     WHERE e.dep_id = em.dep_id
     GROUP BY em.dep_id)
ORDER BY e.nome;