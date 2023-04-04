/* MVP */

/* Q1a */
-- Find the first name, last name and team name of employees who are members of teams.

SELECT
	e.first_name AS employee_first_name,
	e.last_name AS employee_last_name,
	t.name AS team_name
FROM employees AS e INNER JOIN teams AS t ON e.team_id = t.id;

/* Q1b */
-- Find the first name, last name and team name of employees who are members of teams and are enrolled in the pension scheme.

SELECT
	e.first_name AS employee_first_name,
	e.last_name AS employee_last_name,
	t.name AS team_name,
	e.pension_enrol AS pension_enrolled
FROM employees AS e INNER JOIN teams AS t ON e.team_id = t.id
WHERE e.pension_enrol = TRUE;

/* Q1c */
-- Find the first name, last name and team name of employees who are members of teams, where their team has a charge cost greater than 80.

SELECT
	e.first_name AS employee_first_name,
	e.last_name AS employee_last_name,
	t.name AS team_name,
	e.pension_enrol AS pension_enrolled,
	t.charge_cost AS team_charge_cost
FROM employees AS e INNER JOIN teams AS t ON e.team_id = t.id
WHERE CAST(t.charge_cost AS int) > 80;

/* Q2a */
-- Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them.

SELECT
	e.*,
	pd.local_account_no AS local_account_number,
	pd.local_sort_code AS local_sort_code
FROM employees AS e LEFT JOIN pay_details AS pd ON e.pay_detail_id = pd.id;

/* Q2b */
-- Amend your query above to also return the name of the team that each employee belongs to.

SELECT
	e.*,
	pd.local_account_no AS local_account_number,
	pd.local_sort_code AS local_sort_code,
	t.name AS team_name
FROM 
	(employees AS e LEFT JOIN pay_details AS pd ON e.pay_detail_id = pd.id)
	LEFT JOIN teams AS t ON t.id = e.team_id;

/* Q3a */
-- Make a table, which has each employee id along with the team that employee belongs to.

SELECT
	e.id AS employee_id,
	t.name AS team_name
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id;

/* Q3b */
-- Breakdown the number of employees in each of the teams.

SELECT
	t.name AS team_name,
	count(e.id) AS number_of_employees
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id
GROUP BY t.name;

/* Q3c */
-- Order the table above by so that the teams with the least employees come first.

SELECT
	t.name AS team_name,
	count(e.id) AS number_of_employees
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id
GROUP BY t.name
ORDER BY number_of_employees;

/* Q4a */
-- Create a table with the team id, team name and the count of the number of employees in each team.

SELECT
	t.id AS team_id,
	t.name AS team_name,
	count(e.id)
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id
GROUP BY t.id;
	
/* Q4b */
-- The total_day_charge of a team is defined as the charge_cost of the team multiplied by the number of employees in the team. 
-- Calculate the total_day_charge for each team.

SELECT
	t.id AS team_id,
	t.name AS team_name,
	count(e.id) AS number_of_employees,
	t.charge_cost AS team_charge_cost,
	count(e.id) * CAST(t.charge_cost AS int) AS total_day_charge
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id
GROUP BY t.id;

/* Q4c */
-- How would you amend your query from above to show only those teams with a total_day_charge greater than 5000?

SELECT
	t.id AS team_id,
	t.name AS team_name,
	count(e.id) AS number_of_employees,
	t.charge_cost AS team_charge_cost,
	count(e.id) * CAST(t.charge_cost AS int) AS total_day_charge
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id
GROUP BY t.id
HAVING 5000 < count(e.id) * CAST(t.charge_cost AS int);

/* Extension */

/* Q5 */
-- How many of the employees serve on one or more committees?

SELECT
	count(DISTINCT(employees_committees.employee_id))
FROM employees_committees;

/* Q6 */
-- How many of the employees do not serve on a committee?

SELECT * 
FROM employees LEFT JOIN employees_committees ON employees.id = employees_committees.employee_id
WHERE employees_committees.employee_id IS NULL;




