CREATE TABLE Country (
        Continent VARCHAR(30),
	CountryName VARCHAR(50),
	Government VARCHAR(50),
	CountryCode VARCHAR(30),
	Region VARCHAR(50),
	IncomeGroup VARCHAR(255),
        CountryID VARCHAR(20),
	PRIMARY KEY(CountryName)
);

CREATE TABLE CountryInfo (
	CountryName VARCHAR(30),
	Yr INT,
	PopulationMale BIGINT,
	PopulationFemale BIGINT,
	PopulationTotal BIGINT,
	PopulationDensity DECIMAL(10, 5),
	PRIMARY KEY(CountryName, Yr),
	FOREIGN KEY(CountryName) REFERENCES Country(CountryName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Disease (
	DiseaseName VARCHAR(30),
	isCommunicable BOOLEAN,
	PRIMARY KEY(DiseaseName)
);

CREATE TABLE HasDisease (
	CountryName VARCHAR(30),
	DiseaseName VARCHAR(30),
	Yr INT,
	Cases INT,
	PRIMARY KEY(CountryName, DiseaseName, Yr),
	FOREIGN KEY(CountryName) REFERENCES Country(CountryName) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY(DiseaseName) REFERENCES Disease(DiseaseName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MortalityRate (
	CountryName VARCHAR(30),
	Yr INT,
	MortalityRate DECIMAL(10, 9),
	PRIMARY KEY(CountryName, Yr), 
	FOREIGN KEY(CountryName) REFERENCES Country(CountryName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Vaccination (
	VaccineName VARCHAR(30), 
	PRIMARY KEY(VaccineName)
);

CREATE TABLE VaccinationDrive (
	CountryName VARCHAR(30),
	VaccineName VARCHAR(30), 
	Yr INT,
	Doses INT,
	PRIMARY KEY(CountryName, VaccineName, Yr),
	FOREIGN KEY(CountryName) REFERENCES Country(CountryName) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY(VaccineName) REFERENCES Vaccination(VaccineName) ON DELETE CASCADE ON UPDATE CASCADE
);


LOAD DATA LOCAL INFILE '/Users/jodie/Desktop/School/Spring 2021/Databases/Country-small.csv' INTO TABLE Country 
        FIELDS OPTIONALLY ENCLOSED BY '"'
        TERMINATED BY ',' 
        LINES TERMINATED BY '\r\n'
        IGNORE 1 LINES 
        (Continent,CountryName,Government,CountryCode,Region,IncomeGroup);
        
LOAD DATA LOCAL INFILE '/Users/jodie/Desktop/School/Spring 2021/Databases/Country_Info-small.csv' INTO TABLE CountryInfo
        FIELDS OPTIONALLY ENCLOSED BY '"'
        TERMINATED BY ',' 
        LINES TERMINATED BY '\r\n'
        IGNORE 1 LINES 
        (CountryName,Yr,PopulationMale,PopulationFemale,PopulationTotal,PopulationDensity);

LOAD DATA LOCAL INFILE '/Users/jodie/Desktop/School/Spring 2021/Databases/Disease-small.csv' INTO TABLE Disease
        FIELDS OPTIONALLY ENCLOSED BY '"'
        TERMINATED BY ',' 
        LINES TERMINATED BY '\r\n'
        IGNORE 1 LINES 
        (DiseaseName,isCommunicable);

LOAD DATA LOCAL INFILE '/Users/jodie/Desktop/School/Spring 2021/Databases/Has-Disease-small.csv' INTO TABLE HasDisease
        FIELDS OPTIONALLY ENCLOSED BY '"'
        TERMINATED BY ',' 
        LINES TERMINATED BY '\r\n'
        IGNORE 1 LINES 
        (CountryName,DiseaseName,Yr,Cases);

LOAD DATA LOCAL INFILE '/Users/jodie/Desktop/School/Spring 2021/Databases/Mortality-Rate-small.csv' INTO TABLE MortalityRate
        FIELDS OPTIONALLY ENCLOSED BY '"'
        TERMINATED BY ',' 
        LINES TERMINATED BY '\r\n'
        IGNORE 1 LINES 
        (CountryName,Yr,@vMortalityRate)
        SET MortalityRate = NULLIF(@vMortalityRate,'');

LOAD DATA LOCAL INFILE '/Users/jodie/Desktop/School/Spring 2021/Databases/Vaccination-small.csv' INTO TABLE Vaccination
        FIELDS OPTIONALLY ENCLOSED BY '"'
        TERMINATED BY ',' 
        LINES TERMINATED BY '\r\n'
        IGNORE 1 LINES 
        (VaccineName);
        
LOAD DATA LOCAL INFILE '/Users/jodie/Desktop/School/Spring 2021/Databases/Vaccination-Drive-small.csv' INTO TABLE VaccinationDrive
        FIELDS OPTIONALLY ENCLOSED BY '"'
        TERMINATED BY ',' 
        LINES TERMINATED BY '\r\n'
        IGNORE 1 LINES 
        (CountryName,VaccineName,Yr,Doses);