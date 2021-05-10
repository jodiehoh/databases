/* 7. What is the complete population history for China? 
      List the Country Name, female to male , total population and the population density. */

DELIMITER //

DROP PROCEDURE IF EXISTS PopulationHistory //

CREATE PROCEDURE PopulationHistory(IN disease1 VARCHAR(30), IN year1 INT)
BEGIN	

	SELECT C.Government, 100 * SUM(H.Cases) / SUM(I.PopulationTotal) AS "Population Percentage"
	FROM Country AS C, CountryInfo AS I, HasDisease AS H
	WHERE C.CountryName = I.CountryName AND C.CountryName = H.CountryName AND H.Yr = year1 AND I.Yr = year1 AND H.DiseaseName = disease1
	GROUP BY C.Government;


END; //

DELIMITER ;