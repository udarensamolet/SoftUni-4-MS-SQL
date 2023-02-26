--- Problem 06: Trigger
CREATE TRIGGER tr_UserGameItems on UserGameItems
INSTEAD OF INSERT
AS
	INSERT INTO UserGameItems
	SELECT ItemId, UserGameId
	FROM inserted
	WHERE
		ItemId IN (
			SELECT Id 
			FROM Items 
			WHERE MinLevel <= (
				SELECT [Level]
				FROM UsersGames 
				WHERE Id = UserGameId
			)
		)
GO

-- Add bonus cash for users
UPDATE UsersGames
SET Cash = Cash + 50000 + (SELECT SUM(i.Price) FROM Items i JOIN UserGameItems ugi ON ugi.ItemId = i.Id WHERE ugi.UserGameId = UsersGames.Id)
WHERE UserId IN (
	SELECT Id 
	FROM Users 
	WHERE Username IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
)
AND GameId = (SELECT Id FROM Games WHERE Name = 'Bali')

-- Buy items for users
INSERT INTO UserGameItems (UserGameId, ItemId)
SELECT  UsersGames.Id, i.Id 
FROM UsersGames, Items i
WHERE UserId in (
	SELECT Id 
	FROM Users 
	WHERE Username IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
) AND GameId = (SELECT Id FROM Games WHERE Name = 'Bali' ) AND ((i.Id > 250 AND i.Id < 300) OR (i.Id > 500 AND i.Id < 540))


-- Get cash from users
UPDATE UsersGames
SET Cash = Cash - (SELECT SUM(i.Price) FROM Items i JOIN UserGameItems ugi ON ugi.ItemId = i.Id WHERE ugi.UserGameId = UsersGames.Id)
WHERE UserId IN (
	SELECT Id 
	FROM Users 
	WHERE Username IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
)
AND GameId = (SELECT Id FROM Games where Name = 'Bali')


SELECT u.Username, g.Name, ug.Cash, i.Name [Item Name] FROM UsersGames ug
JOIN Games g ON ug.GameId = g.Id
JOIN Users u ON ug.UserId = u.Id
JOIN UserGameItems ugi ON ugi.UserGameId = ug.Id
JOIN Items i ON i.Id = ugi.ItemId
WHERE g.Name = 'Bali'
ORDER BY Username, [Item Name]
	


--- Problem 07: Massive Shopping
BEGIN TRANSACTION [Tran1]

BEGIN TRY
	UPDATE 
		UsersGames 
	SET 
		Cash = Cash - (
			SELECT SUM(Price) FROM Items WHERE MinLevel BETWEEN 11 AND 12
		) 
	WHERE Id = 110

	INSERT INTO UserGameItems (UserGameId, ItemId)
	SELECT 110, Id FROM Items WHERE MinLevel BETWEEN 11 AND 12

COMMIT TRANSACTION [Tran1]

END TRY
BEGIN CATCH
  ROLLBACK TRANSACTION [Tran1]
END CATCH 
GO

BEGIN TRANSACTION [Tran2]

BEGIN TRY
	UPDATE 
		UsersGames 
	SET 
		Cash = Cash - (
			SELECT SUM(Price) FROM Items WHERE MinLevel BETWEEN 19 AND 21
		) 
	WHERE Id = 110

	INSERT INTO UserGameItems (UserGameId, ItemId)
	SELECT 110, Id FROM Items WHERE MinLevel BETWEEN 19 AND 21

COMMIT TRANSACTION [Tran2]
END TRY
BEGIN CATCH
  ROLLBACK TRANSACTION [Tran2]
END CATCH
GO

SELECT Items.Name [Item Name] 
FROM Items 
INNER JOIN UserGameItems ON Items.Id = UserGameItems.ItemId 
WHERE UserGameId = 110 
ORDER BY [Item Name]