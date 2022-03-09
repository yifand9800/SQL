/* Question 2*/
SELECT *
FROM countrylanguage;

/* Question 3*/
SELECT count(*) AS totalRecords
FROM countrylanguage;

/* Question 4*/
SELECT CountryCode, Language
FROM countrylanguage
WHERE IsOfficial = "T";

/* Question 5*/
SELECT CountryCode, count(Language) AS Count
FROM countrylanguage
GROUP BY CountryCode
ORDER BY CountryCode ASC;

/* Question 6*/
SELECT cl.CountryCode, count(cl.Language) AS Count, c.Name
FROM countrylanguage cl
JOIN country c
ON c.Code = cl.CountryCode
GROUP BY cl.CountryCode
ORDER BY count(cl.Language) DESC;

/*Question 7*/
INSERT INTO city(ID, Name, CountryCode, District, Population)
VALUES(4082, 'Everett', 'USA', 'Washington', 111262);
INSERT INTO city(ID, Name, CountryCode, District, Population)
VALUES(4083, 'Renton', 'USA', 'Washington', 102153);

/*Question 8*/
UPDATE city SET Population = 744955 
WHERE ID  = 3816;
UPDATE city SET Population = 219190 
WHERE ID  = 3889;
UPDATE city SET Population = 216279 
WHERE ID  = 3891;
UPDATE city SET Population = 183012 
WHERE ID  = 3939;
UPDATE city SET Population =  147599
WHERE ID  = 4003;

/* Question 9*/
SELECT Name, Population 
FROM city
where ID IN (3816, 3889, 3891, 3939, 4003);

