USE Diablo
GO



--- Problem 13: *Scalar Function: Cash in User Games Odd Rows
CREATE OR ALTER FUNCTION [ufn_CashInUsersGames] @gameName VARCHAR(50))

RETURNS TABLE
AS RETURN
(
	SELECT SUM(Cash) AS SumCash
	  FROM (
				SELECT ug.Cash
	                 , ROW_NUMBER() OVER(ORDER BY ug.Cash DESC) AS RowNumber
	              FROM UsersGames AS ug

	              JOIN Games AS g
	                ON ug.GameId = g.Id

	             WHERE g.[Name] = @gameName
	       ) AS RowNumberSubquery

	 WHERE RowNumber % 2 <> 0
)
GO