
-- Validation Chechking
SELECT 
	COUNT(*) AS NUM_OF_ROWS
FROM STG_HR_EMPLOYEES;

SELECT 
	COUNT(*) AS NUM_OF_ROWS
FROM FACT_EMPLOYEE_ANALYTICS;


-- Job vise Average Monthly Income
SELECT
	J.Job_role,
	ROUND(AVG(f.Monthly_income),2) AS AVG_MONTHLY_INCOME
FROM FACT_EMPLOYEE_ANALYTICS AS f
JOIN DIM_JOB j
ON f.Job_key = j.Job_key
GROUP BY J.Job_role;


-- Department vise Total Employees and Total Attritions
SELECT
	Department_Name,
	Total_Employees,
	Total_Attrition,
	Total_Attrition * 100 / Total_Employees AS Attrition_Percentage
FROM
(SELECT
	d.Department_Name,
	COUNT(f.Employee_key) AS Total_Employees,
	SUM(f.Attrition_flag) AS Total_Attrition
FROM FACT_EMPLOYEE_ANALYTICS AS f
JOIN DIM_DEPARTMENT AS d
ON f.Department_key = d.Department_key
GROUP BY d.Department_Name)t


-- Job, Relationship, Environment satisfaction vise Total Attritions
SELECT
	Job_satisfaction,
	Relationship_satisfaction,
	Envirnoment_satisfaction,
	SUM(Attrition_flag) AS Total_Attrition
FROM FACT_EMPLOYEE_ANALYTICS
GROUP BY 
	Job_satisfaction,
	Relationship_satisfaction,
	Envirnoment_satisfaction
ORDER BY 
	Job_satisfaction,
	Relationship_satisfaction,
	Envirnoment_satisfaction;


-- Number of Employees can do Overtime and can't do Overtime in Each Department
SELECT
	d.Department_Name,
	f.Overtime,
	COUNT(f.Employee_key) AS Total_Employees
FROM FACT_EMPLOYEE_ANALYTICS AS f
JOIN DIM_DEPARTMENT AS d
ON f.Department_key = d.Department_key
GROUP BY 
	d.Department_Name,
	f.Overtime;


-- Top 5 Highest Experienced Candidates Maximum and Minimum salary
SELECT
	TOP 5 Total_Working_Years AS Total_Experience_Years,
	ROUND(MAX(Monthly_income), 2) AS Maximum_Income,
	ROUND(MIN(Monthly_income), 2) AS Minimum_Income
FROM FACT_EMPLOYEE_ANALYTICS
GROUP BY Total_Working_Years
ORDER BY Total_Working_Years DESC, ROUND(MAX(Monthly_income), 2) DESC;


-- Top 5 Lowest Experienced Candidates Maximum and Minimum salary
SELECT
	TOP 5 Total_Working_Years AS Total_Experience_Years,
	ROUND(MAX(Monthly_income), 2) AS Maximum_Income,
	ROUND(MIN(Monthly_income), 2) AS Minimum_Income
FROM FACT_EMPLOYEE_ANALYTICS
GROUP BY Total_Working_Years
ORDER BY Total_Working_Years;


-- Rank based on Monthly Income to a Job
SELECT
	j.Job_role,
	f.Monthly_income,
	RANK() OVER(PARTITION BY j.Job_role ORDER BY f.Monthly_income DESC) AS Salary_Rank
FROM FACT_EMPLOYEE_ANALYTICS AS f
JOIN DIM_JOB AS j
ON f.Job_key = j.Job_key


-- Performance Rating vise Total Employees and Total Attritions
SELECT
	Performance_rating,
	COUNT(Employee_key) AS Total_Employees,
	SUM(Attrition_flag) AS Total_Attrition
FROM FACT_EMPLOYEE_ANALYTICS
GROUP BY Performance_rating;


-- Distance vise Total Employees
SELECT
	Distance_Emplyee,
	COUNT(Employee_key) AS Total_Employees
FROM
	(SELECT
		CASE
			WHEN Distance_from_home <= 10 THEN 'Nearby_Employees'
			ELSE 'Far_Employees'
		END AS Distance_Emplyee,
		Employee_key
	FROM FACT_EMPLOYEE_ANALYTICS)t
GROUP BY Distance_Emplyee;


-- Department vise Total Unique Jobs
SELECT
	d.Department_Name,
	COUNT(DISTINCT j.Job_role) AS Total_Jobs
FROM FACT_EMPLOYEE_ANALYTICS AS f
JOIN DIM_DEPARTMENT AS d
ON f.Department_key = d.Department_key
JOIN DIM_JOB AS j
ON f.Job_key = j.Job_key
GROUP BY d.Department_Name;
