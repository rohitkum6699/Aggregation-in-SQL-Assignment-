-- there is no database named like world in my MYSQL WORKBENCH so i created it by using create function.

CREATE DATABASE world;
show databases;



USE world;
CREATE TABLE Country (
    Code CHAR(3) PRIMARY KEY,
    Name VARCHAR(100),
    Continent VARCHAR(50),
    Region VARCHAR(50),
    Population INT,
    Capital INT
);

CREATE TABLE City (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    CountryCode CHAR(3),
    District VARCHAR(100),
    Population INT,
    FOREIGN KEY (CountryCode)
        REFERENCES Country (Code)
);
CREATE TABLE CountryLanguage (
    CountryCode CHAR(3),
    Language VARCHAR(50),
    IsOfficial CHAR(1),
    Percentage FLOAT,
    PRIMARY KEY (CountryCode, Language),
    FOREIGN KEY (CountryCode) REFERENCES Country(Code)
);

INSERT INTO Country VALUES
('IND','India','Asia','Southern Asia',1400000000,1),
('USA','United States','North America','North America',331000000,2),
('CHN','China','Asia','Eastern Asia',1440000000,3);

INSERT INTO City VALUES
(1,'New Delhi','IND','Delhi',32000000),
(2,'Mumbai','IND','Maharashtra',21000000),
(3,'New York','USA','New York',8500000),
(4,'Beijing','CHN','Beijing',21500000);


INSERT INTO CountryLanguage VALUES
('IND','Hindi','T',43.6),
('IND','English','T',12.0),
('USA','English','T',95.0),
('CHN','Chinese','T',92.0);

USE world;

SELECT * FROM Country;
SELECT * FROM City;
SELECT * FROM CountryLanguage;


-- Question 1   Count how many cities are there in each country?
-- Ans--> 
SELECT
    c.Name AS CountryName,
    COUNT(ci.ID) AS TotalCities
FROM Country c
LEFT JOIN City ci
ON c.Code = ci.CountryCode
GROUP BY c.Code, c.Name
ORDER BY TotalCities DESC;


-- Question 2   Display all continents having more than 30 countries
-- Ans-->

SELECT
    Continent,
    COUNT(*) AS TotalCountries
FROM Country
GROUP BY Continent
HAVING COUNT(*) > 30;
-- Question 3   List regions whose total population exceeds 200 million
-- Ans--> 
SELECT
    Region,
    SUM(Population) AS TotalPopulation
FROM Country
GROUP BY Region
HAVING SUM(Population) > 200000000
ORDER BY TotalPopulation DESC;

-- Question 4  Find the top 5 continents by average GNP per country.
-- Ans-->
SELECT
    Continent,
    AVG(GNP) AS AvgGNP
FROM Country
GROUP BY Continent
ORDER BY AvgGNP DESC
LIMIT 5;

-- Question 5  Find the total number of official languages spoken in each continent  
-- Ans --> 
SELECT
    c.Continent,
    COUNT(cl.Language) AS TotalOfficialLanguages
FROM Country c
JOIN CountryLanguage cl
ON c.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY c.Continent
ORDER BY TotalOfficialLanguages DESC;

-- Question 6   Find the maximum and minimum GNP for each continent
-- Ans-- >
SELECT
    Continent,
    MAX(GNP) AS MaxGNP,
    MIN(GNP) AS MinGNP
FROM Country
GROUP BY Continent
ORDER BY MaxGNP DESC;


-- Question 7   Find the country with the highest average city population.
-- Ans-->
SELECT
    c.Name AS CountryName,
    AVG(ci.Population) AS AvgCityPopulation
FROM Country c
JOIN City ci
ON c.Code = ci.CountryCode
GROUP BY c.Code, c.Name
ORDER BY AvgCityPopulation DESC
LIMIT 1;


-- Qustion 8   List continents where the average city population is greater than 200,000
-- Ans-->
SELECT
    c.Continent,
    AVG(ci.Population) AS AvgCityPopulation
FROM Country c
JOIN City ci
ON c.Code = ci.CountryCode
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000
ORDER BY AvgCityPopulation DESC;

-- Question 9  Find the total population and average life expectancy for each continent, ordered by average life expectancy descending
-- Ans-->
SELECT
    Continent,
    SUM(Population) AS TotalPopulation,
    AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM Country
GROUP BY Continent
ORDER BY AvgLifeExpectancy DESC;

 -- Qustion 10   : Find the top 3 continents with the highest average life expectancy, but only include those where 
-- the total population is over 200 million
 -- Ans-->  
 
 SELECT
    Continent,
    SUM(Population) AS TotalPopulation,
    AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM Country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY AvgLifeExpectancy DESC
LIMIT 3;

--  i am sure that some queries will give error because some columns are not present
--  in the tables in the world database

--  by default my MYSQL WORKBENCH has no database named like world, so forgive me.

 

