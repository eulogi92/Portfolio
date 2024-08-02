-- Calculate how many days have passed from the oldest Match to the most recent one

select 
date_diff(max(date), min(date), day) as days_passed
from db.match;

-- Produce a table which, for each Season and League Name, shows the following statistics about the home goals scored:  min average  mid-range  max  sum

select 
m.season, 
l.name,
min(m.home_team_goal) as min,
round(avg(m.home_team_goal),2) as avg, 
max(m.home_team_goal) as max,
sum(m.home_team_goal) as sum,
from db.match as m
  join db.leagues as l
  on m.league_id=l.id
group by m.season, l.name
order by sum DESC;

-- Show, for each Season, the number of matches played by each League

select
m.season, 
l.name,
count (m.id) as n_matches
from db.match as m
  join db.leagues as l
  on m.league_id=l.id
group by m.season, l.name;

-- Calculate the body mass index (BMI) of the players

select *,
round(weight/2.205,2) as kg_weight,
round(height/100,2) as m_height,
weight/2.205/((height/100)*(height/100)) as BMI
from db.playerBMI
where weight/2.205/((height/100)*(height/100)) between 18.5 and 24.9

-- 7 How many players do not have an optimal BMI (<18.5 or or >24.9)?

select *,
round(weight/2.205,2) as kg_weight,
round(height/100,2) as m_height,
weight/2.205/((height/100)*(height/100)) as BMI
from db.playerBMI
where weight/2.205/((height/100)*(height/100))<18.5 or weight/2.205/((height/100)*(height/100))>24.9


-- Identify which Team has scored the highest total number of goals (home + away) during the most recent available season
select
m.season, 
t.team_long_name,
sum(m.home_team_goal)+sum(m.away_team_goal) as tot_goals
from db.match as m
  join db.team as t
  on m.home_team_api_id=t.team_api_id or m.away_team_api_id=t.team_api_id
group by m.season, t.team_long_name
order by m.season DESC, tot_goals DESC;


--Create a query that, for each season, shows the name of the team that ranks first in terms of total goals scored. 

with tabella as (
  select *,
  rank() over (partition by season order by tot_goals DESC) as ranking_per_season
  from (  
    select
    m.season, 
    t.team_long_name,
    sum(m.home_team_goal)+sum(m.away_team_goal) as tot_goals
    from db.match as m
      join db.team as t
      on m.home_team_api_id=t.team_api_id or m.away_team_api_id=t.team_api_id
    group by m.season, t.team_long_name
    order by m.season, tot_goals DESC)
    order by season
)

select *
from tabella 
where ranking_per_season = 1

-- shows all the possible “pair combinations” between the top 10 teams in terms of total goals scored 

create table db.TopScorer as (
select
t.id,
t.team_long_name,
sum(m.home_team_goal)+sum(m.away_team_goal) as tot_goals
from db.match as m
  join db.team as t
  on m.home_team_api_id=t.team_api_id or m.away_team_api_id=t.team_api_id
group by t.id, t.team_long_name
order by tot_goals DESC
limit 10
)

create table db.TopScorer2 as (
select
t.id,
t.team_long_name,
sum(m.home_team_goal)+sum(m.away_team_goal) as tot_goals
from db.match as m
  join db.team as t
  on m.home_team_api_id=t.team_api_id or m.away_team_api_id=t.team_api_id
group by t.id, t.team_long_name
order by tot_goals DESC
limit 10
)

SELECT TopScorer.team_long_name, TopScorer2.team_long_name
FROM compito1.TopScorer
CROSS JOIN compito1.TopScorer2
WHERE TopScorer.team_long_name<>TopScorer2.team_long_name;
