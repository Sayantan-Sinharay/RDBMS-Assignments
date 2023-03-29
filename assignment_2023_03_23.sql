-- Q1) Find all the departments where the minimum salary is less than 2000
SELECT
  D.department_name
FROM
  Department D
WHERE
  D.department_id IN (
    SELECT
      DISTINCT E.department_id
    FROM
      Employees E
    WHERE
      MIN(E.salary) < 2000
  );

-- Q2) Find all the countries where no employees exist
SELECT
  C.country_name
FROM
  Countries C
WHERE
  C.country_id NOT IN (
    SELECT
      DISTINCT L.country_id
    FROM
      Locations L
    WHERE
      L.location_id IN (
        SELECT
          D.location_id
        FROM
          Department D
        WHERE
          D.department_id IN (
            SELECT
              DISTINCT E.department_id
            FROM
              Employees E
          )
      )
  );

--Q3) From the following tables write a query to find all the jobs, having at least 2 employees in a single department.(don’t use joins)
SELECT
  J.job_title
FROM
  Jobs J
WHERE
  J.job_id IN (
    SELECT
      DISTINCT E.job_id
    FROM
      Employees E
    WHERE
      (
        SELECT
          COUNT(E1.department_id)
        FROM
          Employees E1
        WHERE
          E.department_id = E1.department_id
      ) >= 2
  );

-- Q4)From the following tables write a query to find all the countries, having cities with all the city names starting with 'a'.(don’t use joins)
SELECT
  C.country_name
FROM
  countries C
WHERE
  country_id = ALL(
    SELECT
      L.country_id
    FROM
      Locations L
    WHERE
      L.country_id = C.country_id
      AND L.city LIKE 'A%'
  );

-- Q5) From the following tables write a query to find all the departments, having no cities.
SELECT
  D.department_name
FROM
  Department D
WHERE
  D.location_id IN (
    SELECT
      L.location_id
    FROM
      Locations L
    WHERE
      L.location_id = D.location_id
      AND L.city IS NULL
  );