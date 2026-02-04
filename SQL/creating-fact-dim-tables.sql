----------------------------------------------
		-- CREATING DIAMENSION TABLES --
----------------------------------------------

-- Employees Table
DROP TABLE IF EXISTS dbo.DIM_EMPLOYEES;
CREATE TABLE dbo.DIM_EMPLOYEES(
	Employee_key int identity primary key,
	employee_number int,
	Gender varchar(20),
	Age int,
	Marital_Status varchar(20)
	)

-- Department Table
DROP TABLE IF EXISTS dbo.DIM_DEPARTMENT;
CREATE TABLE dbo.DIM_DEPARTMENT(
	Department_key int identity primary key,
	Department_Name varchar(30)
	)

-- Job Table
DROP TABLE IF EXISTS dbo.DIM_JOB;
CREATE TABLE dbo.DIM_JOB(
	Job_key int identity primary key,
	Job_role varchar(30),
	Job_level int
	)

-- Education Table
DROP TABLE IF EXISTS dbo.DIM_EDUCATION;
CREATE TABLE dbo.DIM_EDUCATION(
	Education_key int identity primary key,
	Education_field varchar(30)
	)


----------------------------------------------
		-- CREATING FACT TABLE --
----------------------------------------------
DROP TABLE IF EXISTS dbo.FACT_EMPLOYEE_ANALYTICS;
CREATE TABLE dbo.FACT_EMPLOYEE_ANALYTICS(
	Fact_key int identity primary key,
	Employee_key int,
	Department_key int,
	Job_key int,
	Education_key int,
	Monthly_income decimal(10,2),
	Total_Working_Years int,
	Years_at_company int,
	number_companies_worked int,
	Overtime int,
	Attrition_flag int,
	Distance_from_home int,
	Performance_rating int,
	Job_satisfaction int,
	Relationship_satisfaction int,
	Envirnoment_satisfaction int

	FOREIGN KEY (Employee_key) REFERENCES DIM_EMPLOYEES(Employee_key),
    FOREIGN KEY (Department_key) REFERENCES DIM_DEPARTMENT(Department_key),
    FOREIGN KEY (Job_key) REFERENCES DIM_JOB(Job_key),
    FOREIGN KEY (Education_key) REFERENCES DIM_EDUCATION(Education_key)
	)