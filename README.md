# Customer Drop-off Analysis – SQL Data Cleaning

This project focuses on cleaning a raw and messy dataset using SQL.  
The dataset contained common real-world issues such as null values, duplicate entries, inconsistent date formats, invalid ages, and country name variations.  
The objective was to prepare a **clean and reliable dataset** for further analysis.


## Project Overview
- **Tool Used:** SQLite (DB Browser for SQLite)  
- **Dataset Fields:** `name`, `email`, `age`, `country`, `income`, `join_date`  
- **Output:** A new table `cleaned_dataset` with consistent formats and valid values  


##  Step 1 – Data Audit
Before starting the cleaning process, I performed a full audit of the dataset.  

**Findings:**
- **Name column:** Mixed casing (e.g., `ajay`, `SMITH`), some empty/null values.  
- **Email column:** Contained uppercase letters, extra spaces, missing `@` or `.` symbols, and duplicates.  
- **Age column:** Invalid values such as negatives, numbers above 100, and non-numeric text.  
- **Country column:** Inconsistent naming like `USA`, `U.S.A`, `us`, `UK`, `Brasil`, etc.  
- **Income column:** Contained negative values.  
- **Join date column:** Multiple formats (`05-12-2023`, `2023-05-12`, `20230512`, `12/05/2023`).  

## Step 2 – Cleaning Process

### 1. Name Standardization
- Converted first letter uppercase, rest lowercase (`ajay` → `Ajay`).  
- Left null or empty values as they are (instead of filling with placeholders).

### 2. Email Cleaning
- Trimmed spaces and converted all emails to lowercase.  
- Fixed records missing `@` or `.` by appending `@gmail.com`.  
- Removed duplicate emails, keeping only the first occurrence.

### 3. Age Correction
- Replaced invalid ages (negative numbers, >100) with `NULL`.  
- Converted numeric text values into integers.  
- For missing values, kept as `NULL` (instead of inserting `"unknown"`).  

**Why keep NULL?**  
Using `NULL` maintains integrity. Replacing with `"unknown"` or fake numbers could mislead later analysis (e.g., in averages). Nulls allow analysts to clearly identify missing information.

### 4. Country Standardization
- Converted all country names to uppercase.  
- Standardized common variations:
  - `USA`, `U.S.A`, `us` → `UNITED STATES`  
  - `UK` → `UNITED KINGDOM`  
  - `Brasil` → `BRAZIL`  
- Replaced missing values with `UNKNOWN`.

### 5. Income Cleaning
- Replaced negative income values with `NULL`.  

### 6. Join Date Formatting
- Unified all formats into `YYYY-MM-DD` (international ISO standard).  
  - Replaced `/` with `-`.  
  - Converted compact dates (`20230512` → `2023-05-12`).  
  - Standardized `DD-MM-YYYY` and `MM-DD-YYYY` into ISO format.  
- Rows with invalid/unreadable dates were set to `NULL`.

## Step 3 – Creating Cleaned Dataset
Finally, created a new table `cleaned_dataset` with consistent data types:  
- `name` → TEXT  
- `email` → TEXT  
- `age` → INTEGER  
- `country` → TEXT  
- `income` → REAL  
- `join_date` → TEXT (ISO format)  


## ✅ Final Notes
- **Null values were intentionally kept** when true information was missing. This prevents introducing incorrect assumptions.  
- The cleaned dataset is now ready for reliable analysis and visualization.  
- This workflow simulates a **real-world data cleaning process** where raw inputs are messy and require multiple validation steps.  

