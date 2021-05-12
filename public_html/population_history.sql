/* 7. What is the complete population history for China? 
      List the Country Name, female to male , total population and the population density. */

DELIMITER //

DROP PROCEDURE IF EXISTS PopulationHistory //

CREATE PROCEDURE PopulationHistory(IN country VARCHAR(255))
BEGIN
	IF EXISTS(SELECT C.CountryName, C.PopulationFemale / C.PopulationMale, PopulationTotal
		      FROM CountryInfo As C 
		      WHERE C.CountryName = country) THEN	       
		SELECT C.Yr, C.CountryName, C.PopulationFemale / C.PopulationMale, PopulationTotal
		FROM CountryInfo As C 
		WHERE C.CountryName = country;
	END IF;

END; //

DELIMITER ;
