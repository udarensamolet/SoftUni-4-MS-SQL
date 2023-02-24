USE SoftUni
GO 



--- Problem 13: Departments Total Salaries
SELECT DepartmentID
	, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID



--- Problem 14: Employees Minimum Salaries
SELECT DepartmentID
	, MIN(Salary) AS TotalSalary
FROM Employees
WHERE HireDate > 01/01/2000
GROUP BY DepartmentID
HAVING DepartmentID IN (2, 5, 7) 



--- Problem 15: Employees Average Salaries
SELECT * 
INTO TempTable
FROM Employees
WHERE (Salary > 30000)

DELETE FROM TempTable
WHERE ManagerID = 42

UPDATE Employees
SET Salary += 5000
WHERE DepartmentID = 1 

SELECT DepartmentID
	, AVG(Salary) AS AverageSalary
FROM TempTable
GROUP BY DepartmentID



--- Problem 16: Employees Maximum Salaries
SELECT DepartmentID
	, MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000



--- Problem 17: Employees Count Salaries
SELECT COUNT(EmployeeID)
FROM Employees
WHERE ManagerID IS NULL



--- Problem 18: *3rd Highest Salary
SELECT DISTINCT 
       DepartmentID
     , Salary AS [ThirdHighestSalary] 
FROM (

      SELECT DepartmentId
	       , Salary
           , DENSE_RANK() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS [Rank]
        FROM Employees
     ) AS RankSubquery
 WHERE [Rank] = 3



 --- Problem 19: **Salary Challenge
 SELECT TOP 10 FirstName
	, LastName
	, DepartmentID
 FROM Employees AS e
 WHERE Salary > (SELECT AVG(Salary)
				 FROM Employees
				 WHERE e.DepartmentID = DepartmentID
				 GROUP BY DepartmentID
				 )





