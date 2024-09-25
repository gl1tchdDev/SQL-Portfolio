# World Life Expectancy Project (Exploratory Data Analysis)

SELECT *
FROM world_life_expectancy;

SELECT country, MIN(`Life expectancy`), MAX(`Life expectancy`)
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) != 0
AND MAX(`Life expectancy`) != 0
ORDER BY country DESC;
# In this Data set the countries with very small populations had 0 as a life expectancy so in this query I have filtered them out

SELECT country, MIN(`Life expectancy`), MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years 
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) != 0
AND MAX(`Life expectancy`) != 0
ORDER BY Life_Increase_15_Years DESC;

# This query shows which countries have done well in in increasing their life expectancy over the years

SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` != 0
AND `Life expectancy` != 0
GROUP BY Year
ORDER BY Year;

# This query is to show what the average life expectancy is for human beings overall


SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectany
FROM world_life_expectancy;

# This query shows the GDP and Life Expectancy and the correlation between the countries with higher and lower GDPs and their life expectancy


SELECT country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(BMI), 1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI ASC;

# This query provides insights on how BMI correlates to life expectancy for each country


SELECT country, year, `Life expectancy` `Adult Mortality`,
 SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY YEAR) AS Rolling_Total
 FROM world_life_expectancy;