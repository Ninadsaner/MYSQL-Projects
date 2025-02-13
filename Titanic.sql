create database titanic;

use titanic;

select * from titanic;

-- How many passengers are in the Titanic dataset? 

SELECT COUNT(*) FROM titanic;

-- What are the distinct classes of passengers onboard? 

select * from titanic;

select distinct class from titanic;

-- How many passengers survived the Titanic disaster?

select count(*) from titanic where survived = 1;

-- What is the average age of passengers onboard?

select avg(age) from titanic;

-- How many male passengers were there?

select count(*) from titanic;

-- What is the highest fare paid for a ticket?
select * from titanic;

select max(fare) from titanic;

-- How many siblings/spouses were onboard for each passenger?

select sum(sibsp) from titanic;

-- What is the percentage of passengers who survived? 
select * from titanic;

SELECT (COUNT(CASE WHEN Survived = 1 THEN 1 END) / COUNT(*)) * 100 AS survival_percentage
FROM titanic;

-- What is the most common port of embarkation?

select * from titanic;

select max(embark_town) from titanic;


SELECT embark_town, COUNT(*) AS num_passengers
FROM titanic GROUP BY embark_town
ORDER BY num_passengers DESC
LIMIT 1;

-- What is the most common port of embarkation?
SELECT embark_town, COUNT(*) AS num_passengers
FROM titanic GROUP BY embark_town
ORDER BY num_passengers DESC
LIMIT 1 offset 1;


-- How many passengers have missing values for the 'age' column? 

select * from titanic;

SELECT 
    COUNT(*) AS missing_age_count
FROM 
    titanic
WHERE 
age IS NULL;
    
    
-- What is the survival rate among passengers in each class? 
select * from titanic;

select class, (count(case when survived=1 then 1 end))/count(*) * 100 as percentage_of_survied_by_class from titanic
group by class;

-- What is the average fare paid by passengers who survived vs. those who didn't?
    select * from titanic;
select survived,avg(fare) from titanic group by survived;

-- What is the age distribution of passengers who survived?
select * from titanic;
-- SELECT 
--     MIN(age) AS Min_Age,
--     MAX(age) AS Max_Age,
--     AVG(age) AS Avg_Age,
--     STDDEV(age) AS StdDev_Age,
--     PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY age) AS Q1,
--     PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY age) AS Median,
--     PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY age) AS Q3
-- FROM titanic
-- WHERE Survived = 1 AND Age IS NOT NULL;

-- How many passengers traveled alone (without siblings/spouses or parents/children)?

select * from titanic;

select count(*) as alone from titanic where alone= False and parch=0;

-- What is the average fare paid by passengers from each port of embarkation?
select embark_town, avg(fare) from titanic 
group by embark_town;

-- What is the survival rate among passengers of different age groups (e.g., children,
-- adults, elderly)?

select * from titanic;

SELECT CASE
        WHEN age < 18 THEN 'Children'
        WHEN age BETWEEN 18 AND 64 THEN 'Adults'
        ELSE 'Elderly'
    END AS Age_Group,
    AVG(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Survival_Rate
FROM titanic
WHERE age IS NOT NULL
GROUP BY Age_Group;

-- What is the survival rate among male vs. female passengers in each class?

select * from titanic;
SELECT 
    class,
    Sex,
    AVG(CASE WHEN survived = 1 THEN 1 ELSE 0 END) AS Survival_Rate
FROM titanic
GROUP BY class, sex;

-- What is the average age of passengers who survived vs. those who didn't? 

select survived, avg(age) from titanic
group by survived;


-- How many passengers have siblings/spouses onboard but no parents/children?

select * from titanic;

select count(*) from titanic where sibsp > 0 and parch =0;

-- What is the survival rate among passengers with different numbers of siblings/spouses?
select * from titanic;
select sibsp, avg(survived) from titanic 
group by sibsp order by sibsp;


-- What is the survival rate among passengers of different age groups and genders? 
select * from titanic;


SELECT CASE
        WHEN age < 18 THEN 'Children'
        WHEN age BETWEEN 18 AND 64 THEN 'Adults'
        ELSE 'Elderly'
    END AS Age_Group,
    sex,
    AVG(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Survival_Rate
FROM titanic
GROUP BY Age_Group, sex
ORDER BY Age_Group, sex;


-- What is the survival rate among passengers who paid high vs. low fares, considering
-- each class separately?

select avg(fare) from titanic;

select 