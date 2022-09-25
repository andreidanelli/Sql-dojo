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
     GROUP BY em.dep_id)
	 
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
ORDER BY d.nome

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
JOIN empregados em ON d.dep_id = em.dep_id




