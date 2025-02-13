create database clinictrial;


use clinictrial;
-- Find average age of those were pregnant and not pregnant
    
select * from clinictrial;

select avg(case when Pregnant = 'yes' then age else NULL end) as avg_pregnant, 
avg(case when Pregnant ='no' then age else null end) as age_non_pregnant from clinictrial;

-- Find average blood pressure of those had drug reaction and did not had drug reaction
select * from clinictrial;

select avg(case when Drug_Reaction = 'no' then BP else null end) as BP_when_drug_reaction,
avg(case when Drug_Reaction = 'yes' then BP else null end) as BP_when_No_drug_reaction from clinictrial;

-- Add new column name as ‘Age_group’ and those having age between 16 & 21
-- should be categorized as Low, more than 21 and less than 35 should be
-- categorized as Middle and above 35 should be categorized as High.


ALTER TABLE your_table_name
ADD COLUMN Age_group VARCHAR(10);

UPDATE your_table_name
SET Age_group = CASE 
                   WHEN age BETWEEN 16 AND 21 THEN 'Low'
                   WHEN age > 21 AND age < 35 THEN 'Middle'
                   WHEN age >= 35 THEN 'High'
                   ELSE 'Unknown'
               END;
               
select * from clinictrial;

Alter table clinictrial 
add column agr_group varchar(10);

-- Add new column name as ‘Age_group’ and those having age between 16 & 21
-- should be categorized as Low, more than 21 and less than 35 should be
-- categorized as Middle and above 35 should be categorized as High.

update clinictrial set agr_group =
case when age between 16 and 21 then 'Low'
when age >21 and age < 35 then 'middle'
when age > 35 then 'high' end;

-- Change ‘Age’ of Reetika to 32

update clinictrial set age = 32 where name = 'Reetika';

-- Change name of Reena as Shara’

update clinictrial set name = 'Reena' where name = 'Shara';

-- Remove Chlstrl column

select * from clinictrial;

ALTER TABLE clinictrial
DROP COLUMN Chlstrl;

-- 12. Select only Name, Age and BP
select name,age,BP from clinictrial;

-- Select ladies whose first name starts with ‘E’

select * from clinictrial where name like 'e%';

-- Select ladies whose Age_group were Low

select * from clinictrial where agr_group = 'Low';

-- Select ladies whose Age_group were High

select * from clinictrial where agr_group = 'High';

-- Select ladies whose name starts with ‘A’ and those were pregnant

select * from clinictrial where name like 'A%' and pregnant = 'yes';

-- Identify ladies whose BP was more than 120

select name from clinictrial where BP > 120;

-- Identify ladies whose BP was between 100 and 120
select * from clinictrial;
select name from clinictrial where BP between 100 and 120;

-- Identify ladies who had low anxiety aged less than 30

select name from clinictrial where Anxty_LH = 'no' and age < 30;

-- Select ladies whose name ends with ‘i’

select name from clinictrial where name like '%i';

-- Select ladies whose name ends with ‘a’

select name from clinictrial where name like '%a';

-- Select ladies whose name starts with ‘K’

select name from clinictrial where name like 'K%';

-- Select ladies whose name have ‘a’ anywhere

select name from clinictrial where name like "%a%";

-- Order ladies in ascending way based on ‘BP’

select name from clinictrial order by BP asc;

-- Order ladies in descending way based on ‘Age’

select name from clinictrial order by age;