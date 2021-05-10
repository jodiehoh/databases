DELIMITER //

DROP PROCEDURE IF EXISTS DeleteVaccinationDrive //

CREATE PROCEDURE DeleteVaccinationDrive(IN cntry VARCHAR(255), IN vaccName VARCHAR(255), IN yer INT)

BEGIN

	IF EXISTS(SELECT * FROM VaccinationDrive WHERE CountryName = cntry AND VaccineName = vaccName AND Yr = yer) THEN	       
		
		DELETE  FROM VaccinationDrive WHERE CountryName = cntry AND VaccineName = vaccName AND Yr = yer;
	
	END IF;

END; //

DELIMITER ;
