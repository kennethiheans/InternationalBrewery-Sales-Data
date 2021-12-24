CREATE TABLE breweries(
sales_id int,
sales_rep text,
emails varchar,
brands varchar,
plant_cost int,
unit_cost int,
quantity int,
cost int,
profit int,
countries text,
region text,
months text, 
year int);

COPY breweries
FROM 'C:\Users\Public\International_Breweries (1).csv'
DELIMITER ',' CSV
HEADER;

SELECT *
FROM breweries;

/*PROFIT ANALYSIS*/
1. /*Within the space of the last three years, what was the profit worth of the breweries, 
inclusive of the anglophone and the francophone territories?*/

SELECT SUM(profit) AS Profit
FROM breweries
WHERE year BETWEEN '2017' AND '2019';

2./*Compare the total profit between these two territories in order for the territory manager, 
Mr. Stone make strategic decision that will aid profit maximization in 2020*/
SELECT *
FROM
(SELECT SUM(profit) AS Total_profit_in_anglophone
FROM breweries
WHERE countries IN ('Nigeria', 'Ghana')) AS Anglophone
CROSS JOIN
(SELECT SUM(profit) AS Total_profit_in_francophone
FROM breweries
WHERE countries IN ('Benin', 'Senegal', 'Togo')) AS Francophone;

3. /*Country that generated the highest profit in 2019*/

SELECT countries AS country, SUM(profit) AS profit
FROM breweries
WHERE year ='2019'
GROUP BY country
ORDER BY profit DESC
LIMIT 1;

4. /*Help him find the year with the highest profit.*/

SELECT year, SUM(profit) AS profit
FROM breweries
GROUP BY year
ORDER BY profit DESC
LIMIT 1;

5. /*Which month in the three years were the least profit generated?*/

SELECT months AS month, SUM(profit) AS profit
FROM breweries
GROUP BY month
ORDER BY profit ASC
LIMIT 1;

6. /*What was the minimum profit in the month of December 2018?*/

SELECT profit
FROM breweries
WHERE months = 'December' AND year = '2018'
ORDER BY profit ASC
LIMIT 1;

7. /*Compare the profit in percentage for each of the month in 2019*/

SELECT months, SUM((profit*100)/cost) AS profit_percent
FROM breweries
WHERE year = '2019'
GROUP BY months
ORDER BY profit_percent DESC

8. /*Which particular brand generated the highest profit in Senegal?*/

SELECT brands AS brand, SUM(profit) AS profit
FROM breweries
WHERE countries = 'Senegal'
GROUP BY brand
ORDER BY profit DESC
LIMIT 1;

/*BRAND ANALYSIS*/
1./*Within the last two years, the brand manager wants to know 
the top three brands consumed in the francophone countries*/

SELECT brands AS top_brands, SUM(quantity)AS quantity_consumed
FROM breweries
WHERE year BETWEEN '2018' AND '2019' 
AND countries IN ('Benin', 'Senegal', 'Togo')
GROUP BY top_brands
ORDER BY quantity_consumed DESC
LIMIT 3;

2./*Find out the top two choice of consumer brands in Ghana*/

SELECT brands AS top_brands, SUM(quantity)AS quantity_consumed
FROM breweries
WHERE countries ='Ghana'
GROUP BY top_brands
ORDER BY quantity_consumed DESC
LIMIT 2;

3./*Find out the details of beers consumed in 
the past three years in the most oil reach country in West Africa*/

SELECT brands, SUM(quantity)AS quantity_consumed
FROM breweries
WHERE brands NOT ILIKE '%malt%' AND countries = 'Nigeria'
GROUP BY brands
ORDER BY quantity_consumed DESC;

4. /*Favorites malt brand in Anglophone region between 2018 and 2019*/

SELECT region, brands AS brand, SUM(quantity) AS quantity
FROM breweries
WHERE year BETWEEN '2018'AND'2019' AND brands ILIKE '%malt%'
AND countries IN ('Nigeria', 'Ghana')
GROUP BY region, brands
ORDER BY quantity DESC;

5. /*Which brands sold the highest in 2019 in Nigeria?*/

SELECT brands, SUM(profit)AS profit
FROM breweries
WHERE year ='2019' AND countries ='Nigeria'
GROUP BY brands
ORDER BY profit DESC;

6. /*Favorites brand in South_South region in Nigeria*/

SELECT brands, SUM(quantity) AS quantity_puchased
FROM breweries
WHERE countries ='Nigeria' AND region = 'southsouth'
GROUP BY region, brands
ORDER BY quantity_puchased DESC;

7. /*Beer consumption in Nigeria*/

SELECT brands, SUM(quantity)AS quantity_consumed
FROM breweries
WHERE countries ='Nigeria' AND brands NOT ILIKE '%malt%'
GROUP BY brands
ORDER BY quantity_consumed DESC;

8./*Level of consumption of Budweiser in the regions in Nigeria*/

SELECT brands AS brand, SUM(quantity)AS quantity_consumed
FROM breweries
WHERE brands = 'budweiser' AND countries ='Nigeria'
GROUP BY brand;

9./*Level of consumption of Budweiser in the regions in 
Nigeria in 2019 (Decision on Promo)*/

SELECT region AS regions, SUM(quantity)AS quantity_consumed
FROM breweries
WHERE countries ='Nigeria' AND year ='2019'
AND brands = 'budweiser'
GROUP BY regions
ORDER BY quantity_consumed DESC;

/*COUNTRIES ANALYSIS*/
1./*Country with the highest consumption of beer.*/

SELECT countries AS country, SUM(quantity)AS quantity_consumed
FROM breweries
WHERE brands NOT ILIKE '%malt%'
GROUP BY country
ORDER BY quantity_consumed DESC
LIMIT 1;

2./*Highest sales personnel of Budweiser in Senegal*/

SELECT sales_rep, SUM(profit)AS profit
FROM breweries
WHERE countries = 'Senegal' AND brands='budweiser'
GROUP BY sales_rep
ORDER BY profit DESC
LIMIT 1;

3./*Country with the highest profit of the fourth quarter in 2019*/

SELECT countries AS country, SUM(profit)AS profit
FROM breweries
WHERE months IN ('October','November','December') AND year ='2019'
GROUP BY country
ORDER BY profit DESC
LIMIT 1;
