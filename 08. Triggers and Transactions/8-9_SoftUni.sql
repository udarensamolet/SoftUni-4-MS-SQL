--- Problem 08: Employees with Three Projects
CREATE PROC usp_AssignProject (@EmployeeID INT, @ProjectID INT)
AS
BEGIN
	DECLARE @maxEmployeeProjectsCount INT = 3
	DECLARE @employeeProjectsCount INT
	SET @employeeProjectsCount = (SELECT COUNT(*) 
		FROM EmployeesProjects AS ep
		WHERE ep.EmployeeId = @EmployeeID
	)
	BEGIN TRAN
		INSERT INTO EmployeesProjects (EmployeeID, ProjectID) VALUES (@EmployeeID, @ProjectID)
		
		IF(@employeeProjectsCount >= @maxEmployeeProjectsCount)
		BEGIN
			RAISERROR('The employee has too many projects!', 16, 1)
			ROLLBACK
		END
		ELSE
			COMMIT
END
--END Submission to Judge
GO

EXEC udp_AssignProject 2,1
EXEC udp_AssignProject 2,2
EXEC udp_AssignProject 2,3
BEGIN TRY  
	EXEC udp_AssignProject 2,4
END TRY  
BEGIN CATCH  
	SELECT error_message()
END CATCH;

SELECT COUNT(*) FROM EmployeesProjects WHERE EmployeeId = 2



--- Problem 09: Delete Employee
CREATE TABLE Deleted_Employees(
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[MiddleName] [varchar](50) NULL,
	[JobTitle] [varchar](50) NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[Salary] [money] NOT NULL,
)
GO
CREATE PROC usp_DeleteEmployeesFromDepartment @departmentId INT
AS
     DELETE FROM EmployeesProjects
     WHERE EmployeeID IN
     (
         SELECT EmployeeID
         FROM Employees
         WHERE DepartmentID = @departmentId
     );
     UPDATE Employees
       SET
           ManagerID = NULL
     WHERE ManagerID IN
     (
         SELECT EmployeeId
         FROM Employees
         WHERE DepartmentID = @departmentId
     );
	ALTER TABLE Departments 
ALTER COLUMN ManagerID INT
     UPDATE Departments
       SET
           ManagerID = NULL
     WHERE ManagerID IN
     (
         SELECT EmployeeId
         FROM Employees
         WHERE DepartmentID = @departmentId
     );
     DELETE FROM Employees
     WHERE DepartmentID = @departmentId;
     DELETE FROM dbo.Departments
     WHERE  DepartmentID = @departmentId;

	 SELECT COUNT(*) FROM Employees WHERE DepartmentID = @departmentId
GO
IF OBJECT_ID ('tr_deleted_employees') IS NOT NULL
	DROP TRIGGER tr_deleted_employees
GO
--Start of Submission in Judge
CREATE TRIGGER tr_deleted_employees 
ON Employees FOR DELETE
AS
BEGIN       
     INSERT INTO Deleted_Employees 
	([FirstName],
	[LastName],
	[MiddleName],
	[JobTitle],
	[DepartmentID],
	[Salary]) 
	SELECT [FirstName],
	[LastName],
	[MiddleName],
	[JobTitle],
	[DepartmentID],
	[Salary]
	FROM deleted
END
--End of Submission in Judge

SELECT * FROM employees
WHERE departmentID  = 1
GO
EXEC usp_DeleteEmployeesFromDepartment 1
GO
SELECT * FROM deleted_employees