use Company;

--Simple Stored procedure creation

CREATE PROCEDURE TEST
AS
SELECT *
FROM employee;

EXEC TEST;

--Stored Procedure with Input values

CREATE PROCEDURE spGetEmployeeByGenderAndSalary
@gender VARCHAR(1),
@salary INT
AS
BEGIN
	SELECT first_name, last_name, gender, salary
	FROM employee
	WHERE gender = @gender AND salary = @salary
END

EXEC spGetEmployeeByGenderAndSalary 'M', 78000

--Modifying Stored Procedure

ALTER PROCEDURE spGetEmployeeByGenderAndSalary
@gender VARCHAR(1),
@branch_id INT
WITH ENCRYPTION
AS
BEGIN
	SELECT first_name, last_name, gender, salary
	FROM employee
	WHERE gender = @gender AND branch_id = @branch_id
END

EXEC spGetEmployeeByGenderAndSalary 'M', 3

--Delete Stored Procedure

DROP PROCEDURE TEST

SP_HELPTEXT spGetEmployeeByGenderAndSalary


--Creating Stored Procedure with Output Values

CREATE PROCEDURE spGetEmployeeCountByGender
@Gender VARCHAR(1),
@EmployeeCount INT OUTPUT
AS
BEGIN
	SELECT @EmployeeCount = COUNT(emp_id)
	FROM employee
	WHERE gender = @Gender
END

DECLARE @TotalCount INT
EXECUTE spGetEmployeeCountByGender 'M', @TotalCount OUTPUT

--EXECUTE spGetEmployeeCountByGender @EmployeeCount = @TotalCount OUT, @Gender = 'F'
--If 'OUT/OUTPUT' is not given, then @TotalCount will become 'NULL'

IF(@TotalCount IS NULL)
	PRINT '@TotalCount is NULL'
ELSE
	PRINT '@TotalCount IS NOT NULL'

PRINT @TotalCount;

SP_HELP spGetEmployeeCountByGender

SP_DEPENDS spGetEmployeeCountByGender

SP_DEPENDS employee




