#  US Household Income Exploratory Data Analysis

SELECT *
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_household_income_statistics;

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
Group By State_name
Order By 2 DESC
Limit 10;
# This identifies the top 10 largest states by land mass

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
Group By State_name
Order By 3 DESC
Limit 10;
# This identifies the top 10 states with the largest amount of water

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
Group By u.State_Name
Order By 2 DESC
LIMIT 10;
# This query is to see the average household income in each of the states

SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
Group By 1
HAVING COUNT(TYPE) > 100
Order By 4 DESC
LIMIT 20;
# This query shows the amount of each types of areas we had in the data

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
Group By u.State_Name, City
Order By 2 DESC;
# This query shows us city that make a lot of money 