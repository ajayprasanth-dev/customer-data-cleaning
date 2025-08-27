-- Step 1: Count total rows
SELECT COUNT(*) AS total_rows FROM customers;

-- Step 1.1: Get table schema (columns + datatypes)
PRAGMA table_info(customers);

--Step 2: Missing values check (counts per column)
SELECT
sum(case when name is null or name='' then 1 else 0 end)AS missing_name_count,
sum(case when email is null or email='' then 1 else 0 end)AS missing_email_count,
sum(case when age is null or age='' then 1 else 0 end)AS missing_age_count,
sum(case when country is null or country='' then 1 else 0 end)AS missing_country_count,
sum(case when income is null or income ='' then 1 else 0 end)AS missing_income_count,
sum(case when join_date is null or join_date='' then 1 else 0 end)AS missing_join_date_count
from  messy_dataset;

---- Step 3: Check Missing Value Percentages for each column
SELECT
    (SUM(CASE WHEN name IS NULL OR name='' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS missing_name_percentage,
    (SUM(CASE WHEN email IS NULL OR email='' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS missing_email_percentage,
    (SUM(CASE WHEN age IS NULL OR age='' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS missing_age_percentage,
    (SUM(CASE WHEN country IS NULL OR country='' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS missing_country_percentage,
    (SUM(CASE WHEN income IS NULL OR income='' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS missing_income_percentage,
    (SUM(CASE WHEN join_date IS NULL OR join_date='' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS missing_join_date_percentage
FROM messy_dataset;

-- Step 4: Count unique values in each column
select 
count(DISTINCT name)as unique_name_count,
count(DISTINCT email)as unique_email_count,
count(DISTINCT age)as unique_age_count,
count(DISTINCT country)as unique_country_count,
count(DISTINCT income)as unique_income_count,
count(DISTINCT join_date)as unique_joindate_count
from messy_dataset;
 

-- Step 5: Anamolies detection(Age column)

 --step 5.1:min and max values
SELECT
    MAX(CAST(age AS INTEGER)) AS max_age,
    MIN(CAST(age AS INTEGER)) AS min_age
FROM messy_dataset
WHERE age IS NOT NULL AND age != '';

-- step 5.2:Detect non-numeric age values
SELECT age, COUNT(*) AS count_age
FROM messy_dataset
WHERE age NOT GLOB '[0-9]*' AND age != '' AND age IS NOT NULL
GROUP BY age;

-- step 5.3:Detect negative or unrealistic ages
SELECT age
FROM messy_dataset
WHERE CAST(age AS INTEGER) < 0
   OR CAST(age AS INTEGER) > 100;

-- step 6:Anomolies detection for income column

-- step 6.1: find min and max income values
SELECT min(income)as min_income,max(income)as max_income
from messy_dataset
where income is not NULL;

--step 6.2: Detect negative income values
SELECT income,count(*)as count
from messy_dataset
where income<0
GROUP by income;

--step 7:Anomolies detection for email column

--step 7.1: find duplicates
SELECT email,count(*) as count
from messy_dataset
GROUP by email
HAVING count>1;

--step 7.2: check invalid emails
SELECT email from messy_dataset
where email not like '%@%'or '%.%';


--step 8:Anomolies detection for country column

--step 8.1 Count occurrences of each country
SELECT country,count(*) FROM messy_dataset
where country is NOT NULL
GROUP by country
ORDER by count(*) desc;

--step 8.2 List distinct countries to identify inconsistencies
SELECT DISTINCT country from messy_dataset
WHERE country is NOT NULL;


--step 9:Anomolies detection for join_date column

--step 9.1:


SELECT
min(join_date),max(join_date)
from messy_dataset
WHERE join_date is NOT NULL and join_date!='';


SELECT join_date 
from messy_dataset
where join_date not glob '[0-9][0-9][0-9[0-9]-[0-9][0-9]-[0-9][0-9]' 
AND join_date is NOT NULL 
and join_date!='';


SELECT name, COUNT(*) AS count_name
FROM messy_dataset
WHERE name IS NOT NULL AND name != ''
GROUP BY name
HAVING COUNT(*) > 1;



