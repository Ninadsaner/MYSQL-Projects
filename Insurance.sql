create database insurance;
use insurance;

-- 1. Count for each categories of ‘region 

select * from insurance;

-- 1. Count for each categories of region

select distinct region from insurance;

-- Find 50 records of highest ‘age’ and export data/table to desktop 

select age from insurance limit 50;

-- Add index name ‘quick’ on ‘id’

select * from insurance; 

select * from insurance where id as 'quick';

CREATE INDEX quick ON insurance(id);

select * from quick;

-- Describe the schema of table 

describe insurance;

-- Create view name as ‘gender’ where users can not see ‘sex’ [Hint: first run
-- appropriate query then create view]
select * from insurance;

CREATE VIEW gender AS
SELECT id, age, bmi, children, smoker, region, charges
FROM insurance;

select * from gender;

-- 6. Rename the view as ‘type’

drop view if exists gender;

select * from gender;
create view type as 
select id, age, bmi, children, smoker, region, charges
FROM insurance;
select * from type;

-- Count how many are ‘northwest’ insurance holders 
select count(region) from insurance where region ='northwest';
select count(region) from insurance;

-- 8. Count how many insurance holders were ‘femail’

 
 select count(sex) as Total_female from insurance where sex='female';
select sex, count(smoker) from insurance where sex='female' group by sex;



-- Create Primary key on a suitable column

select * from insurance;
ALTER TABLE insurance
ADD CONSTRAINT id PRIMARY KEY (id);

-- Create a new column ‘ratio’ which is age multiply by bmi

ALTER TABLE insurance
ADD COLUMN ratio DECIMAL(10, 2);

-- Update the new column with the calculated values
UPDATE insurance
SET ratio = age * bmi;

-- Arrange the table from high to low according to charges

select * from insurance order by charges desc;

-- Find MAX of ‘charges’

select max(charges) from insurance;

--  Find MIN of ‘charges’

select min(charges) from insurance;

-- Find average of ‘charges’ of male and female
select * from insurance;

select sex, avg(charges) from insurance group by sex;

-- Write a Query to rename column name sex to Gender

ALTER TABLE insurance
CHANGE COLUMN sex gender VARCHAR(10);

-- Add new column as HL_Charges where more than average charges should be
-- categorized as HIGH and less than average charges should be categorized as LOW

ALTER TABLE insurance
ADD COLUMN HL_Charges VARCHAR(4);

-- Step 2: Calculate the average charges and update the new column
WITH avg_charges AS (
    SELECT AVG(charges) AS avg_charges_value
    FROM insurance
)
UPDATE insurance
SET HL_Charges = CASE
    WHEN charges > (SELECT avg_charges_value FROM avg_charges) THEN 'HIGH'
    ELSE 'LOW'
END;

select * from insurance;

-- show top 20 record 

select * from insurance limit 20;

-- show bottom 20

select * from insurance order by id desc limit 20;


-- 20. Randomly select 20% of records 
select * from insurance;

SELECT *
FROM insurance
WHERE RAND() <= 0.2;

-- Remove column ‘ratio’

ALTER TABLE insurance
DROP COLUMN ratio;

-- Create a view called Female_HL_Charges that shows only those data where
-- HL_Charges is High, Female, Smokers and with 0 children
create view type as 
select id, age, bmi, children, smoker, region, charges
FROM insurance;
select * from type;

select * from insurance;

DROP VIEW Female_HL_Charges;

create view Female_HL_Charges as
select HL_Charges = 'HIGH' as HL_Charges, gender = 'female' as gender , smoker='yes' as smoker, children = 0 as children  
from insurance;

select * from Female_HL_Charges ;

-- Update children column if there is 0 children then make it as Zero Children, if 1
-- then one_children, if 2 then two_children, if 3 then three_children, if 4 then
-- four_children if 5 then five_children else print it as More_than_five_children.

UPDATE insurance
SET children = CASE
    WHEN children = 0 THEN 'Zero_Children'
    WHEN children = 1 THEN 'One_Children'
    WHEN children = 2 THEN 'Two_Children'
    WHEN children = 3 THEN 'Three_Children'
    WHEN children = 4 THEN 'Four_Children'
    WHEN children = 5 THEN 'Five_Children'
    ELSE 'More_Than_Five_Children'
END;
