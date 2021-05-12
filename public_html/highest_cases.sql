/* 13. Get the CountryName, VaccineName, Year, and Starting Doses, 
       and current Doses for any Country whose most recent vaccine doses 
       are less than the starting doses. */

DELIMITER //

DROP PROCEDURE IF EXISTS HighCase //

CREATE PROCEDURE HighCase()
BEGIN
	WITH TopCases AS (
        	SELECT CountryName, DiseaseName, MAX(Cases) AS TopCase
		FROM HasDisease
		GROUP BY CountryName, DiseaseName
		ORDER BY TopCase DESC
		LIMIT 1
	)

	SELECT H.CountryName, H.DiseaseName, H.Yr, H.Cases
	FROM HasDisease AS H, TopCases AS T
	WHERE H.CountryName = T.CountryName AND H.DiseaseName = T.DiseaseName;
END; //

DELIMITER ;

