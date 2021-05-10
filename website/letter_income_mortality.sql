/* 12. Which country that starts with “A” had the highest mortality rate 
       and is considered Low Income? List the country name and its 
       associated mortality rate in the final output. */


DELIMITER //

DROP PROCEDURE IF EXISTS LetterIncomeMortality //

CREATE PROCEDURE LetterIncomeMortality(IN letter CHAR(1), IN incomeType VARCHAR(255))
BEGIN
	
	SELECT DISTINCT M.CountryName, M.MortalityRate
	FROM MortalityRate AS M, Country AS C
	WHERE C.IncomeGroup = incomeType AND M.MortalityRate = (SELECT MAX(MortalityRate) FROM MortalityRate WHERE CountryName LIKE LOWER(letter+"%"));

END; //

DELIMITER ;
