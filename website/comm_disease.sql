/* 4. List all communicable diseases that were present in 
      the different continents from 1900 to 1999. */

DELIMITER //

DROP PROCEDURE IF EXISTS CommunicableDisease //

CREATE PROCEDURE CommunicableDisease(IN comm BOOLEAN, IN year1 INT, IN year2 INT)
BEGIN	

	
	SELECT C.Continent, DISTINCT D.DiseaseName
	FROM Country AS C, Disease AS D, HasDisease AS H
	WHERE C.CountryName = H.CountryName, D.DiseaseName = H.DiseaseName AND H.Yr >= year1 AND H.Yr <= year2 AND D.isCommunicable = comm;
	GROUP BY C.Continent;

END; //

DELIMITER ;