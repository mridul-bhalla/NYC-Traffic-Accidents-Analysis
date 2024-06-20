
-- Question 1: How many collisions occurred each year?  -------------------------------------------------------------------------------------------
SELECT YEAR(collision_date) AS Year, COUNT(*) AS CollisionCount
FROM collisions_staging
GROUP BY YEAR(collision_date)
ORDER BY Year;
-- Maximum occured in 2021 - 100885, followed by 2022 - 92980, and significantly lesser in 2023 - 22232


-- Question 2: How many collisions occurred each month of each year? ----------------------------------------------------------------------------------
SELECT YEAR(collision_date) AS Year, MONTH(collision_date) AS Month, month_name, COUNT(*) AS CollisionCount
FROM collisions_staging
GROUP BY YEAR(collision_date), MONTH(collision_date), month_name
ORDER BY CollisionCount DESC;

-- Maximum collision happened in June of 2021


-- Question 3: How many collisions occurred each day? ---------------------------------------------------------------------------------------------
SELECT day_name, COUNT(*) AS CollisionCount
FROM collisions_staging
GROUP BY day_name
ORDER BY FIELD(day_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Maximum accidents have happened to occur on Friday


-- Question 4: How many collisions occurred each month? --------------------------------------------------------------------------------------------------------------
SELECT month_name, COUNT(*) AS CollisionCount
FROM collisions_staging
GROUP BY month_name
ORDER BY FIELD(month_name, 'January', 'February', 'March', 'April', 'May', 'June', 'July',
 'August', 'September', 'October', 'November', 'December');

-- Maximum collisions have happened in the month of march


-- Question 5: What are the collision hotspots in NYC based on latitude and longitude? ---------------------------------------------------------------------------------------------
SELECT latitude, longitude, COUNT(*) AS CollisionCount
FROM collisions_staging
GROUP BY latitude, longitude
ORDER BY CollisionCount DESC;

-- The top three collision hotspots in NYC are:
-- 1. Latitude: 40.861862, Longitude: 40.861862, num of collisions: 137
-- 2. Latitude: 40.675735, Longitude: -73.896860, num of collisions: 131
-- 3. Latitude: 40.658577, Longitude: -73.890630, num of collisions: 106

-- Question 6: Collision Rate by Borough?  -------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT borough, COUNT(*) AS TotalCollisions, COUNT(*) / (SELECT COUNT(*) FROM collisions_staging) AS CollisionRate
FROM collisions_staging
GROUP BY borough
ORDER BY CollisionRate DESC;
-- Borough with the highest number of collisions and collision rate is:
-- Brooklyn with total collisions as 73005 and collision rate as 0.3378

-- Question 7: What are the most common contributing factors to collisions? ------------------------------------------------------------------------------------------------------
SELECT contributing_factor, COUNT(*) AS Frequency
FROM collisions_staging
GROUP BY contributing_factor
ORDER BY Frequency DESC;
-- Top 3 reasons for collisions include:
-- 1. Driver Inattention/Distraction
-- 2. Failure to Yield Right-of-Way
-- 3. Following Too Closely


-- Question 8: Is there any correlation between contributing factors and collision severity?  ------------------------------------------------------------------------
SELECT contributing_factor, collision_severity, COUNT(*) AS Frequency
FROM collisions_staging
GROUP BY contributing_factor, collision_severity
ORDER BY contributing_factor, collision_severity;
-- Most number of fatal accidents happen due to unsafe speed followed by Driver Inattention/Distraction and Failure to Yield Right-of-Way
-- Most number of severe accidents happen due to Driver Inattention/Distraction, followed by Failure to Yield Right-of-Way 
-- and Following Too Closely
-- Most number of minor accidents happen due to Driver Inattention/Distraction, Failure to Yield Right-of-Way, Following Too Closely


-- Question 9: Which type of vehicle is involved in the most collisions? ----------------------------------------------------------------------------------------------------------------
SELECT vehicle_type, COUNT(*) AS CollisionCount
FROM collisions_staging
GROUP BY vehicle_type
ORDER BY CollisionCount DESC;
-- Most number of accidents happen through Passenger Vehicle, followed by Transport and Taxi


-- Question 10: Do certain vehicle types have a higher likelihood of causing fatalities? -------------------------------------------------------------------------------
SELECT
    vehicle_type,
    SUM(persons_killed) AS TotalFatalities,
    COUNT(*) AS TotalCollisions,
    (SUM(persons_killed) / NULLIF(COUNT(*), 0)) * 100 AS FatalityPercentage
FROM collisions_staging
GROUP BY vehicle_type
ORDER BY FatalityPercentage DESC;
-- Motorcycle have the highest Fatality Percentage 


-- Question 11: What is the distribution of injuries and fatalities across different collision types (pedestrians, cyclists, motorists)? -------------------------------------------------
SELECT
    'Pedestrians' AS CollisionType,
    SUM(pedestrians_injured) AS TotalInjured,
    SUM(pedestrians_killed) AS TotalKilled
FROM collisions_staging
UNION
SELECT
    'Cyclists' AS CollisionType,
    SUM(cyclists_injured) AS TotalInjured,
    SUM(cyclists_killed) AS TotalKilled
FROM collisions_staging
UNION
SELECT
    'Motorists' AS CollisionType,
    SUM(motorists_injured) AS TotalInjured,
    SUM(motorists_killed) AS TotalKilled
FROM collisions_staging;


-- Question 12: Are there any trends in the number of injuries or fatalities over time? -----------------------------------------------------------------
SELECT YEAR(collision_date) AS Year, SUM(persons_injured) AS TotalInjuries, SUM(persons_killed) AS TotalFatalities
FROM collisions_staging
GROUP BY YEAR(collision_date)
ORDER BY Year;
-- They seem to have decreased over time, but then we only have data for 4 months in 2023.


-- Question 13: Are there seasonal variations in collision rates? ----------------------------------------------------------------------------------------------------------------------------
SELECT season, COUNT(*) AS CollisionCount
FROM collisions_staging
GROUP BY season
ORDER BY CollisionCount DESC;
-- Maximum collisions occured in Spring, followed by Winter


-- Question 14: Are collision rates higher on holidays compared to regular days? --------------------------------------------------------------------
SELECT
    CASE
        WHEN holiday_indicator = 1 THEN 'Holiday'
        ELSE 'Regular Day'
    END AS DayType,
    AVG(CollisionCount) AS AverageCollisionsPerDay
FROM (
    SELECT
        collision_date,
        COUNT(*) AS CollisionCount,
        MAX(holiday_indicator) AS holiday_indicator
    FROM collisions_staging
    GROUP BY collision_date
) AS collisions_per_day
GROUP BY DayType
ORDER BY DayType;
-- Average num of collisions on holidays is less as compared to non holidays


-- Question 15: most collisions happen during which time category? --------------------------------------------------------------------------------
SELECT time_category, COUNT(*) AS CollisionCount
FROM collisions_staging
GROUP BY time_category
ORDER BY CollisionCount DESC;
-- most of the collisions have happened during afternoon


-- Question 16: is there any relation between time category and collision_severity? --------------------------------------------------------------
SELECT
    time_category,
    SUM(CASE WHEN collision_severity = 'Fatal' THEN 1 ELSE 0 END) AS FatalAccidents,
    SUM(CASE WHEN collision_severity = 'Severe' THEN 1 ELSE 0 END) AS SevereAccidents,
    SUM(CASE WHEN collision_severity = 'Minor' THEN 1 ELSE 0 END) AS MinorAccidents
FROM
    collisions_staging
GROUP BY
    time_category
ORDER BY
    time_category;
-- Afternoon ranks first in all the categories of collision_severity followed by morning
