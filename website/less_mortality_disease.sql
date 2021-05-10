/* 10. List total number of diseases in countries whose mortality rate 
       has been less than 7.5% from 2015-2018. */

DELIMITER //

DROP PROCEDURE IF EXISTS LessMortalityDisease //

CREATE PROCEDURE LessMortalityDisease(IN ub INT, IN year1 INT, IN year2 INT)
BEGIN
	
	WITH MRCount AS (
        SELECT CountryName, COUNT(*) AS "Ct"
        FROM MortalityRate 
        WHERE MortalityRate < ub / 100 AND Yr BETWEEN year1 AND year2
        GROUP BY CountryName),   

        MR AS (
                SELECT M.CountryName
                FROM MortalityRate AS M, MRCount AS C
                WHERE M.CountryName = C.CountryName AND M.Yr BETWEEN year1 AND year2 AND C.Ct = 4)

		SELECT M.CountryName, SUM(H.Cases) AS "Cases"
		FROM MortalityRate AS M, HasDisease AS H
		WHERE M.Yr BETWEEN year1 AND year2 AND M.CountryName IN (SELECT CountryName FROM MR) AND H.CountryName = M.CountryName AND H.Yr = M.Yr
		GROUP BY M.CountryName;

END; //

DELIMITER ;
