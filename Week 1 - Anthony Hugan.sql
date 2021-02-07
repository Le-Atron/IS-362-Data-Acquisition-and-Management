-- Week 1 SQL Script - Anthony Hugan


-- 1. How many airplanes have listed speeds? What is the minimum listed speed and the maximum listed speed?


SELECT count(speed) AS TotalListedSpeeds 
FROM planes
Where speed is not null;

-- There are 23 airplanes with listed speeds 

SELECT MAX(speed) AS MaxSpeed 
FROM planes;

-- The max speed is 432

SELECT MIN(speed) AS MinimumSpeed 
FROM planes;

-- The minimum speed is 90


-- 2. What is the total distance flown by all of the planes in January 2013? 
-- What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?

SELECT SUM(distance) AS TotalDistance 
FROM flights
WHERE year = 2013 AND MONTH = 1;

-- Total Distance in January of 2013 is 27188805 miles


SELECT SUM(distance) AS TotalDistanceWithoutTailnum
FROM flights
WHERE year = 2013 AND MONTH = 1
AND tailnum = "" OR tailnum IS NULL;

-- The total distance flown by all planes with tailnum missing is 81,763 miles



-- 3. What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? 
-- Write this statement first using an INNER JOIN,
-- then using a LEFT OUTER JOIN. How do your results compare?

SELECT SUM(distance) AS TotalFlightDistance , manufacturer AS Manufacturer
FROM flights
INNER JOIN planes
ON flights.tailnum = planes.tailnum
WHERE flights.year = 2013 AND MONTH = 5 AND DAY = 5
GROUP BY manufacturer;


SELECT SUM(distance) AS TotalFlightDistance , manufacturer AS Manufacturer
FROM flights
LEFT JOIN planes
ON flights.tailnum = planes.tailnum
WHERE flights.year = 2013 AND MONTH = 5 AND DAY = 5
GROUP BY manufacturer; 

-- Left join also includes null variables at the manufacture level. 


-- 4. Write and answer at least one question of your own
-- choosing that joins information from at least three of
-- the tables in the flights database.

-- What manufacture and model plane has the most total Flight delays

SELECT AVG (arr_delay) AS AverageDelay, manufacturer AS Manufacturer, Model AS Model
from flights 
join planes on flights.tailnum = planes.tailnum
GROUP BY manufacturer;
ORDER BY arr_delay ASC

-- The Manufacture with the highest average delay is Agusta Spa, and the Model is A109E

-- Tableau Assignment - Anthony Hugan 

-- Your task is to use Tableau to compare flight performance within a category for 2013. For example, you could show
-- average monthly departure delay across the three New York airports. You may use this example, but you’re strongly
-- encouraged to come up with your own example that you might find more interesting.

SELECT f.origin, CONCAT(f.month,'/', f.day, '/', f.year) AS 'Date',
f.tailnum as Aircraft,
p.manufacturer as Manufacturer,
AVG(IFNULL(arr_delay, 0)) AS 'Average Delay'
FROM flights f
INNER JOIN planes p 
ON f.tailnum = p.tailnum
GROUP BY f.origin, f.tailnum , p.manufacturer, f.year, f.month, f.day
ORDER BY f.origin, f.month, f.day, f.year;


-- Link to the tableau workbook
-- https://public.tableau.com/profile/anthony.hugan#!/vizhome/TableauDelaysbyAircraft-AnthonyHugan/Sheet1?publish=yes

