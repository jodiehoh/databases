DELIMITER //

DROP PROCEDURE IF EXISTS InsertHasDisease //

CREATE PROCEDURE InsertHasDisease(IN cntry VARCHAR(30),
	IN disName VARCHAR(30),
	IN yer INT,
	IN numCases INT)

BEGIN

	IF NOT EXISTS(SELECT * FROM HasDisease WHERE CountryName = cntry AND DiseaseName = disName AND Yr = yer) THEN	       
		
		IF NOT EXISTS(SELECT * FROM Country WHERE CountryName = cntry)
			INSERT INTO Country (CountryName) VALUES (cntry);
		END IF;

		IF NOT EXISTS(SELECT * FROM Disease WHERE DiseaseName = disName)
			INSERT INTO Disease (DiseaseName) VALUES (disName);
		END IF;

		INSERT INTO HasDisease (CountryName, DiseaseName, Yr, Cases) 
		VALUES (cntry, disName, yer, numCases);
	
	END IF;

END; //

DELIMITER ;
