
----------------------------------------------------
		-- DELETING DATABASE IF EXISTS --
----------------------------------------------------

IF exists (select 1 from sys.databases where name='HR_DataWarehouse')
BEGIN
	alter database HR_DataWarehouse set single_user with rollback immediate;
	drop database HR_DataWarehouse;
END;

----------------------------------------------------
			-- CREATING DATABASE --
----------------------------------------------------
CREATE DATABASE HR_DataWarehouse;

