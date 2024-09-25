/* US Household Income (Data Cleaning)*/

ALTER TABLE us_project.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;
/* Wrote this query to fix the column name*/

SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_household_income_statistics;



SELECT COUNT(id) 
FROM us_project.us_household_income;

SELECT COUNT(id) 
FROM us_project.us_household_income_statistics;
# These queries are just to check the total ids that were given in the data set


SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;
# This querey is a check for duplicates

SELECT * 
FROM (
SELECT row_id, id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income
) duplicates
WHERE row_num > 1;
# This reveals the rows of the ids that are duplicates

DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
    FROM (
SELECT row_id, id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income
) duplicates
WHERE row_num > 1);
# This query deletes the duplicates 

SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY 1;	
# This shows us all the states and a spelling mistake is dicovered

UPDATE us_project.us_household_income
SET State_Name = "Georgia"
WHERE State_Name = "georia";

UPDATE us_project.us_household_income
SET State_Name = "Alabama"
WHERE State_Name = "alabama";
# This fixes the mistake by removing it from the table

SELECT * 
FROM us_project.us_household_income
WHERE County = "Autauga County"
ORDER BY 1;
# Here I discover a missing value in the "Place" column

UPDATE us_project.us_household_income
SET Place = "Autaugaville"
WHERE County = "Autauga County"
AND City = "Vinemont";
# This query fills in the missing value in the table

UPDATE us_household_income
SET Type = "Borough"
WHERE Type = "Boroughs";
# This query is to fix a minor duplicate type issue

