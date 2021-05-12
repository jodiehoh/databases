/* 9. Which countries are considered high income and have no cases of disease in the database? */

DELIMITER //

DROP PROCEDURE IF EXISTS IncomeDisease //

CREATE PROCEDURE IncomeDisease(IN incomeType VARCHAR(255))
BEGIN
	
	WITH HighIncome AS (
        SELECT CountryName
        FROM Country
        WHERE IncomeGroup = incomeType)
	SELECT CountryName
	FROM HighIncome
	WHERE CountryName NOT IN (SELECT CountryName FROM HasDisease);

END; //

DELIMITER ;
