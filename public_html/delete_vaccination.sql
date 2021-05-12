DELIMITER //

DROP PROCEDURE IF EXISTS DeleteVaccination //

CREATE PROCEDURE DeleteVaccination(IN vaccName VARCHAR(255))

BEGIN

	IF EXISTS(SELECT * FROM Vaccination WHERE VaccineName = vaccName) THEN	       
		
		DELETE FROM Vaccination WHERE VaccineName = vaccName;
	
	END IF;

END; //

DELIMITER ;
