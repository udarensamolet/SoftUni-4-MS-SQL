USE [Geography]

GO


--- Problem 12: Highest Peaks in Bulgaria
SELECT
	c.CountryCode
	, m.MountainRange
	, p.PeakName
	, p.Elevation
FROM MountainsCountries AS mc
JOIN Mountains AS m
ON mc.MountainId=m.Id
JOIN Peaks AS p
ON mc.MountainId=p.MountainId
JOIN Countries AS c
ON mc.CountryCode=c.CountryCode
WHERE p.Elevation > 2835 AND c.CountryCode='BG'
ORDER BY p.Elevation DESC



--- Problem 13: Count Mountain Ranges
SELECT
	mc.CountryCode
	, COUNT(m.MountainRange) AS MountainRanges
FROM MountainsCountries AS mc
JOIN Mountains as m
ON mc.MountainId=m.Id
WHERE mc.CountryCode IN ('US', 'BG', 'RU')
GROUP BY (mc.CountryCode)



--- Problem 14: Countries with or without Rivers
SELECT TOP(5)
	c.CountryName
	, r.RiverName
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr
ON c.CountryCode=cr.CountryCode
LEFT JOIN Rivers AS r
ON cr.RiverId=r.Id
WHERE c.ContinentCode='AF'
ORDER BY c.CountryName



--- Problem 15: Countries and Currencies
WITH CCU_CTE (ContinentCode, CurrencyCode, CurrencyUsage)
AS
(
	SELECT 
		ContinentCode
		, CurrencyCode
		, COUNT(CountryCode) AS CurrencyUsage
	FROM Countries 
	GROUP BY ContinentCode, CurrencyCode
	HAVING COUNT(CountryCode) > 1  
)
SELECT
	ContMax.ContinentCode, ccu.CurrencyCode, ContMax.TOPCCUUsage
FROM 
	(SELECT
		ContinentCode
		, MAX(CurrencyUsage) 
		AS TOPCCUUsage
		FROM CCU_CTE
		GROUP BY ContinentCode
	) 
AS ContMax
JOIN CCU_CTE as ccu
ON (ContMax.ContinentCode=ccu.ContinentCode AND ContMax.TopCCUUsage = ccu.CurrencyUsage)
ORDER BY ContMax.ContinentCode



--- Problem 16:	Countries Without Any Mountains
SELECT COUNT(*) 
FROM 
(
	SELECT c.CountryName
		, mc.MountainID
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc
	ON c.CountryCode=mc.CountryCode
	WHERE MountainId IS NULL
) 
AS [Count]



--- Problem 17: Highest Peak and Longest River by Country
SELECT TOP(5)
	c.CountryName
	, MAX(p.Elevation) as HighestPeakElevation
	, MAX(r.[Length]) as LongestRiverLength
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc
ON c.CountryCode=mc.CountryCode
LEFT JOIN Peaks AS p
ON p.MountainId=mc.MountainId
LEFT JOIN CountriesRivers AS cr
ON c.CountryCode=cr.CountryCode
LEFT JOIN Rivers AS r
ON r.Id=cr.RiverId
GROUP by C.CountryName
ORDER BY HighestPeakElevation DESC
	, LongestRiverLength DESC
	, CountryName



--- Problem 18: Highest Peak Name and Elevation by Country
WITH PeaksMountains_CTE (Country, PeakName, Elevation, Mountain) 
AS 
(
  SELECT c.CountryName, p.PeakName, p.Elevation, m.MountainRange
  FROM Countries AS c
  LEFT JOIN MountainsCountries as mc ON c.CountryCode = mc.CountryCode
  LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
  LEFT JOIN Peaks AS p ON p.MountainId = m.Id
)
SELECT TOP 5
  TopElevations.Country AS Country,
  ISNULL(pm.PeakName, '(no highest peak)') AS HighestPeakName,
  ISNULL(TopElevations.HighestElevation, 0) AS HighestPeakElevation,	
  ISNULL(pm.Mountain, '(no mountain)') AS Mountain
FROM 
  (SELECT Country, MAX(Elevation) AS HighestElevation
   FROM PeaksMountains_CTE 
   GROUP BY Country) AS TopElevations
LEFT JOIN PeaksMountains_CTE AS pm 
ON (TopElevations.Country = pm.Country AND TopElevations.HighestElevation = pm.Elevation)
ORDER BY Country, HighestPeakName








