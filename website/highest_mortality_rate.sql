/* 1. What were the top 10 countries in Africa in the year 2000 with 
      highest mortality rates having population above the continent’s average? */

DELIMITER //

DROP PROCEDURE IF EXISTS HighestMortalityRate //

CREATE PROCEDURE HighestMortalityRate(IN topNum INT, IN conti VARCHAR(255), IN yer INT)
BEGIN
	
	SELECT M.CountryName, M.MortalityRate, C.PopulationTotal
	FROM CountryInfo AS C, MortalityRate AS M, Country AS Co
	WHERE C.CountryName = M.CountryName AND Co.CountryName = C.CountryName AND Co.Continent = conti AND M.Yr = yer AND C.Yr = yer AND C.CountryName IN 
	      ( SELECT C.CountryName
	        FROM CountryInfo AS C, Country AS Co
	        WHERE Co.Continent = conti AND C.CountryName = Co.CountryName AND C.Yr = yer 
	        AND C.PopulationTotal > (SELECT AVG(PopulationTotal) FROM CountryInfo WHERE Continent = conti AND Yr = yer))
	ORDER BY M.MortalityRate DESC
	LIMIT topNum;

END; //

DELIMITER ;
