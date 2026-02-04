
CREATE OR ALTER PROCEDURE LOAD_DIAMENSIONS AS
BEGIN
    BEGIN TRY
        ----------------------------------------------
	        -- INSERTING INTO DIAMENSION TABLES --
        ----------------------------------------------

        -- Eployee Table
        TRUNCATE TABLE DIM_EMPLOYEES
        INSERT INTO DIM_EMPLOYEES
        (employee_number, Gender, Age, Marital_Status)

        SELECT 
	        DISTINCT EmployeeNumber, Gender, Age, MaritalStatus
        FROM STG_HR_EMPLOYEES;

        -- Department Table
        TRUNCATE TABLE DIM_DEPARTMENT
        INSERT INTO DIM_DEPARTMENT
        (department_name)

        SELECT 
	        DISTINCT Department
        FROM STG_HR_EMPLOYEES;

        -- Job Table
        TRUNCATE TABLE DIM_JOB
        INSERT INTO DIM_JOB 
        (job_role, job_level)
        SELECT 
	        DISTINCT JobRole, JobLevel
        FROM STG_HR_EMPLOYEES;

        -- Eduaction Table
        TRUNCATE TABLE DIM_EDUCATION
        INSERT INTO DIM_EDUCATION 
        (education_field)

        SELECT 
	        DISTINCT EducationField
        FROM STG_HR_EMPLOYEES;
    END TRY
    BEGIN CATCH
    	print '===================================='
		print 'ERROR OCCCURED DURING THE LOADING THE BRONZE LAYER'
		Print 'ERROR MESSAGE:'+Error_message();
		print 'ERROR NUMBER:'+cast(Error_number() as nvarchar);
		print 'ERROR STATE:'+cast(error_state() as nvarchar);
		print '===================================='
    END CATCH
END

GO

CREATE OR ALTER PROCEDURE LOAD_FACT AS
BEGIN
    BEGIN TRY
        ----------------------------------------------
	        -- INSERTING INTO FACT TABLE --
        ----------------------------------------------
        TRUNCATE TABLE FACT_EMPLOYEE_ANALYTICS
        INSERT INTO FACT_EMPLOYEE_ANALYTICS
        SELECT
            e.employee_key,
            d.department_key,
            j.job_key,
            ed.education_key,
            s.MonthlyIncome,
            s.TotalWorkingYears,
            s.YearsAtCompany,
            s.NumCompaniesWorked,
            CASE
                WHEN s.OverTime = 'Yes' THEN 1
                ELSE 0
            END,
            CASE 
                WHEN s.Attrition = 'Yes' THEN 1 
                ELSE 0 
            END,
            s.DistanceFromHome,
            s.PerformanceRating,
            s.JobSatisfaction,
            s.RelationshipSatisfaction,
            s.EnvironmentSatisfaction
        FROM STG_HR_EMPLOYEES s
        JOIN DIM_EMPLOYEES e ON s.EmployeeNumber = e.employee_number
        JOIN DIM_DEPARTMENT d ON s.Department = d.department_name
        JOIN DIM_JOB j ON s.JobRole = j.job_role AND s.JobLevel = j.job_level
        JOIN DIM_EDUCATION ed ON s.EducationField = ed.education_field
    END TRY
    BEGIN CATCH
        print '===================================='
		print 'ERROR OCCCURED DURING THE LOADING THE BRONZE LAYER'
		Print 'ERROR MESSAGE:'+Error_message();
		print 'ERROR NUMBER:'+cast(Error_number() as nvarchar);
		print 'ERROR STATE:'+cast(error_state() as nvarchar);
		print '===================================='
    END CATCH
END
