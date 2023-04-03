/* MVP */

/* Q1 */
-- Find all the employees who work in the ‘Human Resources’ department.

SELECT *
FROM employees
WHERE department = 'Human Resources';

/* Q2 */
-- Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.

SELECT
	first_name,
	last_name,
	country,
FROM employees
WHERE department = 'Legal';

/* Q3 */
-- Count the number of employees based in Portugal.

SELECT
	count(*) AS portugal_employee_count
FROM employees
WHERE country = 'Portugal';

/* Q4 */
-- Count the number of employees based in either Portugal or Spain.

SELECT
	count(*) AS portugal_spain_employee_count
FROM employees
WHERE country IN ('Portugal', 'Spain');

/* Q5 */
-- Count the number of pay_details records lacking a local_account_no.

SELECT
	count(*) AS missing_local_account_no
FROM pay_details
WHERE local_account_no IS NULL;

/* Q6 */
-- Are there any pay_details records lacking both a local_account_no and iban number?

SELECT
	count(*) AS missing_local_account_no_and_iban
FROM pay_details
WHERE (local_account_no IS NULL)
AND iban IS NULL;

/* Q7 */
-- Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).

SELECT
	first_name,
	last_name
FROM employees
ORDER BY last_name NULLS LAST;

/* Q8 */
-- Get a table of employees first_name, last_name and country, ordered alphabetically first by country 
-- and then by last_name (put any NULLs last).

SELECT
	first_name,
	last_name,
	country
FROM employees
ORDER BY 
	country,
	last_name NULLS LAST;

/* Q9 */
-- Find the details of the top ten highest paid employees in the corporation.

SELECT *
FROM employees
WHERE salary IS NOT NULL
ORDER BY salary DESC
LIMIT 10;

/* Q10 */
-- Find the first_name, last_name and salary of the lowest paid employee in Hungary.

SELECT
	first_name,
	last_name,
	salary
FROM employees
WHERE (salary IS NOT NULL)
AND (country = 'Hungary')
ORDER BY salary
LIMIT 1;

/* Q11 */
-- How many employees have a first_name beginning with ‘F’?

SELECT
	count(*) AS first_name_beginning_with_f_count
FROM employees
WHERE first_name ILIKE 'F%';

/* Q12 */
-- Find all the details of any employees with a ‘yahoo’ email address?

SELECT *
FROM employees
WHERE email ILIKE '%yahoo%';

/* Q13 */
-- Count the number of pension enrolled employees not based in either France or Germany.

SELECT
	count(*) AS pension_enrolled_count_minus_fr_de
FROM employees
WHERE (country NOT IN ('France', 'Germany'))
AND (pension_enrol = TRUE);

/* Q14 */
-- What is the maximum salary among those employees in the ‘Engineering’ department 
-- who work 1.0 full-time equivalent hours (fte_hours)?

SELECT
	max(salary) AS max_engineering_salary
FROM employees
WHERE (department = 'Engineering')
AND (fte_hours = 1);

/* Q15 */
-- Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), salary, 
-- and a new column effective_yearly_salary which should contain fte_hours multiplied by salary.

SELECT
	first_name,
	last_name,
	fte_hours,
	salary,
	fte_hours * salary AS effective_yearly_salary
FROM employees;