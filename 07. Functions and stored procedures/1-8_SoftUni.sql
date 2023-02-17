--- Problem 01: Employees with Salary Above 35000
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
	SELECT 
		FirstName
		, LastName
	FROM Employees
	WHERE Salary > 35000
GO



--- Problem 02: Employees with Salary Above Number
CREATE PROC usp_GetEmployeesSalaryAboveNumber(@limit DECIMAL(18,4))
AS
	SELECT
		FirstName
		, LastName
	FROM Employees
	WHERE Salary > @limit
GO



--- Problem 03: own Names Starting With
CREATE PROC usp_GetTownsStartingWith(@TownNames NVARCHAR(100))
AS
	SELECT
		[Name]
	FROM Towns
	WHERE CHARINDEX(@TownNames, [Name]) != NULL
GO



--- Problem 04: Employees from Town
CREATE PROC usp_GetEmployeesFromTown(@TownName NVARCHAR(100))
AS
	SELECT 
		e.FirstName
		, e.LastName
	FROM Employees AS e
	LEFT JOIN Addresses AS a
	ON e.AddressID=a.AddressID
	LEFT JOIN Towns AS t
	ON a.AddressID=t.TownID
	WHERE t.[Name] = @TownName
GO



--- Problem 05: Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel(@Salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @SalaryLevel NVARCHAR(10)
	IF(@Salary < 30000)
	BEGIN
		SET @SalaryLevel = 'Low'
	END
	ELSE IF (@Salary BETWEEN 30000 AND 50000)
	BEGIN 
		SET @SalaryLevel = 'Average'
	END
	ELSE IF (@Salary > 50000)
	BEGIN
		SET @SalaryLevel = 'High'
	END
	RETURN @SalaryLevel
END




--- Problem 06: Employees by Salary Level
CREATE PROC usp_EmployeesBySalaryLevel(@LevelOfSalary NVARCHAR(10))
AS
	SELECT 
		FirstName
		, LastName
	FROM Employees
	WHERE ufn_GetSalaryLevel(Salary) = @LevelOfSalary 
GO



--- Problem 07: Define Function
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(10), @word NVARCHAR(10)) 
RETURNS BIT
AS
BEGIN 
	DECLARE @result BIT, @index SMALLINT, @currentChar NVARCHAR(1)
	SET @index=1

	WHILE (@index <= LEN(@word))
	BEGIN
		SET @currentChar = SUBSTRING(@word, @index, 1)
		IF (CHARINDEX(@currentChar, @setOfLetters) = 0)
			RETURN @result;
		SET @index += 1;
	END
	RETURN @result +1;
END
GO



--- Problem 08: Delete Employees and Departments
CREATE OR ALTER PROC [usp_DeleteEmployeesFromDepartment]
                     @departmentId INT
AS
BEGIN
	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NULL

	 DELETE FROM EmployeesProjects
           WHERE EmployeeID IN (
		                          SELECT EmployeeID 
								    FROM Employees 
								   WHERE DepartmentID = @departmentId
								 )
	UPDATE Employees
	   SET ManagerID = NULL
	 WHERE EmployeeID IN (
		                   SELECT [EmployeeID] 
						     FROM [Employees] 
						    WHERE [DepartmentID] = @departmentId
						  )
	UPDATE Employees
	   SET ManagerID = NULL
	 WHERE ManagerID IN (
		                   SELECT EmployeeID
						     FROM Employees
						    WHERE DepartmentID = @departmentId
						  )

	UPDATE Departments
	   SET ManagerID = NULL
	 WHERE ManagerID IN (
		                   SELECT EmployeeID
						     FROM Employees
						    WHERE DepartmentID = @departmentId
						  )
	DELETE FROM Employees
          WHERE DepartmentID = @departmentId

	DELETE FROM Departments
          WHERE DepartmentID = @departmentId

	SELECT COUNT(*) 
      FROM [Employees]
     WHERE [DepartmentID] = @departmentId
END
GO



