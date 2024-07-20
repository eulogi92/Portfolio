USE [Portfolio]
GO

--Inspect table
SELECT *
FROM [dbo].[Data life-expectancy] ;

--average life expectancy at birth in Europe
SELECT RegionDisplay, avg(Numeric) 
FROM [dbo].[Data life-expectancy] 
WHERE MetricObserved='Life expectancy at birth (years)' and RegionDisplay='Europe'
GROUP BY RegionDisplay;

--region with lowest life expectancy at birth
SELECT RegionDisplay, avg(Numeric) 
FROM [dbo].[Data life-expectancy]  
WHERE MetricObserved='Life expectancy at birth (years)'
GROUP BY RegionDisplay
ORDER BY avg(NUmeric) DESC;

--average life expectancy for all three types of MetricObserved by each region
SELECT RegionDisplay,
avg(CASE WHEN MetricObserved='Life expectancy at birth (years)' THEN Numeric ELSE 0 END) as LEAB,
avg(CASE WHEN MetricObserved='Healthy life expectancy (HALE) at birth (years)' THEN Numeric ELSE 0 END) as HLEAB,
avg(CASE WHEN MetricObserved='Life expectancy at age 60 (years)' THEN Numeric ELSE 0 END) as LE60
FROM [dbo].[Data life-expectancy]  
GROUP BY RegionDisplay;

--top countries that consume the highest quantities of beer, wine and spirits respectively. 
SELECT CountryDisplay, avg(beer_servings) as avg_beer, avg(spirit_servings) as avg_spirit, avg(wine_servings) as avg_wine
FROM [dbo].[Data life-expectancy]
GROUP BY CountryDisplay
ORDER BY avg(beer_servings) DESC;


--top countries that consume the highest quantities of alcohol overall
SELECT CountryDisplay, avg(beer_servings)+avg(spirit_servings)+avg(wine_servings) as avg_alcohol_servings
FROM [dbo].[Data life-expectancy] 
GROUP BY CountryDisplay
ORDER BY avg_alcohol_servings DESC;


--the country that consumed the highest quantity of alcohol overall, was it the first ranking country in terms of beer, wine or spirits
SELECT CountryDisplay, avg(beer_servings), avg(spirit_servings), avg(wine_servings), avg(beer_servings)+avg(spirit_servings)+avg(wine_servings) as avg_alcohol_servings
FROM [dbo].[Data life-expectancy] 
GROUP BY CountryDisplay
ORDER BY avg_alcohol_servings DESC;

--Country in Europe with the lowest life expectancy at birth
SELECT CountryDisplay, round(avg(Numeric),2) 
FROM [dbo].[Data life-expectancy] 
WHERE MetricObserved='Life expectancy at birth (years)' and RegionDisplay='Europe'
GROUP BY CountryDisplay
ORDER BY avg(Numeric);

--difference between females and males life expectancy at birth
SELECT CountryDisplay, avg(CASE WHEN SexDisplay='Female' THEN Numeric ELSE 0 END) - avg(CASE WHEN SexDisplay='Male' THEN Numeric ELSE 0 END) as avg_LE_delta_gender
FROM [dbo].[Data life-expectancy]  
WHERE MetricObserved='Life expectancy at birth (years)'
GROUP BY CountryDisplay, SexDisplay
ORDER BY avg_LE_delta_gender DESC;
