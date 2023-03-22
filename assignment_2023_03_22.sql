-- Q1. Write the query to get the department and department wise total(sum) salary, display it in ascending order according to salary.
SELECT
  D.department_name,
  SUM(E.salary) Total Salary,
FROM
  Employees E,
  Departments D
WHERE
  D.department_id = E.department_id
GROUP BY
  E.department_id
ORDER BY
  ASC SUM(E.salary);

-- Q2. Write the query to get the department, total no. employee of each department, total(sum) salary with respect to department from "Employee" table.
SELECT
  D.department_name,
  COUNT(E.employee_id),
  SUM(E.salary) Total Salary,
FROM
  Employees E,
  Departments D
WHERE
  D.department_id = E.department_id
GROUP BY
  E.department_id;

-- Q3. Get department wise maximum salary from "Employee" table order by salary ascending
SELECT
  D.department_name,
  MAX(E.salary)
FROM
  Employees E,
  Departments D
WHERE
  D.department_id = E.department_id
GROUP BY
  department_id
ORDER BY
  ASC MAX(E.salary);

-- Q4. Write a query to get the departments where average salary is more than 60k 
SELECT
  D.department_name
FROM
  Departments D,
  Employees E
WHERE
  D.department_id = E.department_id
GROUP BY
  E.department_id
HAVING
  AVG(E.salary) > 60000;

-- Q5. Write down the query to fetch department name assign to more than one Employee
SELECT
  D.department_name
FROM
  Departments D,
  Employees E
WHERE
  D.department_id = E.department_id
GROUP BY
  E.department_id
HAVING
  COUNT(E.employee_id) > 1;

-- Q6. Write a query to show department_name and assignedTo where assignedTo will be “One candidate” if its assigned to only one employee otherwise “Multiple candidates”
SELECT
  D.department_name
FROM
  Departments D,
  Employees E
WHERE
  D.department_id = E.department_id
  AND CASE
    WHEN COUNT(E.employee_id) > 1 THEN "Multiple candidates"
    WHEN COUNT(E.employee_id) = 1 THEN "One candidates"
  END AS assignedTo
GROUP BY
  E.department_id;