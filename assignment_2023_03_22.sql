-- postgres
-- Q1. From the following tables write a SQL query to find the details of an employee.
RETURN FULL name,
email,
salary,
Department Name,
postal code,
AND City.
SELECT
  CONCAT_WS(' ', E.first_name, E.last_name) full_name,
  E.email,
  E.salary,
  D.department_name,
  L.postal_code,
  L.city
FROM
  Employees E
  INNER JOIN Departments D ON E.department_id = D.department_id
  INNER JOIN Locations L ON D.location_id = L.location_id;

-- Q2. From the following tables write a SQL query to find the departments whose location is in "Jammu Kashmir" or "Jharkhand". Return Department Name, state_province,
street_address.
SELECT
  D.department_name,
  L.state_province,
  L.street_address
FROM
  Departments D
  INNER JOIN Locations L ON D.location_id = L.location_id
WHERE
  L.state_province IN ('Jammu Kashmir', 'Jharkhand');

-- Q3. From the following tables write a SQL query to find the count of employees present in different jobs whose average salary is greater than 10,000. Return all the jobs with employee count, Job Name, and average salary.
SELECT
  COUNT(E.employee_id),
  J.job_name,
  AVG(E.salary)
FROM
  Employees E
  INNER JOIN Jobs J ON E.job_id = J.job_id
GROUP BY
  J.job_id
HAVING
  AVG(E.salary) > 10000;

-- Q4. From the following table write a SQL query to find all the first_names and last_names in both dependents and employees tables. Return the duplicate records as well and order the records in descending order of the last_name column.
SELECT
  E.first_name,
  E.last_name,
  D.first_name,
  D.last_name
FROM
  Employees E
  INNER JOIN Dependents D ON E.employee_id = D.employee_id
WHERE
  e.employee_id = ALL(
    SELECT
      E.employee_id
    FROM
      Employees E
      INNER JOIN Dependents D ON E.employee_id = D.employee_id
    GROUP BY
      E.employee_id,
      D.employee_id
    HAVING
      count(D.employee_id) > 1
  )
ORDER BY
  E.last_name,
  D.last_name;

-- Q5. From the following table write a SQL query to list every employee that has a manager with the name of his or her manager.
SELECT
  E.first_name,
  E.last_name,
  M.first_name,
  M.last_name
FROM
  Employees E
  INNER JOIN Employees M ON E.manager_id = M.employee_id;

-- Q6. Find the departments that have more than 5 employees earning a salary greater than 50,000 and are located in either New York or California. Include the department name, location, and the number of employees meeting the criteria.
SELECT
  D.department_name,
  L.city,
  COUNT(E.employee_id)
FROM
  Employees E
  INNER JOIN Departments D ON E.department_id = D.department_id
  INNER JOIN Locations L ON D.location_id = L.location_id
WHERE
  E.salary > 50000
  AND L.city IN ('New York', 'California')
GROUP BY
  E.department_id,
  D.department_id,
  L.location_id
HAVING
  COUNT(E.employee_id) > 5;

-- Q7. List any employees who have dependents and have a job title that includes the word 'manager', and sort the results by department name in ascending order.
SELECT
  E.first_name,
  E.last_name
FROM
  Employees E
  RIGHT JOIN Dependents D ON E.employee_id = D.employee_id
  INNER JOIN Jobs J ON E.job_id = J.job_id
  INNER JOIN Departments Dept ON E.department_id = Dept.department_id
WHERE
  J.job_title ~* 'manager'
ORDER BY
  Dept.department_name ASC;

-- Q8. Add a column in the dependent table called “city” depicting their current location of stay. Find all employees who have been hired in the past 3 years and have dependents living in a city that is different from the city they work in (if I work in Kolkata, then my dependent should not be in Kolkata). Additionally, only include employees whose salary is greater than the average salary of their job title(suppose, my job_title is ”developer” and the salary is 80k, and the average salary under the same job_title “developer” is 70k), and whose manager's job title includes the word 'director'. Finally, include the department name and location of each employee, and sort the results by department name in ascending order.
ALTER TABLE
  Dependents
ADD
  COLUMN city;

SELECT
  E.first_name,
  E.last_name,
  Dept.department_name,
  L.city
FROM
  Employees E
  INNER JOIN Dependents D ON D.employee_id = E.employee_id
  INNER JOIN Jobs J ON J.job_id = E.job_id
  INNER JOIN Departments Dept ON E.department_id = Dept.department_id
  INNER JOIN Locations L ON Dept.location_id = L.location_id
WHERE
  D.city != L.city
  AND E.hire_date > NOW() - '3 years' :: INTERVAL
  AND E.employee_id = ALL(
    SELECT
      E.employee_id
    FROM
      Employees E
      INNER JOIN Employees M ON E.manager_id = M.employee_id
      INNER JOIN Jobs J ON J.job_id = M.job_id
    WHERE
      J.job_title ~* 'director'
  )
GROUP BY
  E.employee_id,
  Dept.department_id,
  L.location_id,
  E.job_id
HAVING
  E.salary > AVG(E.salary);