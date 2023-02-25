--- Problem 01: Employees with Salary Above 35000
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
	SELECT FirstName AS [First Name]
	, LastName AS [Last Name]
	FROM Employees
	WHERE Salary > 35000
GO

EXEC usp_GetEmployeesSalaryAbove35000



--- Problem 02: Employees with Salary Above Number
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber(@Salary DECIMAL(18,4)) 
AS 

	SELECT FirstName AS [First Name]
	, LastName AS [Last Name]
	FROM Employees
	WHERE Salary > @Salary
GO

EXEC usp_GetEmployeesSalaryAboveNumber 48100



--- Problem 03: Town Names Starting With
CREATE PROC usp_GetTownsStartingWith(@StartingLetter NVARCHAR(1))
AS
	SELECT [Name] AS Town
 	FROM Towns
	WHERE LEFT([Name], 1) = @StartingLetter
GO

EXEC usp_GetTownsStartingWith 'b'



--- Problem 04: Employees from Town
CREATE OR ALTER PROC usp_GetEmployeesFromTown(@TownName NVARCHAR(50))
AS
	SELECT e.FirstName AS [First Name]
		   , e.LastName AS [Last Name]
	FROM Employees as e
	JOIN Addresses as a
	ON a.AddressID = e.AddressID
	JOIN Towns as t
	ON t.TownID = a.TownID
	WHERE t.[Name] = @TownName
GO

EXEC usp_GetEmployeesFromTown 'Sofia'



--- Problem 05: Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @SalaryLevel NVARCHAR(10)
	IF(@salary < 30000)
	BEGIN
		SET @SalaryLevel = 'Low'
	END
	ELSE IF(@salary >= 30000 AND @salary <= 50000)
	BEGIN
		SET @SalaryLevel = 'Average'
	END
	ELSE IF (@salary > 50000)
	BEGIN
		SET @SalaryLevel = 'High'
	END
	RETURN @SalaryLevel
END

SELECT Salary
	   , dbo.ufn_GetSalaryLevel(Salary) AS SalaryLevel
FROM Employees



--- Problem 06: Employees by Salary Level
CREATE OR ALTER PROC usp_EmployeesBySalaryLevel(@SalaryLevel NVARCHAR(10))
AS
	SELECT FirstName as [First Name]
		   , LastName as [Last Name]
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @SalaryLevel
GO

EXEC usp_EmployeesBySalaryLevel 'High'



--- Problem 07: Define Function
CREATE OR ALTER FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(250), @word NVARCHAR(250))
RETURNS BIT
AS
BEGIN
	DECLARE @i INT = 1

	WHILE @i < LEN(@word)
		DECLARE @currentLetter CHAR(1) = LOWER(SUBSTRING(@word, @i, 1))
		IF CHARINDEX(@currentLetter, @setOfLetters) = 0
			RETURN 0
		SET @i += 1
	RETURN 1
END
GO

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')



--- Problem 08: Delete Employees and Departments
CREATE OR ALTER PROC DeleteEmployeesFromDepartment (@departmentId INT) 
AS 
	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN 
	(
		SELECT EmployeeID
		FROM Employees
		WHERE DepartmentID = @departmentId
	)
	
	UPDATE Employees
	SET ManagerID = NULL
	WHERE EmployeeID IN
	(
		SELECT EmployeeID
		FROM Employees
		WHERE DepartmentID = @departmentId
	)

	ALTER TABLE Departments
	ALTER COLUMN ManagerId INT NULL

	UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN
	(
		SELECT EmployeeId
		FROM Employees
		WHERE DepartmentID = @departmentId
	)

	DELETE FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId

	SELECT COUNT(*)
	FROM Employees
	WHERE DepartmentID = @departmentId




