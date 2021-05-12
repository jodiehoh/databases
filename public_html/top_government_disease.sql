/* 5. What was the top country who had a Republican Government 
      that had the most number of cases of HIV? */

DELIMITER //

DROP PROCEDURE IF EXISTS TopGovernmentDisease //

CREATE PROCEDURE TopGovernmentDisease(IN govt VARCHAR(255), IN disease VARCHAR(30))
BEGIN

	SELECT C.CountryName, H.Cases
	FROM Country As C, HasDisease as H
	WHERE C.CountryName = H.CountryName AND H.DiseaseName = disease AND C.Government = govt
	ORDER BY H.Cases DESC
	LIMIT 1; 

END; //

DELIMITER ;
