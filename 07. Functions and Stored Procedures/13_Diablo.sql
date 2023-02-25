--- Problem 13: *Scalar Function: Cash in User Games Odd Rows
CREATE OR ALTER FUNCTION ufn_CashInUsersGames(@gameName NVARCHAR(250))
RETURNS TABLE AS
RETURN 
(
	SELECT Sum([Cash]) AS SumCash
	FROM 
	(	
		SELECT g.[Name]
		       , ug.[Cash]
			   , ROW_NUMBER() OVER (PARTITION BY g.[Name] ORDER BY ug.Cash DESC) AS RowNumber
		FROM UsersGames AS ug
		JOIN Games AS g
		ON g.Id = ug.GameId
		WHERE g.[Name] = @gameName
	) AS RowNumberSubQuery
	WHERE RowNumber % 2 <> 0
)