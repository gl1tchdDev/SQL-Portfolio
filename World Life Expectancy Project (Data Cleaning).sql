# World Life Expectancy Project (Data Cleaning)

SELECT * FROM world_life_expectancy;

# Finding and removing duplicates from the data
SELECT country, year, concat(country, year), count(concat(country, year))
FROM world_life_expectancy
GROUP BY 1, 2, 3
HAVING count(concat(country, year)) > 1;


SELECT *
FROM (
SELECT row_id,
concat(country, year),
ROW_NUMBER() OVER (PARTITION BY concat(country, year) ORDER BY concat(country, year)) as Row_Num
FROM world_life_expectancy
) as Row_Table
WHERE row_num > 1
;
# This query displays the country and year to make clear which countries had duplicate data 

DELETE FROM world_life_expectancy
WHERE
	Row_ID IN (
    SELECT Row_ID
FROM (
SELECT row_id,
concat(country, year),
ROW_NUMBER() OVER (PARTITION BY concat(country, year) ORDER BY concat(country, year)) as Row_Num
FROM world_life_expectancy
) as Row_Table
WHERE Row_Num > 1
)
;
# This query deletes the duplicate data



# Removing missing data from the table

SELECT * 
FROM world_life_expectancy
WHERE status = "";
# This query displays rows with a missing status in the table

SELECT DISTINCT status
FROM world_life_expectancy
WHERE status <> "";
# This query shows us that there are only 2 status types "Developing" and "Developed"

SELECT DISTINCT country
FROM world_life_expectancy
WHERE status = "Developing";
# This shows us the list of countries currently with the "Developing" status

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.status = "Developing"
WHERE t1.status = ""
AND t2.status <> ""
AND t2.status = "Developing";
# This query updates the table and removes the blank status fields for "Developing" countries from the table

SELECT *
FROM world_life_expectancy
WHERE country = "United States of America";
# This query is just to double check that America is the only country that is "Developed" with a missing status

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.status = "Developed"
WHERE t1.status = ""
AND t2.status <> ""
AND t2.status = "Developed";
# This query updates the table and removes the blank status field for "Developed" countries from the table. In this case its only America


SELECT * 
FROM world_life_expectancy
WHERE `Life expectancy` = "";
# This is to identify the missing data for the "life expectancy" column

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2, 1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2 
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3. Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = "";
# Here we calculate the average between the previous and the next year to fill the "Life expectancy" instead of leaving it blank and skipping it

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2 
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3. Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2, 1)
WHERE t1.`Life expectancy` = "";
# This updates the table with the previous calculation and fills in the empty space with an average

SELECT * 
FROM world_life_expectancy
WHERE `Life expectancy` = "";
# This is to identify the missing data for the "Life expectancy" column

# *UPDATE!* This query is now blank due the "Life expectancy" being filled 

