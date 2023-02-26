--- Problem 08: Peaks and Mountains.
SELECT
	p.PeakName
	, m.MountainRange AS Mountain
	, p.Elevation
FROM Peaks AS p
JOIN Mountains AS m ON p.MountainId = m.Id
ORDER BY p.Elevation DESC



--- Problem 09: Peaks with Their Mountain, Country and Continent
SELECT 
	p.PeakName
	, m.MountainRange AS Mountain
	, c.CountryName
	, cc.ContinentName
FROM Peaks AS p
JOIN Mountains AS m ON p.MountainId = m.Id
JOIN MountainsCountries AS mc ON m.Id = mc.MountainId
JOIN Countries AS c ON mc.CountryCode = c.CountryCode
JOIN Continents AS cc ON c.ContinentCode = cc.ContinentCode
ORDER BY p.PeakName ASC, c.CountryName ASC



--- Problem 10: Rivers by Country
SELECT
	c.CountryName
	, cc.ContinentName
	, COUNT(r.RiverName) AS RiversCount
	, ISNULL(SUM (r.[Length]), 0) AS TotalLength
FROM Rivers AS r
JOIN CountriesRivers AS cr ON r.Id = cr.RiverId
JOIN Countries AS c ON cr.CountryCode = c.CountryCode
JOIN Continents AS cc ON c.ContinentCode = cc.ContinentCode
GROUP BY c.CountryName, cc.ContinentName
ORDER BY COUNT(r.RiverName) DESC, SUM(r.[Length]) DESC, c.CountryName




--- Problem 11: Count of Countries by Currency
SELECT 
	curr.CurrencyCode
	, curr.[Description] AS Currency
	, COUNT(c.CountryName) AS NumberOfCountries
FROM Currencies AS curr
JOIN Countries AS c ON curr.CurrencyCode = c.CurrencyCode
GROUP BY curr.CurrencyCode, curr.[Description]
ORDER BY COUNT(c.CountryName) DESC, curr.[Description] ASC



--- Problem 12: Population and Area by Continent
SELECT
	con.ContinentName
	, SUM(CONVERT(numeric, c.AreaInSqKm)) AS CountriesArea
	, SUM(CONVERT(numeric, c.[Population])) AS CountriesPopulation
FROM Continents AS con
LEFT JOIN Countries AS c ON con.ContinentCode = c.ContinentCode
GROUP BY con.ContinentName
ORDER BY SUM(c.[Population]) DESC



--- Problem 13: Monasteries by Count
CREATE TABLE Monasteries(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50),
	CountryCode CHAR(2)
	CONSTRAINT FK_Monasteries_Countries FOREIGN KEY (CountryCode) REFERENCES Countries(CountryCode)
)

INSERT INTO Monasteries([Name], CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR')

--START Exclude from Judge
ALTER TABLE Countries
ADD IsDeleted BIT NOT NULL
DEFAULT 0

UPDATE Countries
SET IsDeleted = 1
WHERE CountryCode IN (
	SELECT c.CountryCode
	FROM Countries c
		JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
		JOIN Rivers r ON r.Id = cr.RiverId
	GROUP BY c.CountryCode
	HAVING COUNT(r.Id) > 3
)

SELECT 
	m.Name AS Monastery, c.CountryName AS Country
FROM 
	Countries c
	JOIN Monasteries m ON m.CountryCode = c.CountryCode
WHERE c.IsDeleted = 0
ORDER BY m.Name



--- Program 14: Monasteries by Continents and Countries
UPDATE Countries
SET CountryName = 'Burma'
WHERE CountryName = 'Myanmar'

INSERT INTO Monasteries(Name, CountryCode) VALUES
('Hanga Abbey', (SELECT CountryCode FROM Countries WHERE CountryName = 'Tanzania'))
INSERT INTO Monasteries(Name, CountryCode) VALUES
('Myin-Tin-Daik', (SELECT CountryCode FROM Countries WHERE CountryName = 'Maynmar'))

SELECT ct.ContinentName, c.CountryName, COUNT(m.Id) AS MonasteriesCount
FROM Continents ct
	LEFT JOIN Countries c ON ct.ContinentCode = c.ContinentCode
	LEFT JOIN Monasteries m ON m.CountryCode = c.CountryCode
WHERE c.IsDeleted = 0
GROUP BY ct.ContinentName, c.CountryName
ORDER BY MonasteriesCount DESC, c.CountryName
