DELIMITER //

DROP PROCEDURE IF EXISTS InsertDisease //

CREATE PROCEDURE InsertDisease(IN disName VARCHAR(30),
	isComm BOOLEAN)

BEGIN

	IF NOT EXISTS(SELECT * FROM Disease WHERE DiseaseName = disName) THEN	       
		
		INSERT INTO Disease (DiseaseName, isCommunicable) VALUES (disName, isComm);
	
	END IF;

END; //

DELIMITER ;
