USE SoftUni



--- Problem 01: Employee Address
SELECT TOP(5) 
	e.EmployeeID as EmployeeId
	, e.JobTitle
	, e.[AddressID] as AddressId
	, a.AddressText
FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID = a.AddressID
ORDER BY e.AddressID



--- Problem 02: Addresses with Towns
SELECT TOP(50)
	e.FirstName
	, e.LastName
	, t.[Name] AS Town
	, a.AddressText
FROM Employees AS e
JOIN  Addresses AS a
ON e.AddressID = a.AddressID
JOIN Towns AS t
ON t.TownID = a.TownID
ORDER BY e.FirstName, e.LastName



--- Problem 03: Sales Employee
SELECT 
	e.EmployeeID
	, e.FirstName
	, e.LastName
	, d.[Name] AS 'DepartmentName'
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE d.[Name] = 'Sales'



--- Problem 04: Employee Departments
SELECT TOP (5)
	e.EmployeeID
	, e.FirstName
	, e.Salary
	, d.[Name] AS 'DepartmentName'
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID



--- Problem 05: Employees Without Project
SELECT TOP(3) 
	e.EmployeeID
	, e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL



--- Problem 06: Employees Hired After
SELECT 
	e.FirstName
	, e.LastName
	, e.HireDate
	, d.[Name] AS DeptName
FROM Employees AS e
LEFT JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE E.HireDate > '1999-01-01'
AND d.[Name] IN ('Sales', 'Finance')



--- PROBLEM 07: Employees with Project
SELECT TOP(5)
	e.EmployeeID
	, e.FirstName
	, p.[Name] AS ProjectName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p
ON p.ProjectID = ep.ProjectID
WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
ORDER BY e.EmployeeID



--- Problem 08: Employee 24
SELECT
	e.EmployeeID
	, e.FirstName
	, IIF ((DATEPART(YEAR, p.StartDate) >= 2005), NULL, p.[Name]) AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON ep.EmployeeID = e.EmployeeID
JOIN Projects AS p
ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24



--- PROBLEM 09: Employee Manager
SELECT 
	e.EmployeeID
	, e.FirstName
	, e.ManagerID
	, m.FirstName AS ManagerName
FROM Employees AS e
JOIN Employees AS m
ON m.EmployeeID=e.ManagerID
WHERE e.ManagerID IN (3,7)
ORDER BY e.EmployeeID

SELECT 
	e.EmployeeID
	, e.FirstName
	, e.ManagerID
	, m.FirstName AS ManagerName
FROM Employees AS e
JOIN Employees AS m
ON m.EmployeeID=e.ManagerID
ORDER BY e.EmployeeID



--- Problem 10: Employees Summary
SELECT TOP(50)
	e.EmployeeID
	, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
	, CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName
	, d.[Name] AS DepartmentName
FROM Employees AS e
JOIN Employees AS m
ON e.ManagerID=m.EmployeeID
JOIN Departments AS d
ON e.DepartmentID=d.DepartmentID
ORDER BY e.EmployeeID



--- Problem 11: Min Average Salary
SELECT TOP(1) 
AVG(Salary) AS 'MinAverageSalary'
FROM Employees
GROUP BY DepartmentID
ORDER BY AVG(Salary)
