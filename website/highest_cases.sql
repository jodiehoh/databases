/* 8. Which country and year had the highest number of cases of a certain disease? 
      Show the complete disease and case history for the associated country. */

DELIMITER //

DROP PROCEDURE IF EXISTS HighestCases //

CREATE PROCEDURE HighestCases()
BEGIN
	
	WITH TopCases AS (
        SELECT CountryName, DiseaseName, MAX (Cases) as TopCase
		FROM HasDisease
		GROUP BY CountryName, DiseaseName
		ORDER BY TopCase DESC
		LIMIT 1)


		SELECT H.CountryName, H.DiseaseName, H.Yr, H.Cases
		FROM HasDisease AS H, TopCases AS T
WHERE H.CountryName = T.CountryName AND H.DiseaseName = T.DiseaseName;
END; //

DELIMITER ;
