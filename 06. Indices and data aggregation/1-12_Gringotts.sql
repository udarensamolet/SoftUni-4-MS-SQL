USE Gringotts
GO

--- Problem 01: Records' Count
SELECT COUNT([Id]) AS [Count]
FROM WizzardDeposits



--- Problem 02: Longest Magic Wand
SELECT MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits



--- Problem 03: Longest Magic Wand Per Deposit Groups
SELECT DepositGroup
	, MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup



--- Problem 04: Smallest Deposit Group Per Magic Wand Size
SELECT TOP(2) DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)



--- Problem 05: Deposits Sum
SELECT DepositGroup
	, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup



--- Problem 06: Deposits Sum for Ollivander Family
SELECT DepositGroup
	, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator LIKE '%Ollivander family%'
GROUP BY DepositGroup 



--- Problem 07: Deposits Filter
SELECT DepositGroup
	, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator LIKE '%Ollivander family%'
GROUP BY DepositGroup 
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC



--- Problem 08: Deposit Charge
SELECT DepositGroup
	, MagicWandCreator
	, MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup



--- Problem 09: Age Groups
SELECT AgeGroup
	, COUNT(*) AS WizzardCount
FROM (
		SELECT Age
		, CASE
			WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
			WHEN Age > 60 THEN '[61+]'
		END AS AgeGroup
		FROM WizzardDeposits
	) AS AgeGroupSub
GROUP BY AgeGroup



--- Problem 10: First Letter
SELECT LEFT(FirstName, 1) AS FirstLetter
FROM WizzardDeposits
GROUP BY LEFT(FirstName, 1), DepositGroup
HAVING DepositGroup = 'Troll Chest'
ORDER BY FirstLetter



--- Problem 11: Average Interest 
SELECT DepositGroup
	, IsDepositExpired
	, AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired ASC



--- Problem 12: Rich Wizard, Poor Wizard
SELECT SUM([Difference])
  FROM (

			SELECT *
				 , [Host Wizard Deposit] - [Guest Wizard Deposit] AS [Difference]
			  FROM (
						  SELECT FirstName AS [Host Wizard]
							   , DepositAmount AS [Host Wizard Deposit]
							   , LEAD(FirstName) OVER (ORDER BY [Id]) AS [Guest Wizard]
							   , LEAD(DepositAmount) OVER (ORDER BY [Id]) AS [Guest Wizard Deposit]
							FROM [WizzardDeposits]
			  ) AS [DepositSubquery]
			 WHERE [Guest Wizard] IS NOT NULL
  ) AS [FilterDepositSubquery]