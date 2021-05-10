/* 6. For every year in India, display the vaccination 
      with the maximum number of doses delivered. */

DELIMITER //

DROP PROCEDURE IF EXISTS CountryVaccination //

CREATE PROCEDURE CountryVaccination(IN cntry VARCHAR(255))
BEGIN
	
	SELECT V1.Yr, V1.VaccineName, V1.Doses
	FROM VaccinationDrive AS V1, VaccinationDrive AS V2
	WHERE V1.Yr = V2.Yr AND V1.CountryName = cntry AND V2.CountryName = cntry
	GROUP BY V1.Yr, V1.Doses
	HAVING V1.Doses = MAX(V2.Doses);

END; //

DELIMITER ;
