DELIMITER //

DROP PROCEDURE IF EXISTS DeleteHasDisease //

CREATE PROCEDURE DeleteHasDisease(IN cntry VARCHAR(255), IN disName VARCHAR(255), IN yer INT)

BEGIN

	IF EXISTS(SELECT * FROM HasDisease WHERE CountryName = cntry AND DiseaseName = disName AND Yr = yer) THEN	       
		
		DELETE FROM HasDisease WHERE CountryName = cntry AND DiseaseName = disName AND Yr = yer;
	
	END IF;

END; //

DELIMITER ;
