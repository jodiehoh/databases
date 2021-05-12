DELIMITER //

DROP PROCEDURE IF EXISTS DeleteDisease //

CREATE PROCEDURE DeleteDisease(IN disName VARCHAR(255))

BEGIN

	IF EXISTS(SELECT * FROM Disease WHERE DiseaseName = disName) THEN	       
		
		DELETE FROM Disease WHERE DiseaseName = disName;
	
	END IF;

END; //

DELIMITER ;