/* 12. Which country that starts with “A” had the highest mortality rate 
       and is considered Low Income? List the country name and its 
       associated mortality rate in the final output. */


DELIMITER //

DROP PROCEDURE IF EXISTS LetterIncomeMortality //

CREATE PROCEDURE LetterIncomeMortality(IN letter VARCHAR(255), IN incomeType VARCHAR(255))
BEGIN

SELECT DISTINCT M.CountryName, M.MortalityRate
FROM MortalityRate AS M, Country AS C
WHERE C.CountryName = M.CountryName AND M.MortalityRate = (SELECT MAX(MortalityRate)
FROM MortalityRate AS M, Country AS C
WHERE M.CountryName LIKE LOWER(CONCAT(letter,'%')) AND C.IncomeGroup = incomeType AND M.CountryName = C.CountryName);

END; //

DELIMITER ;
