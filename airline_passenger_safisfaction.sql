USE [Portfolio]
GO

-- Show rows
select *
from [dbo].[airline_passenger_satisfaction];

-- Count rows
select count(*) as counter
from [dbo].[airline_passenger_satisfaction];
-- comment: 129880 flights recorded

-- Apply filter: count number of delayed flights
select 
	count(*) as total_flights,
	sum(CASE WHEN Departure_Delay>60 THEN 1 END) as delayed_flights,
	sum(CASE WHEN Departure_Delay>60 THEN 1 END)*100/count(*) as delayed_perc
from [dbo].[airline_passenger_satisfaction];
-- comment: 6% of total flights have been delayed

-- Apply filter: calculate average departure delay of business class flights with Satisfaction = Satisfied
select avg("Departure_Delay") as avg_dep_delay
from [dbo].[airline_passenger_satisfaction]
where Class='Business' and Satisfaction='Satisfied';
-- comment: business flights rated as Satisfied feature average departure delay equal to 12 minutes 

-- Apply filter: calculate average departure delay of business class flights with Satisfaction = Satisfied
select Satisfaction, avg("Departure_Delay") as avg_dep_delay
from [dbo].[airline_passenger_satisfaction]
where Class='Business'
group by Satisfaction;
-- comment: less delay corresponds to an higher rating

-- Count flights based on the Satisfaction parameter
select Satisfaction, count(*) as counter
from [dbo].[airline_passenger_satisfaction]
group by Satisfaction;
-- comment: more people rated "Neutral or Dissatisfied" than "Satisfied"

-- Mean seat confort based on type of travel
select Type_of_travel, avg(Seat_comfort) as Avg_Seat_Comfort
from [dbo].[airline_passenger_satisfaction]
group by Type_of_travel;
-- comment: rating independent from flight class

-- Average age per flight based on class and gender
select Class, Gender, avg(Age) as avg_age
from [dbo].[airline_passenger_satisfaction]
group by Class, Gender;
-- comment: average age does not vary based on flight or gender

-- Average flight distance based on class and gender
select Class,  avg(Flight_Distance) as avg_distance
from [dbo].[airline_passenger_satisfaction]
group by Class;
-- comment: business class is preferred for longer flights