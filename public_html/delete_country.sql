DELIMITER //

DROP PROCEDURE IF EXISTS DeleteCountry //

CREATE PROCEDURE DeleteCountry(IN cntry VARCHAR(255))

BEGIN

	IF EXISTS(SELECT * FROM Country WHERE CountryName = cntry) THEN	       
		
		DELETE FROM Country WHERE CountryName = cntry;
	
	END IF;

END; //

DELIMITER ;
