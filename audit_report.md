# Data Cleaning Audit Report

## Dataset Overview
- Total Rows: 50
- Total Columns: 6
### Columns
1. name (TEXT)
2. email (TEXT)
3. age (TEXT)
4. country (TEXT)
5. income (REAL)
6. join_date (TEXT)

## Column Audit 


| Column   | Missing % | Unique Values  |
|----------|-----------|--------------- |
| name     |   0%      |    17          |    
| email    |   4%      |    47          |              
| age      |   4%      |    41          |         
| country  |   4%      |    11          |   
| income   |   2%      |    07          |                
|join_date |   24%     |    04          |

## 🔎 Anomalies

Age Column
- Min Age: -3 
- Max Age: 130  
- Detected Issues:
  - Ages below 10 (e.g., 3) might be unrealistic for customers.
  - Ages above 100 (e.g., 116, 119, 122, 124, 130) are possible outliers.
  - Negative ages detected: -2, -3.
  - Non-numeric / invalid age values also found.

✅ Action: Clean or remove negative ages, verify extreme ages >100, standardize numeric conversion.

### Income Column Anomalies

- **Min Income:** -1000.0  
- **Max Income:** 75000.0  

**Detected Issues:**
- Negative income value: -1000.0 appears **5 times** → invalid entries, need cleaning.
- Maximum income 75000.0 → seems reasonable.

✅ Action:
- Replace all negative income values (-1000.0) with NULL or appropriate value.

### Email Column Anomalies

**Detected Issues:**
1. Duplicate emails:
   - eva73@gmail.com → appears 2 times
2. Missing emails:
   - 2 rows have blank/missing email
3. inavlid emails
  - hannah44
  - frank94
  - alice48

✅ Action:
- Remove or correct duplicate emails.
- Fill missing emails if possible, or set to NULL.
- Check duplicate names combined with email → if exact same record exists, remove duplicates.


### Country Column Anomalies

**Detected Issues:**
- Inconsistent country names and casing:
  - USA / U.S.A / us
  - United Kingdom / UK
  - Brazil / Brasil
- Abbreviations used instead of full names:
  - IND → should be India

✅ Action:
- Standardize country names (consistent casing, full names)
- Correct spelling mistakes (e.g., Brasil → Brazil, IND → India)
- Merge duplicates after standardization


### Join Date Column Anomalies

- Found 4 distinct date formats:
  - `05-12-2023` (ambiguous, could be DD-MM-YYYY or MM-DD-YYYY)
  - `2023-05-12` (correct, ISO format)
  - `20230512` (compact YYYYMMDD format)
  - `12/05/2023` (DD/MM/YYYY format)

⚠️ Issue: Multiple date formats reduce consistency and may cause errors in analysis.
✅ Plan: Standardize all dates into `YYYY-MM-DD`.

### Name Column Anomalies

**Detected Issues:**
- Duplicate names detected:
  - Alice → 6 times
  - Bob → 5 times
  - Charlie → 3 times
  - David → 5 times
  - Eva → 4 times
  - Frank → 5 times
  - Grace → 6 times
  - Hannah → 3 times
  - Ian → 5 times
  - Jack → 3 times
  - frank → 2 times (note case difference)
  
✅ Action:
- Consider removing duplicate records if they represent the same person.
- Standardize casing (e.g., `Frank` and `frank`) to avoid duplicates due to case differences.






