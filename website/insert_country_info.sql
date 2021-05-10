DELIMITER //

DROP PROCEDURE IF EXISTS InsertCountryInfo //

CREATE PROCEDURE InsertCountryInfo(IN cntry VARCHAR(30),
	IN yer INT,
	IN popMale BIGINT,
	IN popFemale BIGINT,
	IN popTotal BIGINT,
	IN popDensity DECIMAL(10, 5))

BEGIN

	IF NOT EXISTS(SELECT * FROM CountryInfo WHERE CountryName = cntry AND Yr = yer) THEN	       
		
		IF NOT EXISTS(SELECT * FROM Country WHERE CountryName = cntry)
			INSERT INTO Country (CountryName) VALUES (cntry);
		END IF;
		
		INSERT INTO CountryInfo (CountryName, Yr, PopulationMale, PopulationFemale, PopulationTotal, PopulationDensity) 
		VALUES (cntry, yr, popMale, popFemale, popTotal, popDensity);
	
	END IF;

END; //

DELIMITER ;