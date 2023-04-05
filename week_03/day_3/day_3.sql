--MVP

--Q1
-- How many employee records are lacking both a grade and salary?

SELECT
	count(id) AS num_of_employees
FROM employees
-- Filter for where both emloyees.grade AND employees.salary is NULL.
WHERE (grade IS NULL) AND (salary IS NULL);

--Q2
-- Produce a table with the two following fields (columns):
-- the department
-- the employees full name (first and last name)
-- Order your resulting table alphabetically by department, and then by last name

SELECT
	department,
	concat(first_name, ' ', last_name) AS full_name
FROM employees
ORDER BY department, last_name;

--Q3
-- Find the details of the top ten highest paid employees who have a last_name beginning with ‘A’.

SELECT *
FROM employees
-- Filter for where employees.last_name starts with 'A.'
WHERE last_name LIKE '%A%'
ORDER BY salary DESC NULLS LAST
LIMIT 10;

--Q4
-- Obtain a count by department of the employees who started work with the corporation in 2003.

SELECT
	department AS department_name,
	count(id) AS num_employees_since_2003
FROM employees
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;

--Q5
-- Obtain a table showing department, fte_hours and the number of employees in each department who 
-- work each fte_hours pattern. Order the table alphabetically by department, and then in ascending order of fte_hours.

SELECT
	department,
	fte_hours,
	count(id) AS num_employees
FROM employees
GROUP BY department, fte_hours
ORDER BY department, fte_hours;

--Q6
-- Provide a breakdown of the numbers of employees enrolled, not enrolled, and with unknown enrollment status in the corporation pension scheme.

SELECT
	pension_enrol,
	count(id) AS num_of_employee
FROM employees
GROUP BY pension_enrol;

--Q7
-- Obtain the details for the employee with the highest salary in the ‘Accounting’ department who is not enrolled in the pension scheme?

SELECT *
FROM employees
WHERE department = 'Accounting' AND pension_enrol = FALSE
ORDER BY salary DESC NULLS LAST
LIMIT 1;

--Q8
-- Get a table of country, number of employees in that country, and the average salary of employees in that country for any countries in which 
-- more than 30 employees are based. Order the table by average salary descending.

SELECT
	country,
	count(id) AS employee_per_country,
	avg(salary) AS avg_salary
FROM employees
GROUP BY country
-- Filters the country groups for those with more than 30 entries
HAVING count(id) > 30
ORDER BY avg_salary DESC;

--Q9
-- Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), salary, 
-- and a new column effective_yearly_salary which should contain fte_hours multiplied by salary. 
-- Return only rows where effective_yearly_salary is more than 30000.

SELECT
	first_name,
	last_name,
	fte_hours,
	salary,
-- Returns an effective salary amount for each employee.
	fte_hours * salary AS effective_yearly_salary	
FROM employees
-- Filters employees for those where there fte_hours multiplied by salary is greater than 30000.
WHERE fte_hours * salary > 30000;

--Q10
-- Find the details of all employees in either Data Team 1 or Data Team 2

SELECT *
FROM employees INNER JOIN teams ON employees.team_id = teams.id
-- Filters employees for only those whos team name is 'Data Team 1' OR 'Data Team 2'
WHERE teams.name IN ('Data Team 1', 'Data Team 2');

--Q11
-- Find the first name and last name of all employees who lack a local_tax_code.

SELECT
employees.first_name,
employees.last_name,
pay_details.local_tax_code
FROM employees INNER JOIN pay_details ON employees.pay_detail_id = pay_details.id
WHERE pay_details.local_tax_code IS NULL;

--Q12
-- The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours, 
-- where charge_cost depends upon the team to which the employee belongs. 
-- Get a table showing expected_profit for each employee.

SELECT
	first_name,
	last_name,
	salary,
	charge_cost,
	fte_hours,
	(48 * 35 * charge_cost::int - salary) * fte_hours AS expected_profit
FROM employees INNER JOIN teams ON employees.team_id = teams.id

--Q13
-- Find the first_name, last_name and salary of the lowest paid employee in Japan who works the 
-- least common full-time equivalent hours across the corporation.


SELECT
	first_name,
	last_name,
	country,
	salary
FROM employees
WHERE country = 'Japan'
ORDER BY salary
LIMIT 1

------------

SELECT
	fte_hours,
	count(id)
FROM employees
GROUP BY fte_hours
ORDER BY count
LIMIT 1;

------------

SELECT
	first_name,
	last_name,
	country,
	salary
FROM employees
WHERE (country = 'Japan') 
AND (fte_hours = (SELECT fte_hours
				  FROM employees
				  GROUP BY fte_hours
                  ORDER BY count(id)
                  LIMIT 1
))
ORDER BY salary
LIMIT 1;

--Q14
-- Obtain a table showing any departments in which there are two or more employees lacking a stored first name. 
-- Order the table in descending order of the number of employees lacking a first name, 
-- then in alphabetical order by department.

SELECT
	department,
	count(id) AS num_employees
FROM employees
WHERE first_name IS NULL
GROUP BY department
HAVING count(id) >= 2
ORDER BY count(id) DESC, department;

--Q15
-- Return a table of those employee first_names shared by more than one employee, 
-- together with a count of the number of times each first_name occurs. 
-- Omit employees without a stored first_name from the table. 
-- Order the table descending by count, and then alphabetically by first_name.

SELECT
	first_name,
	count(id)
FROM employees
WHERE first_name IS NOT NULL 
GROUP BY first_name
HAVING count(id) > 1
ORDER BY count(id) DESC, first_name;

--Q16
-- Find the proportion of employees in each department who are grade 1.

SELECT 
	department,
	SUM(CAST(grade = '1' AS INT)) / CAST(count(id) AS REAL) AS proportional_grade1
FROM employees 
GROUP BY department;






