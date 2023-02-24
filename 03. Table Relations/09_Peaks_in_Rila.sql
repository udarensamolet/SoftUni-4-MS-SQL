--- Problem 09: Peaks in Rila

SELECT m.MountainRange, p.PeakName, p.Elevation 
FROM Mountains AS m
JOIN Peaks AS p 
ON p.MountainId = m.Id
WHERE m.Id = 17
ORDER BY Elevation DESC