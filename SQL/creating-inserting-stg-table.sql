
-----------------------------------------
	-- DROPPING TABLE IF EXISTS --
-----------------------------------------
DROP TABLE IF EXISTS dbo.STG_HR_EMPLOYEES;

-----------------------------------------
		-- CREATING TABLE --
-----------------------------------------
CREATE TABLE dbo.STG_HR_EMPLOYEES(
	Age int,
	Attrition varchar(10),
	BusinessTravel varchar(50),
	Department varchar(50),
	DistanceFromHome int,
	EducationField varchar(50),
	EmployeeNumber int,
	EnvironmentSatisfaction int,
	Gender varchar(10),
	Joblevel int,
	JobRole varchar(50),
	JobSatisfaction int,
	MaritalStatus varchar(20),
	MonthlyIncome int,
	NumCompaniesWorked int,
	OverTime varchar(10),
	PerformanceRating int,
	RelationshipSatisfaction int,
	TotalWorkingYears int,
	YearsatCompany int
);

-----------------------------------------
	-- BULK INSERTING INTO TABLE --
-----------------------------------------
BULK INSERT dbo.STG_HR_EMPLOYEES
FROM 'C:\Users\User\OneDrive\Desktop\HR-datawarehouse-sql-project\Dataset\HR-EmployeeS-Attrition.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
	TABLOCK
);