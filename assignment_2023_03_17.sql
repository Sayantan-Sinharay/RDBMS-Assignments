-- Postgres
-- Create a database name company.
CREATE DATABASE Company;

-- Create Jobs Table
CREATE TABLE Jobs (
  job_id SERIAL PRIMARY KEY NOT NULL,
  job_title VARCHAR(255),
  min_salary REAL NOT NULL,
  max_salary REAL NOT NULL
);

-- Create Regions Table
CREATE TABLE Regions (
  region_id VARCHAR(255) PRIMARY KEY NOT NULL,
  region_name VARCHAR(255) NOT NULL
);

-- Create Countries Table
CREATE TABLE Countries (
  country_id VARCHAR(255) PRIMARY KEY NOT NULL,
  country_name VARCHAR(255) NOT NULL,
  region_id VARCHAR(255) NOT NULL REFERENCES Regions(region_id)
);

-- Create Location Table
CREATE TABLE Locations (
  location_id VARCHAR(255) PRIMARY KEY NOT NULL,
  street_address VARCHAR(255) NOT NULL,
  postal_code VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  state_province VARCHAR(255) NOT NULL,
  country_id VARCHAR(255) NOT NULL REFERENCES Countries(country_id)
);

-- Create Departments Table
CREATE TABLE Departments (
  department_id VARCHAR(255) PRIMARY KEY NOT NULL,
  department_name VARCHAR(255) NOT NULL,
  location_id VARCHAR(255) NOT NULL REFERENCES Locations(location_id)
);

-- Create Employees Table
CREATE TABLE Employees (
  employee_id SERIAL PRIMARY KEY NOT NULL,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  email VARCHAR(255),
  phone_number VARCHAR(255),
  hire_date DATE NOT NULL,
  job_id INT NOT NULL REFERENCES Jobs(job_id),
  salary REAL,
  manager_id INT REFERENCES Employees(employee_id) CHECK(manager_id != employee_id),
  department_id VARCHAR(255) NOT NULL REFERENCES Departments(department_id)
);

-- Create Dependents Table
CREATE TABLE Dependents (
  dependent_id SERIAL PRIMARY KEY NOT NULL,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  relationship VARCHAR(255),
  employee_id INT NOT NULL REFERENCES employees(employee_id)
);

-- Jobs table
INSERT INTO
  Jobs (job_title, min_salary, max_salary)
VALUES
  ('Software Engineer', 50000, 100000),
  ('Database Administrator', 60000, 110000),
  ('Web Developer', 45000, 95000),
  ('Project Manager', 70000, 130000),
  ('Data Analyst', 55000, 105000),
  ('Systems Administrator', 65000, 115000),
  ('Network Engineer', 60000, 110000),
  ('UI/UX Designer', 50000, 95000),
  ('Technical Writer', 40000, 85000),
  ('QA Engineer', 45000, 95000);

-- Regions table
INSERT INTO
  Regions (region_id, region_name)
VALUES
  ('R001', 'North America'),
  ('R002', 'South America'),
  ('R003', 'Europe'),
  ('R004', 'Asia'),
  ('R005', 'Africa'),
  ('R006', 'Australia'),
  ('R007', 'Antarctica'),
  ('R008', 'Middle East'),
  ('R009', 'Central America'),
  ('R010', 'Caribbean');

-- Countries table
INSERT INTO
  Countries (country_id, country_name, region_id)
VALUES
  ('US', 'United States', 'R001'),
  ('CA', 'Canada', 'R001'),
  ('BR', 'Brazil', 'R002'),
  ('AR', 'Argentina', 'R002'),
  ('FR', 'France', 'R003'),
  ('DE', 'Germany', 'R003'),
  ('IN', 'India', 'R004'),
  ('CN', 'China', 'R004'),
  ('ZA', 'South Africa', 'R005'),
  ('AU', 'Australia', 'R006');

-- Locations table
INSERT INTO
  Locations (
    location_id,
    street_address,
    postal_code,
    city,
    state_province,
    country_id
  )
VALUES
  (
    'L001',
    '123 Main St',
    '12345',
    'New York',
    'NY',
    'US'
  ),
  (
    'L002',
    '456 Broad St',
    '67890',
    'Toronto',
    'ON',
    'CA'
  ),
  (
    'L003',
    '789 Pine St',
    '34567',
    'Rio de Janeiro',
    'RJ',
    'BR'
  ),
  (
    'L004',
    '123 Oak St',
    '56789',
    'Buenos Aires',
    'BA',
    'AR'
  ),
  (
    'L005',
    '456 Maple St',
    '89012',
    'Paris',
    'IDF',
    'FR'
  ),
  (
    'L006',
    '789 Cedar St',
    '23456',
    'Berlin',
    'BER',
    'DE'
  ),
  (
    'L007',
    '123 Pineapple St',
    '78901',
    'Mumbai',
    'MH',
    'IN'
  ),
  (
    'L008',
    '456 Orange St',
    '23456',
    'Beijing',
    'BJ',
    'CN'
  ),
  (
    'L009',
    '789 Cherry St',
    '56789',
    'Johannesburg',
    'GT',
    'ZA'
  ),
  (
    'L010',
    '123 Peach St',
    '12345',
    'Sydney',
    'NSW',
    'AU'
  );

-- Departments table
INSERT INTO
  Departments (department_id, department_name, location_id)
VALUES
  ('D001', 'Sales', 'L001'),
  ('D002', 'Marketing', 'L001'),
  ('D003', 'Engineering', 'L006'),
  ('D004', 'Finance', 'L002'),
  ('D005', 'Human Resources', 'L002'),
  ('D006', 'Customer Service', 'L010'),
  ('D007', 'Research and Development', 'L006'),
  ('D008', 'Production', 'L010'),
  ('D009', 'Quality Assurance', 'L010'),
  ('D010', 'Information Technology', 'L006');

Employees TABLE
INSERT INTO
  Employees (
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    manager_id,
    department_id
  )
VALUES
  (
    'John',
    'Doe',
    'johndoe@email.com',
    '555-1234',
    '2020-01-01',
    1,
    80000.00,
    NULL,
    'D001'
  ),
  (
    'Jane',
    'Doe',
    'janedoe@email.com',
    '555-5678',
    '2021-05-15',
    2,
    60000.00,
    1,
    'D001'
  ),
  (
    'Bob',
    'Smith',
    'bobsmith@email.com',
    '555-9012',
    '2019-03-01',
    3,
    90000.00,
    NULL,
    'D002'
  ),
  (
    'Alice',
    'Johnson',
    'alicejohnson@email.com',
    '555-3456',
    '2022-02-01',
    4,
    50000.00,
    3,
    'D002'
  ),
  (
    'Mike',
    'Williams',
    'mikewilliams@email.com',
    '555-7890',
    '2018-06-01',
    5,
    70000.00,
    NULL,
    'D003'
  ),
  (
    'Sarah',
    'Jones',
    'sarahjones@email.com',
    '555-2345',
    '2020-11-15',
    6,
    55000.00,
    5,
    'D003'
  ),
  (
    'Tom',
    'Davis',
    'tomdavis@email.com',
    '555-6789',
    '2019-09-01',
    7,
    100000.00,
    NULL,
    'D004'
  ),
  (
    'Emily',
    'Brown',
    'emilybrown@email.com',
    '555-0123',
    '2021-07-01',
    8,
    75000.00,
    7,
    'D004'
  );

-- Dependents TABLE
INSERT INTO
  Dependents (first_name, last_name, relationship, employee_id)
VALUES
  ('Jack', 'Doe', 'Child', 1),
  ('Jill', 'Doe', 'Child', 1),
  ('Sophie', 'Smith', 'Spouse', 3),
  ('Alex', 'Johnson', 'Child', 4),
  ('David', 'Jones', 'Child', 5),
  ('Olivia', 'Davis', 'Spouse', 7),
  ('Noah', 'Brown', 'Child', 8);

-- Constraints
ALTER TABLE
  Employees
ALTER COLUMN
  first_name
SET
  NOT NULL,
ALTER COLUMN
  last_name
SET
  NOT NULL;

ALTER TABLE
  Dependents
ALTER COLUMN
  first_name
SET
  NOT NULL,
ALTER COLUMN
  last_name
SET
  NOT NULL;

ALTER TABLE
  Jobs
ADD
  CHECK(min_salary > 1000);

ALTER TABLE
  Locations
ADD
  CHECK(LENGTH(postal_code) <= 10);

-- In departments table, add a new field ‘manager_name’ of type VARCHAR
ALTER TABLE
  Departments
ADD
  manager_name VARCHAR(255) NOT NULL;

-- REMOVE field max_salary from jobs
ALTER TABLE
  Jobs DROP COLUMN max_salary;

-- In the locations table, rename postal_code column to pincode.
ALTER TABLE
  Locations RENAME COLUMN postal_code TO pincode;