DELIMITER //

DROP PROCEDURE IF EXISTS DeleteCountryInfo //

CREATE PROCEDURE DeleteCountryInfo(IN cntry VARCHAR(255), IN yer INT)

BEGIN

	IF EXISTS(SELECT * FROM CountryInfo WHERE CountryName = cntry AND Yr = yer) THEN	       
		
		DELETE FROM CountryInfo WHERE CountryName = cntry AND Yr = yer;
	
	END IF;

END; //

DELIMITER ;
