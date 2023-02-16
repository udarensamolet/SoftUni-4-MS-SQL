USE Geography


--- Problem 12: Countries Holding 'A' 3 or More Times
SELECT CountryName AS [Country Name]
	, IsoCode AS [Iso Code]
FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY [Iso Code] 



--- Problem 13: Mix of Peak and River Names
SELECT 
	p.PeakName
	, r.RiverName
	, CONCAT(LOWER(p.PeakName), LOWER(SUBSTRING(r.RiverName, 2, LEN(r.RiverName) - 1))) AS Mix
FROM Rivers AS r
JOIN Peaks AS p
ON LEFT(r.RiverName, 1) = RIGHT(p.PeakName, 1)
ORDER BY Mix