/* 2. List all countries and vaccines in which 2000
      or more doses have been delivered. */

DELIMITER //

DROP PROCEDURE IF EXISTS VaccineDoses //

CREATE PROCEDURE VaccineDoses(IN numDoses INT)
BEGIN
	
	SELECT V.CountryName, V.VaccineName
	FROM VaccinationDrive AS V
	GROUP BY V.CountryName
	HAVING SUM(V.Doses) >= numDoses;

END; //

DELIMITER ;
