main description
# SQL Examples
## Example 1: analysis of life expectancy and quality around the globe
- CSV file: see 
- SQL code:

--0 Inspect table
```
SELECT *
FROM `total-treat-428917-i1.homework3.homework3` ;
```

--1 What is the average life expectancy at birth in Europe? 
```
SELECT RegionDisplay, avg(Numeric) 
FROM `total-treat-428917-i1.homework3.homework3` 
WHERE MetricObserved='Life expectancy at birth (years)' and RegionDisplay='Europe'
GROUP BY RegionDisplay;
```

--2 Is Europe the region with the highest life expectancy at birth? Which region has the lowest life expectancy at birth? 
```
SELECT RegionDisplay, avg(Numeric) 
FROM `total-treat-428917-i1.homework3.homework3` 
WHERE MetricObserved='Life expectancy at birth (years)'
GROUP BY RegionDisplay
ORDER BY avg(NUmeric) DESC;
```

--3 Does Europe also have the highest life expectancy at age 60? Which country has the highest life expectancy after 60?
```
SELECT RegionDisplay, avg(Numeric) 
FROM `total-treat-428917-i1.homework3.homework3` 
WHERE MetricObserved='Life expectancy at age 60 (years)'
GROUP BY RegionDisplay
ORDER BY avg(NUmeric) DESC;
```

--4 Using a GROUP BY and a CASE-WEHEN, create a pivot table that shows the average life expectancy for all three types of MetricObserved (in three separate columns) by each region (each in a separate row)
```
SELECT RegionDisplay,
avg(CASE WHEN MetricObserved='Life expectancy at birth (years)' THEN Numeric ELSE 0 END) as LEAB,
avg(CASE WHEN MetricObserved='Healthy life expectancy (HALE) at birth (years)' THEN Numeric ELSE 0 END) as HLEAB,
avg(CASE WHEN MetricObserved='Life expectancy at age 60 (years)' THEN Numeric ELSE 0 END) as LE60
FROM `total-treat-428917-i1.homework3.homework3` 
GROUP BY RegionDisplay;
```

--5 Which countries have the highest average life expectancy at birth? 
```
select RegionDisplay,
avg(CASE WHEN MetricObserved='Life expectancy at birth (years)' THEN Numeric ELSE 0 END) as LEAB,
avg(CASE WHEN MetricObserved='Healthy life expectancy (HALE) at birth (years)' THEN Numeric ELSE 0 END) as HLEAB,
avg(CASE WHEN MetricObserved='Life expectancy at age 60 (years)' THEN Numeric ELSE 0 END) as LE60
FROM `total-treat-428917-i1.homework3.homework3` 
GROUP BY RegionDisplay
ORDER BY LEAB;
```

--6 Using three separate queries, check out which are the top 10 countries that consume the highest quantities of beer, wine and spirits respectively. 
```
SELECT CountryDisplay, avg(beer_servings)
FROM `total-treat-428917-i1.homework3.homework3` 
GROUP BY CountryDisplay
ORDER BY avg(beer_servings) DESC
limit 10;

SELECT CountryDisplay, avg(spirit_servings)
FROM `total-treat-428917-i1.homework3.homework3` 
GROUP BY CountryDisplay
ORDER BY avg(spirit_servings) DESC
limit 10;

SELECT CountryDisplay, avg(wine_servings)
FROM `total-treat-428917-i1.homework3.homework3` 
GROUP BY CountryDisplay
ORDER BY avg(wine_servings) DESC
limit 10;
```

--7 Now create a new variable that sums the average servings of beer + wine + spirit and call it “avg_alcohol_servings”; what are the top 10 countries that consume the highest quantities of alcohol overall?
```
SELECT CountryDisplay, avg(beer_servings)+avg(spirit_servings)+avg(wine_servings) as avg_alcohol_servings
FROM `total-treat-428917-i1.homework3.homework3` 
GROUP BY CountryDisplay
ORDER BY avg_alcohol_servings DESC
limit 10;
```

--8 With reference to the last query (last question), look at the country that consumed the highest quantity of alcohol overall, was it the first ranking country in terms of beer, wine or spirits? If not, was it in the top 10 of any of those 3 rankings (beer, wine or spirits)?
```
SELECT CountryDisplay, avg(beer_servings), avg(spirit_servings), avg(wine_servings), avg(beer_servings)+avg(spirit_servings)+avg(wine_servings) as avg_alcohol_servings
FROM `total-treat-428917-i1.homework3.homework3` 
GROUP BY CountryDisplay
ORDER BY avg_alcohol_servings DESC
limit 10;
```

--9 Which Country in Europe has the lowest life expectancy at birth?
```
SELECT CountryDisplay, round(avg(Numeric),2) 
FROM `total-treat-428917-i1.homework3.homework3` 
WHERE MetricObserved='Life expectancy at birth (years)' and RegionDisplay='Europe'
GROUP BY CountryDisplay
ORDER BY avg(NUmeric);
```

--10 Generally, women live longer than men, create a new variable that shows the difference between females and males life expectancy at birth and call it avg_LE_delta_gender; which country has the highest gap (in terms of years) between females and males? Are there any countries where men live more than women?
```
SELECT CountryDisplay, avg(CASE WHEN SexDisplay='Female' THEN Numeric ELSE 0 END) - avg(CASE WHEN SexDisplay='Male' THEN Numeric ELSE 0 END) as avg_LE_delta_gender
FROM `total-treat-428917-i1.homework3.homework3` 
WHERE MetricObserved='Life expectancy at birth (years)'
GROUP BY CountryDisplay, SexDisplay
ORDER BY avg_LE_delta_gender DESC;
```
```
SELECT CountryDisplay, avg(CASE WHEN SexDisplay='Female' THEN Numeric ELSE 0 END) - avg(CASE WHEN SexDisplay='Male' THEN Numeric ELSE 0 END) as avg_LE_delta_gender
FROM `total-treat-428917-i1.homework3.homework3` 
WHERE MetricObserved='Life expectancy at birth (years)'
GROUP BY CountryDisplay, SexDisplay
ORDER BY avg_LE_delta_gender;
```
