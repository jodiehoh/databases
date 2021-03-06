/* 11. Which countries in Asia had more females than males in a given time frame? 
       List the year and the female and male population. Do not include years past 2021. */

DELIMITER //

DROP PROCEDURE IF EXISTS GenderDistribution //

CREATE PROCEDURE GenderDistribution(IN conti VARCHAR(255), year INT)
BEGIN

	SELECT  C.CountryName, I.Yr, I.PopulationFemale, I.PopulationMale, I.PopulationFemale/I.PopulationMale AS "F:M Ratio"
	FROM CountryInfo AS I, Country AS C
	WHERE C.CountryName = I.CountryName AND I.PopulationFemale > PopulationMale AND C.Continent = conti AND I.Yr = year;

END; //

DELIMITER ;
