USE Bank
GO



--- Problem 09: Find Full Name
ALTER PROC usp_GetHoldersFullName 
AS
	SELECT CONCAT(FirstName, ' ', LastName)
	FROM AccountHolders
GO



--- Problem 10: People with Balance Higher Than
CREATE PROC usp_GetHoldersWithBalanceHigherThan(@checkAmount DECIMAL)
AS
	SELECT 
		ah.FirstName
		, ah.LastName
	FROM Accounts AS a
	JOIN AccountHolders AS ah
	ON a.Id=ah.Id
	GROUP BY(a.Id)
	HAVING SUM(a.Balance) > 100
EXEC usp_GetHoldersWithBalanceHigherThan 2000
GO



--- Problem 11: Future Value Function
CREATE FUNCTION ufn_CalculateFutureValue (@Sum DECIMAL, @YearlyInterestRate FLOAT, @NumberOfYears INT)
RETURNS DECIMAL(4,2)
AS
BEGIN
	DECLARE @Result DECIMAL(4,2);
	SET @Result = @Sum * POWER((1 + @YearlyInterestRate), @NumberOfYears)
	RETURN @Result
END
GO



--- Problem 12: Calculating Interest
CREATE PROC usp_CalculateFutureValueForAccount @accID INT, @rate FLOAT
AS
BEGIN
	SELECT ah.Id AS [Account Id]
	     , ah.FirstName AS [First Name]
		 , ah.LastName AS [Last Name]
		 , a.Balance AS [Current Balance]
		 , dbo.ufn_CalculateFutureValue(a.Balance, @rate, 5) AS [Balance in 5 years]
	  FROM AccountHolders AS ah

	  JOIN Accounts AS a
	    ON ah.Id = a.AccountHolderId

	 WHERE a.Id = @accID
END