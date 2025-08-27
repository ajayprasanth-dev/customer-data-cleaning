-- Capitalize first letter of name
UPDATE messy_dataset
SET name=upper(substr(name,1,1)) || lower(substr(name,2))
WHERE name!='' AND name IS NOT NULL;

-- Count empty or NULL names
SELECT count(*) 
FROM messy_dataset
WHERE name='' AND name IS NULL;

-- Trim spaces + lowercase emails
UPDATE messy_dataset
SET email=lower(trim(email))
WHERE email!='' AND email IS NOT NULL;

-- Find invalid emails (missing '@' or '.')
SELECT email 
FROM messy_dataset
WHERE email NOT LIKE '%@%' OR 
      email NOT LIKE '%.%';

-- Append "@gmail.com" if missing
UPDATE messy_dataset
SET email=email || '@gmail.com'
WHERE email NOT LIKE '%@%' OR 
      email NOT LIKE '%.%';

-- Find duplicate emails
SELECT email, count(*)
FROM messy_dataset
WHERE email IS NOT NULL
GROUP BY email
HAVING count(*)>1;

-- Remove duplicate emails (keep first)
DELETE FROM messy_dataset
WHERE ROWID NOT IN 
( SELECT min(rowid) FROM messy_dataset GROUP BY email);

-- Remove unrealistic ages >100
UPDATE messy_dataset
SET age = NULL
WHERE CAST(age AS INTEGER) > 100
  AND age GLOB '[0-9]*';

-- Remove unrealistic ages <0
UPDATE messy_dataset
SET age = NULL
WHERE CAST(age AS INTEGER) < 0
  AND age GLOB '-[0-9]*';

-- Convert age text to integer
UPDATE messy_dataset
SET age = CAST(age AS INTEGER)
WHERE age GLOB '[0-9]*';

-- Replace NULL age with 'unknown'
UPDATE messy_dataset
SET age = 'unknown'
WHERE age IS NULL;

-- Convert country to uppercase
UPDATE messy_dataset
SET country=upper(country);

-- Standardize country → United States
UPDATE messy_dataset
SET country='United States'
WHERE country IN ('USA','U.S.A','us');

-- Standardize country → United Kingdom
UPDATE messy_dataset
SET country='United Kingdom'
WHERE country ='UK';

-- Standardize country → Brazil
UPDATE messy_dataset
SET country ='Brazil'
WHERE country='Brasil';

-- Replace NULL country with 'Unknown'
UPDATE messy_dataset
SET country ='Unknown'
WHERE country IS NULL;

-- Set negative incomes to NULL
UPDATE messy_dataset
SET income= NULL
WHERE income <0;

-- Check distinct join dates
SELECT DISTINCT join_date 
FROM messy_dataset;

-- Replace '/' with '-' in join_date
UPDATE messy_dataset
SET join_date = REPLACE(join_date, '/', '-')
WHERE join_date LIKE '%/%';

-- Format join_date: YYYYMMDD → YYYY-MM-DD
UPDATE messy_dataset
SET join_date = substr(join_date, 1, 4) || '-' ||
                substr(join_date, 5, 2) || '-' ||
                substr(join_date, 7, 2)
WHERE length(join_date) = 8;

-- Format join_date: DD-MM-YYYY → YYYY-MM-DD
UPDATE messy_dataset
SET join_date = substr(join_date, 7, 4) || '-' ||  
                substr(join_date, 4, 2) || '-' ||  
                substr(join_date, 1, 2)            
WHERE join_date LIKE '__-__-____';

-- Re-run formatting for DD-MM-YYYY → YYYY-MM-DD
UPDATE messy_dataset
SET join_date = substr(join_date, 7, 4) || '-' || substr(join_date, 4, 2) || '-' || substr(join_date, 1, 2)
WHERE join_date LIKE '__-__-____';

-- Create cleaned dataset table
CREATE TABLE cleaned_dataset (
    name TEXT,
    email TEXT,
    age INTEGER,
    country TEXT,
    income REAL,
    join_date TEXT
);

-- Insert cleaned data into new table
INSERT INTO cleaned_dataset (name, email, age, country, income, join_date)
SELECT 
    name,
    email,
    CASE 
        WHEN age GLOB '[0-9]*' THEN CAST(age AS INTEGER)
        ELSE NULL
    END AS age,
    country,
    income,
    join_date
FROM messy_dataset;
