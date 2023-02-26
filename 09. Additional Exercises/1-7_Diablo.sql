--- Problem 01: Number of Users for Email Provider
SELECT
	SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email)) as [Email Provider],
	COUNT(Username) [Number Of Users]
FROM Users
GROUP BY SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email))
ORDER BY COUNT(Username) DESC, [Email Provider]



--- Problem 02: All User in Games
SELECT 
	g.[Name] AS Game
	, gt.[Name] AS [Game Type]
	, u.Username
	, ug.[Level]
	, ug.Cash
	, c.[Name] AS [Character]
FROM UsersGames AS ug
JOIN Games AS g
ON ug.GameId = g.Id
JOIN GameTypes AS gt
ON gt.Id = g.GameTypeId
JOIN Users AS u
ON u.Id = ug.UserId
JOIN Characters AS c
ON c.Id = ug.CharacterId
ORDER BY ug.[Level] DESC, u.Username ASC, g.[Name] ASC



--- Problem 03: Users in Games with Their Items
SELECT 
	u.Username
	, g.[Name] AS Game
	, COUNT(i.Id) AS [Items Count]
	, SUM(i.Price) AS [Items Price]
FROM Users AS u
JOIN UsersGames AS ug
ON u.Id = ug.UserId
JOIN Games AS g
ON ug.GameId = g.Id
JOIN UserGameItems AS ugi
ON ug.Id = ugi.UserGameId
JOIN Items AS i
ON i.Id = ugi.ItemId
GROUP BY u.Username, g.[Name]
HAVING COUNT(i.Id) >= 10
ORDER BY [Items Count] DESC, [Items Price] DESC, u.Username ASC



--- Problem 04: User in Games with Their Statistics
SELECT 
	u.Username
	, g.[Name] AS Game
	, c.[Name] AS [Character]
	, SUM([is].Strength) + MAX(cs.Strength)+ MAX(gts.Strength) AS Strength
	, SUM([is].Defence) + MAX(cs.Defence) + MAX(gts.Defence) AS Defence
	, SUM([is].Speed) + MAX(cs.Speed) + MAX(gts.Speed) AS Speed
	, SUM([is].Mind) + MAX(cs.Mind) + MAX(gts.Mind) AS Mind
	, SUM([is].Luck) + MAX(cs.Luck) + MAX(gts.Luck) AS Luck
FROM Users AS u
JOIN UsersGames AS ug ON ug.UserId = u.Id
JOIN Games AS g ON ug.GameId = g.Id
JOIN GameTypes AS gt ON gt.Id = g.GameTypeId
JOIN [Statistics] AS gts ON gts.Id = gt.BonusStatsId
JOIN Characters AS c ON ug.CharacterId = c.Id
JOIN [Statistics] AS cs ON cs.Id = c.StatisticId
JOIN UserGameItems AS ugi ON ugi.UserGameId = ug.Id
JOIN Items AS i ON i.Id = ugi.ItemId
JOIN [Statistics] AS [is] ON [is].Id = i.StatisticId
GROUP BY u.Username, g.[Name], c.[Name]
ORDER BY Strength DESC, Defence DESC, Speed DESC, Mind DESC, Luck DESC



--- Problem 05: All Items with Greater than Average Statistics
SELECT
	i.[Name]
	, i.Price
	, i.MinLevel
	, s.Strength
	, s.Defence
	, s.Speed
	, s.Luck
	, s.Mind
FROM Items AS i
JOIN [Statistics] AS s ON i.StatisticId = s.Id
WHERE s.Mind > (
				 SELECT AVG(s.Mind) FROM Items AS i
				 JOIN [Statistics] AS s ON i.StatisticId = s.Id
) AND s.Luck > (
				 SELECT AVG(s.Luck) FROM Items AS i
				 JOIN [Statistics] AS s ON i.StatisticId = s.Id
) AND s.Speed > (
				 SELECT AVG(s.Speed) FROM Items AS i
				 JOIN [Statistics] AS s ON i.StatisticId = s.Id
)
ORDER BY i.[Name]



--- Problem 06: Display All Items with Information about Forbidden Game Type
SELECT 
	i.[Name] AS Item
	, i.Price 
	, i.MinLevel
	, gt.[Name] AS [Forbidden Game Type]
FROM Items AS i
JOIN GameTypeForbiddenItems AS gtfi ON i.Id = gtfi.ItemId
JOIN GameTypes AS gt ON gtfi.GameTypeId = gt.Id
ORDER BY [Forbidden Game Type] DESC, i.[Name] ASC



--- Problem 07: Buy Items for User in Game
INSERT INTO UserGameItems(ItemId, UserGameId)
VALUES 
	(
		(SELECT Id FROM Items WHERE Name = 'Blackguard'), 
		(SELECT ug.Id FROM UsersGames ug 
			JOIN Users u ON u.Id = ug.UserId
			JOIN Games g ON g.Id = ug.GameId
			WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')
	)

UPDATE UsersGames
SET Cash = Cash - (SELECT Price FROM Items WHERE Name = 'Blackguard')
WHERE Id = (SELECT ug.Id FROM UsersGames ug 
			JOIN Users u ON u.Id = ug.UserId
			JOIN Games g ON g.Id = ug.GameId
			WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')

INSERT INTO UserGameItems(ItemId, UserGameId)
VALUES 
	(
		(SELECT Id FROM Items WHERE Name = 'Bottomless Potion of Amplification'), 
		(SELECT ug.Id FROM UsersGames ug 
			JOIN Users u ON u.Id = ug.UserId
			JOIN Games g ON g.Id = ug.GameId
			WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')
	)

UPDATE UsersGames
SET Cash = Cash - (SELECT Price FROM Items WHERE Name = 'Bottomless Potion of Amplification')
WHERE Id = (SELECT ug.Id FROM UsersGames ug 
	JOIN Users u ON u.Id = ug.UserId
	JOIN Games g ON g.Id = ug.GameId
	WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')

INSERT INTO UserGameItems(ItemId, UserGameId)
VALUES (
		(SELECT Id FROM Items WHERE Name = 'Eye of Etlich (Diablo III)'), 
		(SELECT ug.Id FROM UsersGames ug 
			JOIN Users u ON u.Id = ug.UserId
			JOIN Games g ON g.Id = ug.GameId
			WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')
	)

UPDATE UsersGames
SET Cash = Cash - (SELECT Price FROM Items WHERE Name = 'Eye of Etlich (Diablo III)')
WHERE Id = (SELECT ug.Id FROM UsersGames ug 
	JOIN Users u on u.Id = ug.UserId
	JOIN Games g on g.Id = ug.GameId
	WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')

INSERT INTO UserGameItems(ItemId, UserGameId)
VALUES (
		(SELECT Id FROM Items WHERE Name = 'Gem of Efficacious Toxin'), 
		(SELECT ug.Id FROM UsersGames ug 
			JOIN Users u ON u.Id = ug.UserId
			JOIN Games g ON g.Id = ug.GameId
			WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')
	)

UPDATE UsersGames
SET Cash = Cash - (SELECT Price FROM Items WHERE Name = 'Gem of Efficacious Toxin')
WHERE Id = (SELECT ug.Id FROM UsersGames ug 
	JOIN Users u ON u.Id = ug.UserId
	JOIN Games g ON g.Id = ug.GameId
	WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')

INSERT INTO UserGameItems(ItemId, UserGameId)
VALUES (
		(SELECT Id FROM Items WHERE Name = 'Golden Gorget of Leoric'), 
		(SELECT ug.Id FROM UsersGames ug 
			JOIN Users u ON u.Id = ug.UserId
			JOIN Games g ON g.Id = ug.GameId
			WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')
	)

UPDATE UsersGames
SET Cash = Cash - (SELECT Price FROM Items WHERE Name = 'Golden Gorget of Leoric')
WHERE Id = (SELECT ug.Id FROM UsersGames ug 
	JOIN Users u ON u.Id = ug.UserId
	JOIN Games g ON g.Id = ug.GameId
	WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')

	
INSERT INTO UserGameItems(ItemId, UserGameId)
VALUES (
		(SELECT Id FROM Items WHERE Name = 'Hellfire Amulet'), 
		(SELECT ug.Id FROM UsersGames ug 
			JOIN Users u ON u.Id = ug.UserId
			JOIN Games g ON g.Id = ug.GameId
			WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')
	)

UPDATE UsersGames
SET Cash = Cash - (SELECT Price FROM Items WHERE Name = 'Hellfire Amulet')
WHERE Id = (SELECT ug.Id FROM UsersGames ug 
	JOIN Users u ON u.Id = ug.UserId
	JOIN Games g ON g.Id = ug.GameId
	WHERE u.Username = 'Alex' AND g.Name = 'Edinburgh')

SELECT u.Username, g.Name, ug.Cash, i.Name [Item Name] from UsersGames ug
JOIN Games g ON ug.GameId = g.Id
JOIN Users u ON ug.UserId = u.Id
JOIN UserGameItems ugi ON ugi.UserGameId = ug.Id
JOIN Items i ON i.Id = ugi.ItemId
WHERE g.Name = 'Edinburgh'
ORDER BY i.Name