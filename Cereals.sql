create database cereals;

use cereals;

select * from cereals_data;

select *, name as fast from cereals_data;


-- Describe the schema of table

Describe cereals_data;

-- 3. Create view name as see where users can not see type column [first run appropriate query 
-- then create view]
select * from cereals_data;
CREATE VIEW see AS
SELECT name, mfr, calories, protein, fat, sodium, fiber, carbo, sugars, potass, vitamins, shelf, weight, cups, rating
FROM cereals_data;

select * from cereals_data;

-- Count how many are cold cereals 

select count(type) from cereals_data where type = 'C';

-- Count how many cereals are kept in shelf 3

select * from cereals_data;

select count(shelf) from cereals_data where shelf = 3;

-- Arrange the table from high to low according to ratings

select * from cereals_data order by rating;

-- Suggest some column/s which can be Primary key

-- Name can be primary key

-- Find average of calories of hot cereal and cold cereal in one query
select * from cereals_data;
select avg(case when type = 'C' then calories else null end) as avg_calories_C, 
avg(case when type = 'H' then calories else null end) as avg_calories_H
from cereals_data;

-- Add new column as HL_Calories where more than average calories should be categorized as 
-- HIGH and less than average calories should be categorized as LOW
select * from cereals_data; 
ALTER TABLE cereals_data ADD COLUMN HL_Calories VARCHAR(10);
SET @avg_calories = (SELECT AVG(calories) FROM cereals_data);

update cereals_data set HL_Calories = case when calories > @avg_calories then 'High' 
when calories < @avg_calories then 'Low' end;

select * from cereals_data;

-- List only those cereals whose name begins with B

select name from cereals_data where name like 'B%';

-- List only those cereals whose name begins with F

select name from cereals_data where name like 'F%';

-- List only those cereals whose name ends with s

select name from cereals_data where name like '%s';

-- Select only those records which are HIGH in column HL_calories

select * from cereals_data where HL_Calories = 'HIGH';

 -- Find maximum of ratings
 
 select max(rating) from cereals_data;
 
 -- Find average ratings of those were High and Low calories
 
 select * from cereals_data;
 select avg(case when HL_Calories = 'High' then rating else null end) as High_Avg_ratings, 
 avg(case when HL_Calories = 'Low' then rating else null end) as Low_Avg_ratings from cereals_data;
 
 -- Remove column fat 
 
ALTER TABLE cereals_data
DROP COLUMN fat;

-- Count records for each manufacturer [mfr] 
select * from cereals_data;

SELECT mfr, COUNT(*) AS record_count
FROM cereals_data
GROUP BY mfr;

-- Select name, calories and ratings only

select name, calories, rating from cereals_data;

-- Craete 1 examples of Sub Queries of your choice
SELECT name, calories
FROM cereals_data
WHERE calories > (SELECT AVG(calories) FROM cereals_data);

