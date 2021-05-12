/* 13. Get the CountryName, VaccineName, Year, and Starting Doses, 
       and current Doses for any Country whose most recent vaccine doses 
       are less than the starting doses. */

DELIMITER //

DROP PROCEDURE IF EXISTS MostRecentDoses //

CREATE PROCEDURE MostRecentDoses()
BEGIN
	
	WITH StartDoses AS (
	        SELECT VD1.CountryName AS "CountryName", VD1.VaccineName AS "VaccineName", VD1.Doses AS "StartingDoses"
	        FROM VaccinationDrive AS VD1 
	        LEFT OUTER JOIN VaccinationDrive AS VD2 
	        ON (VD1.CountryName = VD2.CountryName AND VD1.Yr > VD2.Yr)
	        WHERE VD2.Yr IS NULL
	)

	SELECT S.CountryName, S.VaccineName, StartingDoses, VD1.Doses 
	FROM StartDoses AS S, VaccinationDrive AS VD1 
	        LEFT OUTER JOIN VaccinationDrive AS VD2 
	        ON (VD1.CountryName = VD2.CountryName AND VD1.Yr < VD2.Yr)
	WHERE S.CountryName = VD1.CountryName AND S.VaccineName = VD1.VaccineName AND S.StartingDoses >= VD1.Doses AND VD2.Yr IS NULL;

END; //

DELIMITER ;
