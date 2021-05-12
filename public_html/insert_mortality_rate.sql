DELIMITER //

DROP PROCEDURE IF EXISTS InsertMortalityRate //

CREATE PROCEDURE InsertMortalityRate(IN cntry VARCHAR(30),
	IN yer INT,
	IN mrate DECIMAL(10, 9))

BEGIN

	IF NOT EXISTS(SELECT * FROM MortalityRate WHERE CountryName = cntry AND Yr = yer) THEN	       
		
		IF NOT EXISTS(SELECT * FROM Country WHERE CountryName = cntry)
			INSERT INTO Country (CountryName) VALUES (cntry);
		END IF;
		
		INSERT INTO MortalityRate (CountryName, Yr, MortalityRate) 
		VALUES (cntry, yer, mrate);
	
	END IF;

END; //

DELIMITER ;
