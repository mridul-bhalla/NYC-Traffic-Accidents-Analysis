-- Data Cleaning
 
SELECT * 
FROM collisions;

-- Creating the table structure duplicate to perform the data cleaning steps
CREATE TABLE collisions_staging
LIKE collisions;

-- inserting data into the duplicate made
INSERT collisions_staging
SELECT *
FROM collisions;

SELECT *
FROM collisions_staging;


-- 1. Remove Duplicates if any -----------------------------------------------------------------------------------------------------------------
-- Checking for duplicates if any
SELECT collision_id, COUNT(collision_id)
FROM collisions_staging
GROUP BY collision_id
HAVING COUNT(collision_id) > 1;
-- no duplicates found


-- 2. Standardise the data ---------------------------------------------------------------------------------------------------------------------
-- Here data is already standardised


-- 3. Null Values or blank values ---------------------------------------------------------------------------------------------------------------

-- Checking for null or blank values in a specific column
SELECT *
FROM collisions_staging
WHERE cross_street IS NULL
OR cross_street = '';

-- Converting Blank values in street_name to null values
UPDATE collisions_staging
SET street_name = NULL
WHERE street_name = '';

-- Converting Blank values in cross_street to null values
UPDATE collisions_staging
SET cross_street = NULL
WHERE cross_street = '';

-- Coverting Blank values in contributing_factor to null values
UPDATE collisions_staging
SET contributing_factor = NULL
WHERE contributing_factor = '';

-- Coverting null values in contributing_factor to Unspecified values
UPDATE collisions_staging
SET contributing_factor = 'Unspecified'
WHERE contributing_factor IS NULL;


-- 4. Remove any columns or rows ------------------------------------------------------------------------------------------------------------------------
-- There is no rows or columns that we want to delete as even though some columns are blank for a specific row but others still hold useful info


-- 5. Creating new Columns ------------------------------------------------------------------------------------------------------------------------

-- Adding day of the week column
ALTER TABLE collisions_staging
ADD day_name VARCHAR(10);

UPDATE collisions_staging
SET day_name = DAYNAME(collision_date);

-- Adding month column
ALTER TABLE collisions_staging
ADD month_name VARCHAR(15);

UPDATE collisions_staging
SET month_name = MONTHNAME(collision_date);

-- Adding time category column
ALTER TABLE collisions_staging
ADD time_category VARCHAR(20);

UPDATE collisions_staging
SET time_category = CASE
WHEN TIME(collision_time) BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
WHEN TIME(collision_time) BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
WHEN TIME(collision_time) BETWEEN '18:00:00' AND '20:59:59' THEN 'Evening'
WHEN TIME(collision_time) BETWEEN '21:00:00' AND '23:59:59' THEN 'Night'
WHEN TIME(collision_time) BETWEEN '00:00:00' AND '02:59:59' THEN 'Late Night'
ELSE 'Early Morning'
END;

-- Adding Season Column
ALTER TABLE collisions_staging
ADD season VARCHAR(10);

UPDATE collisions_staging
SET season = CASE
WHEN MONTH(collision_date) IN (12, 1, 2) THEN 'Winter'
WHEN MONTH(collision_date) IN (3, 4, 5) THEN 'Spring'
WHEN MONTH(collision_date) IN (6, 7, 8) THEN 'Summer'
ELSE 'Fall'
END;

-- Adding Holiday indicator column
SELECT MIN(collision_date), MAX(collision_date)
FROM collisions_staging;
-- So we have data from 2021-01-01 to 2023-04-09

-- We will list out all the public holidays between these date range as holidays, and rest as not
ALTER TABLE collisions_staging
ADD holiday_indicator BOOLEAN;

UPDATE collisions_staging
SET holiday_indicator = CASE
WHEN DATE(collision_date) IN ('2021-01-01', '2021-01-18', '2021-02-15', '2021-05-31', '2021-07-04', '2021-09-06', '2021-10-11', '2021-11-11', '2021-11-25', '2021-12-25',
                      '2022-01-01', '2022-01-17', '2022-02-21', '2022-05-30', '2022-07-04', '2022-09-05', '2022-10-10', '2022-11-11', '2022-11-24', '2022-12-25',
                      '2023-01-01', '2023-01-16', '2023-02-20', '2023-05-29', '2023-07-04', '2023-09-04', '2023-10-09', '2023-11-11', '2023-11-23', '2023-12-25') THEN TRUE
ELSE FALSE
END;                      

-- Add Collision Severity column 
ALTER TABLE collisions_staging
ADD collision_severity VARCHAR(10);

UPDATE collisions_staging
SET collision_severity = CASE
WHEN (persons_killed > 0) THEN 'Fatal'
WHEN (persons_injured >= 2) THEN 'Severe'
ELSE 'Minor'
END;




