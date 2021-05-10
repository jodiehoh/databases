DELIMITER //

DROP PROCEDURE IF EXISTS DeleteMortalityRate //

CREATE PROCEDURE DeleteMortalityRate(IN cntry VARCHAR(255), IN yer INT)

BEGIN

	IF EXISTS(SELECT * FROM MortalityRate WHERE CountryName = cntry AND Yr = yer) THEN	       
		
		DELETE FROM MortalityRate WHERE CountryName = cntry AND Yr = yer;
	
	END IF;

END; //

DELIMITER ;
