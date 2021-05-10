/* 11. Which countries in Asia had more females than males in a given time frame? 
       List the year and the female and male population. Do not include years past 2021. */

DELIMITER //

DROP PROCEDURE IF EXISTS PopulationHistory //

CREATE PROCEDURE PopulationHistory(IN conti VARCHAR(255))
BEGIN

	SELECT C.CountryName, I.Yr, I.PopulationFemale, I.PopulationMale, I.PopulationFemale/I.PopulationMale AS "F:M Ratio"
	FROM CountryInfo AS I, Country AS C
	WHERE C.CountryName = I.CountryName AND I.PopulationFemale > PopulationMale AND C.Continent = conti AND I.Yr <= 2021;

END; //

DELIMITER ;