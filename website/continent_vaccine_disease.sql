/* 15. List all the vaccine doses and disease cases for each continent. */

DELIMITER //

DROP PROCEDURE IF EXISTS ContinentVaccineDisease //

CREATE PROCEDURE ContinentVaccineDisease()
BEGIN
	
	WITH ContinentDisease AS (
	        SELECT C.Continent, SUM(D.Cases) AS "DiseaseCases"
	        FROM Country AS C, HasDisease AS D
	        GROUP BY C.Continent),
	        
	      ContinentVaccine AS (
	        SELECT C.Continent, SUM(V.Doses) AS "VaccineDoses"
	        FROM Country AS C, VaccinationDrive AS V
	        GROUP BY C.Continent)
	        
	SELECT D.Continent, D.DiseaseCases, V.VaccineDoses
	FROM ContinentDisease AS D, ContinentVaccine AS V
	WHERE D.Continent = V.Continent;

END; //

DELIMITER ;
