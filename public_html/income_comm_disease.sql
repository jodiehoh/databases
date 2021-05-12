/* 14. Which low income countries in Asia had more than 5000 cases of communicable diseases from 2000-2010? */

DELIMITER //

DROP PROCEDURE IF EXISTS IncomeCommDisease //

CREATE PROCEDURE IncomeCommDisease(IN incomeType VARCHAR(255), IN conti VARCHAR(255), IN cases INT, IN comm BOOLEAN, IN year1 INT, IN year2 INT)
BEGIN
	
	WITH ContInfo AS (
        SELECT CountryName
        FROM Country
        WHERE Continent = conti AND IncomeGroup = incomeType)
           
	SELECT CountryName, SUM(H.Cases) AS "Cases"
	FROM Disease AS D, HasDisease AS H
	WHERE D.DiseaseName = H.DiseaseName AND D.isCommunicable = comm AND H.Yr BETWEEN year1 AND year2 AND CountryName IN (SELECT CountryName FROM ContInfo)
	GROUP BY CountryName
	HAVING SUM(H.Cases) > cases;

END; //

DELIMITER ;