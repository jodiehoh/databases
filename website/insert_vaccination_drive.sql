DELIMITER //

DROP PROCEDURE IF EXISTS InsertHasDisease //

CREATE PROCEDURE InsertHasDisease(IN cntry VARCHAR(30),
	IN vaccName VARCHAR(30), 
	IN yer INT,
	IN numDoses INT)

BEGIN

	IF NOT EXISTS(SELECT * FROM VaccinationDrive WHERE CountryName = cntry AND VaccineName = vaccName AND Yr = yer) THEN	       
		
		IF NOT EXISTS(SELECT * FROM Country WHERE CountryName = cntry)
			INSERT INTO Country (CountryName) VALUES (cntry);
		END IF;

		IF NOT EXISTS(SELECT * FROM Vaccination WHERE VaccineName = vaccName)
			INSERT INTO Vaccination (VaccineName) VALUES (vaccName);
		END IF;

		INSERT INTO VaccinationDrive (CountryName, VaccineName, Yr, Doses) 
		VALUES (cntry, vaccName, yer, numDoses);
	
	END IF;

END; //

DELIMITER ;
