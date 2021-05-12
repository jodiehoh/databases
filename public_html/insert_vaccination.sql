DELIMITER //

DROP PROCEDURE IF EXISTS InsertVaccination //

CREATE PROCEDURE InsertVaccination(IN vaccName VARCHAR(30))

BEGIN

	IF NOT EXISTS(SELECT * FROM Vaccination WHERE VaccineName = vaccName) THEN	       
		
		INSERT INTO Vaccination (VaccineName) VALUES (vaccName);
	
	END IF;

END; //

DELIMITER ;
