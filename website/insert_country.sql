DELIMITER //

DROP PROCEDURE IF EXISTS InsertCountry //

CREATE PROCEDURE InsertCountry(IN conti VARCHAR(255),
	IN cntry VARCHAR(255),
	IN govt VARCHAR(255),
	IN cntryCode VARCHAR(30),
	IN rgn VARCHAR(255),
	IN incomeType VARCHAR(255))

BEGIN

	IF NOT EXISTS(SELECT * FROM Country WHERE CountryName = cntry) THEN	       
		
		INSERT INTO Country (Continent, CountryName, Government, CountryCode, Region, IncomeGroup) 
		VALUES (conti, cntry, govt, cntryCode, rgn, incomeType);
	
	END IF;

END; //

DELIMITER ;
