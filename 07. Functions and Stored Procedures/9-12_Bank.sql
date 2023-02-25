--- Problem 09: Find Full Name
CREATE OR ALTER PROCEDURE usp_GetHoldersFullName 
AS
	SELECT FirstName + ' ' + LastName AS [Full Name]
	FROM AccountHolders
GO

EXEC usp_GetHoldersFullName



--- Problem 10: People with Balance Higher Than
CREATE OR ALTER PROC usp_GetHoldersWithBalanceHigherThan(@balance MONEY)
AS
	SELECT ah.FirstName AS [First Name]
		   , ah.LastName AS [Last Name]
	FROM AccountHolders AS ah
	JOIN Accounts AS a
	ON ah.Id = a.AccountHolderId
	GROUP BY a.AccountHolderId, ah.FirstName, ah.LastName 
	HAVING SUM(a.Balance) > @balance
	ORDER BY ah.FirstName, ah.LastName
GO



--- Problem 11: Future Value Function
CREATE OR ALTER FUNCTION ufn_CalculateFutureValue(
	@sum DECIMAL(18,2)
	, @interestRate FLOAT
	, @numberOfYears INT)
RETURNS DECIMAL(18,4)
AS
BEGIN
	DECLARE @result DECIMAL (18,4)
	SET @result = @sum * (POWER((1 + @interestRate), @numberOfYears))
	RETURN @result
END

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)



--- Problem 12: Calculating Interest
CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount(@accountId INT, @interestRate FLOAT)
AS 
	SELECT ah.Id AS [Account Id]
		   , ah.FirstName AS [First Name]
		   , ah.LastName AS [Last Name]
		   , a.Balance AS [CurrentBalance]
		   , dbo.ufn_CalculateFutureValue(a.Balance, @interestRate, 5) AS [Balance in 5 Years]
	FROM AccountHolders AS ah
	JOIN Accounts AS a
	ON ah.Id = a.AccountHolderId
	WHERE ah.Id = @accountId
GO

EXEC usp_CalculateFutureValueForAccount 1, 0.1