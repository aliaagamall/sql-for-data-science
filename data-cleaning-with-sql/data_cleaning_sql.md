# SQL Data Cleaning 

This document demonstrates common SQL data cleaning and preprocessing techniques using a sample `CustomerInfo` table. Each step includes a SQL query, a simple explanation, and the resulting data or output. The goal is to transform a messy dataset into a clean, consistent one, addressing issues like NULLs, duplicates, inconsistent formats, and incorrect data types.

## Initial Dataset

The `CustomerInfo` table contains customer data with issues like NULL values, duplicates, inconsistent formats, extra spaces, and incorrect data types

### Step 1: Display Initial Data

**Explanation**: This query shows the initial state of the `CustomerInfo` table to understand its structure and issues (e.g., NULLs, duplicates, inconsistent formats).

```sql
SELECT * FROM CustomerInfo;
```

**Output**:

| customer_id | full_name | email | phone | registration_date | age | city |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | John Doe | john.doe@email.com | 555-0101 | 2023-01-15 | 30 | New York |
| 2 | Jane Smith | jane.smith@email.com | NULL | 01/20/2023 | 25 | Los Angeles |
| 3 | John Doe | john.doe@email.com | 555-0101 | 2023-01-15 | 30 | New York |
| 4 | Mary Johnson | NULL | 555-0103 | 2023/02/10 | 28 | Chicago |
| 5 | mike brown | mike.brown@email.com | 555-0104 | 02-25-2023 | NULL | Houston |
| 6 | Sarah Wilson | sarah.wilson@email.com | 5550105 | 2023-03-01 | 35 | NULL |
| 7 | James Lee | NULL | 555-0106 | 03/15/2023 | 40 | Phoenix |
| 8 | john DOE | john.doe@email.com | 555-0101 | 2023-01-15 | 30 | New York |
| 9 | Emma Davis | emma.davis@email.com | 555-0107 | NULL | 22 | San Diego |
| 10 | Robert Miller | robert.miller@email.com | NULL | 2023-04-10 12:00:00 | 27 | Dallas |
| 11 | Lisa Taylor | lisa.taylor@email.com | 555-0109 | 2023-04-20 | NULL | Miami |
| 12 | david Wilson | david.wilson@email.com | 555-0110 | 2023/05/01 | 45 | Seattle |
| 13 | John Doe | JOHN.DOE@email.com | 555-0101 | 2023-01-15 | 30 | New York |
| 14 | AnnaSmith | NULL | 555-0111 | 05/30/2023 | 29 | Boston |
| 15 | Tom Clark | tom.clark@email.com | 555-0112 | 2023-06-15 | abc | Austin |
| 16 | Sophie Brown | sophie.brown@email.com | 5550113 | 2023-06-15 | 33 | Denver |
| 17 | WILLIAM KING | NULL | 555-0114 | 2023/07/01 | 50 | Atlanta |
| 18 | Clara | clara.jones@email.com | NULL | 07-10-2023 | 26 | Portland |
| 19 | Mark Evans | mark.evans@email.com | 555-0116 | NULL | 31 | San Francisco |
| 20 | Laura Adams | laura.adams@email.com | 555-0117 | 2023-08-20 | 24 | NULL |

---

### Step 2: Clean full_name Column

**Explanation**: This step trims extra spaces from `full_name` and converts it to lowercase for consistency. A second query removes extra spaces between words (e.g., "John Doe" becomes "john doe").

```sql
-- Trim leading/trailing spaces and convert to lowercase
UPDATE CustomerInfo
SET full_name = LOWER(TRIM(full_name));

-- Remove extra spaces between words
UPDATE CustomerInfo
SET full_name = REPLACE(full_name, '  ', ' ');
```

**Output** (after `SELECT customer_id, full_name FROM CustomerInfo`):

| customer_id | full_name |
| --- | --- |
| 1 | john doe |
| 2 | jane smith |
| 3 | john doe |
| 4 | mary johnson |
| 5 | mike brown |
| 6 | sarah wilson |
| 7 | james lee |
| 8 | john doe |
| 9 | emma davis |
| 10 | robert miller |
| 11 | lisa taylor |
| 12 | david wilson |
| 13 | john doe |
| 14 | anna smith |
| 15 | tom clark |
| 16 | sophie brown |
| 17 | william king |
| 18 | clara |
| 19 | mark evans |
| 20 | laura adams |

**Note**: Names are now lowercase, spaces are trimmed, and extra spaces between words are removed.

---

### Step 3: Clean email Column

**Explanation**: This query trims spaces from `email` and converts it to lowercase to standardize the format.

```sql
UPDATE CustomerInfo
SET email = LOWER(TRIM(email));
```

**Output** (after `SELECT customer_id, email FROM CustomerInfo`):

| customer_id | email |
| --- | --- |
| 1 | john.doe@email.com |
| 2 | jane.smith@email.com |
| 3 | john.doe@email.com |
| 4 | NULL |
| 5 | mike.brown@email.com |
| 6 | sarah.wilson@email.com |
| 7 | NULL |
| 8 | john.doe@email.com |
| 9 | emma.davis@email.com |
| 10 | robert.miller@email.com |
| 11 | lisa.taylor@email.com |
| 12 | david.wilson@email.com |
| 13 | john.doe@email.com |
| 14 | NULL |
| 15 | tom.clark@email.com |
| 16 | sophie.brown@email.com |
| 17 | NULL |
| 18 | clara.jones@email.com |
| 19 | mark.evans@email.com |
| 20 | laura.adams@email.com |

**Note**: Emails are now lowercase and trimmed.

---

### Step 4: Count NULLs per Column

**Explanation**: This query dynamically counts NULL values in each column of `CustomerInfo`. It uses `INFORMATION_SCHEMA.COLUMNS` to iterate over columns and builds a query to count NULLs.

```sql
DECLARE @table_name NVARCHAR(MAX) = 'CustomerInfo';
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql = @sql + 
    'SELECT ''' + COLUMN_NAME + ''' AS column_name, COUNT(*) AS null_count FROM ' + @table_name + 
    ' WHERE [' + COLUMN_NAME + '] IS NULL UNION ALL '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @table_name;
SET @sql = LEFT(@sql, LEN(@sql) - 10);
EXEC sp_executesql @sql;
```

**Output**:

| column_name | null_count |
| --- | --- |
| customer_id | 0 |
| full_name | 0 |
| email | 4 |
| phone | 4 |
| registration_date | 2 |
| age | 2 |
| city | 2 |

**Note**: This confirms 4 NULLs in `email`, 4 in `phone`, 2 in `registration_date`, and 2 in `age`. These will be addressed next.

---

### Step 5: Replace NULLs in city Column

**Explanation**: This query replaces NULL values in the `city` column with 'not available' to ensure no missing values.

```sql
UPDATE CustomerInfo
SET city = 'not available'
WHERE city IS NULL;
```

**Output** (after `SELECT customer_id, city FROM CustomerInfo WHERE city = 'not available'`):

| customer_id | city |
| --- | --- |
| 6 | not available |
| 20 | not available |

**Note**: Two rows (customer_id 6 and 20) had their `city` values updated from NULL to 'not available'.

---

### Step 6: Replace NULLs in phone Column

**Explanation**: This query replaces NULL values in the `phone` column with 'not available' for consistency.

```sql
UPDATE CustomerInfo
SET phone = 'not available'
WHERE phone IS NULL;
```

**Output** (after `SELECT customer_id, phone FROM CustomerInfo WHERE phone = 'not available'`):

| customer_id | phone |
| --- | --- |
| 2 | not available |
| 10 | not available |
| 14 | not available |
| 18 | not available |

**Note**: Four rows had their `phone` values updated from NULL to 'not available'.

---

### Step 7: Replace NULLs in email Column

**Explanation**: This query replaces NULL values in the `email` column with 'Not Available' to handle missing emails.

```sql
UPDATE CustomerInfo
SET email = 'Not Available'
WHERE email IS NULL;
```

**Output** (after `SELECT customer_id, email FROM CustomerInfo WHERE email = 'Not Available'`):

| customer_id | email |
| --- | --- |
| 4 | Not Available |
| 7 | Not Available |
| 14 | Not Available |
| 17 | Not Available |

**Note**: Four rows had their `email` values updated from NULL to 'Not Available'.

---

### Step 8: Show Data Types

**Explanation**: This query checks the data types of all columns to identify any that need correction (e.g., `age` as VARCHAR, `registration_date` as VARCHAR).

```sql
SELECT column_name, data_type, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'CustomerInfo';
```

**Output**:

| column_name | data_type | CHARACTER_MAXIMUM_LENGTH |
| --- | --- | --- |
| customer_id | int | NULL |
| full_name | varchar | 100 |
| email | varchar | 100 |
| phone | varchar | 20 |
| registration_date | varchar | 50 |
| age | varchar | 10 |
| city | varchar | 50 |

**Note**: `age` should be an integer type (e.g., TINYINT), and `registration_date` should be DATE. These will be fixed next.

---

### Step 9: Handle Invalid age Values

**Explanation**: The `age` column contains an invalid value ('abc'). This query identifies the row with 'abc', then replaces it with NULL to allow changing the data type.

```sql
-- Show row with invalid age
SELECT * FROM CustomerInfo WHERE age = 'abc';

-- Replace 'abc' with NULL
UPDATE CustomerInfo
SET age = NULL
WHERE age = 'abc';
```

**Output (SELECT query)**:

| customer_id | full_name | email | phone | registration_date | age | city |
| --- | --- | --- | --- | --- | --- | --- |
| 15 | tom clark | tom.clark@email.com | 555-0112 | 2023-06-15 | abc | Austin |

**Output (UPDATE query)**: (1 row affected)

**Note**: The row with `customer_id=15` had `age='abc'`, which was set to NULL.

---

### Step 10: Change age Data Type

**Explanation**: This query changes the `age` column to TINYINT (suitable for ages, as values are small positive integers).

```sql
ALTER TABLE CustomerInfo
ALTER COLUMN age TINYINT;
```

**Output**: Commands completed successfully.

**Note**: The `age` column is now TINYINT. NULLs and valid numeric values remain.

---

### Step 11: Standardize registration_date

**Explanation**: The `registration_date` column has inconsistent formats (e.g., '2023-01-15', '01/20/2023'). This query adds a new DATE column (`registration_date_clean`) and converts existing values to a standard DATE format using `TRY_CONVERT`.

```sql
ALTER TABLE CustomerInfo
ADD registration_date_clean DATE;

UPDATE CustomerInfo
SET registration_date_clean = 
    COALESCE(
        TRY_CONVERT(DATE, registration_date, 120), -- 'YYYY-MM-DD' or with time
        TRY_CONVERT(DATE, registration_date, 111), -- 'YYYY/MM/DD'
        TRY_CONVERT(DATE, registration_date, 101), -- 'MM/DD/YYYY' or 'MM-DD-YYYY'
        TRY_CONVERT(DATE, registration_date, 103), -- 'DD/MM/YYYY'
        TRY_CONVERT(DATE, registration_date, 104)  -- 'DD.MM.YYYY'
    )
WHERE registration_date IS NOT NULL;
```

**Output** (after `SELECT customer_id, registration_date, registration_date_clean FROM CustomerInfo`):

| customer_id | registration_date | registration_date_clean |
| --- | --- | --- |
| 1 | 2023-01-15 | 2023-01-15 |
| 2 | 01/20/2023 | 2023-01-20 |
| 3 | 2023-01-15 | 2023-01-15 |
| 4 | 2023/02/10 | 2023-02-10 |
| 5 | 02-25-2023 | 2023-02-25 |
| 6 | 2023-03-01 | 2023-03-01 |
| 7 | 03/15/2023 | 2023-03-15 |
| 8 | 2023-01-15 | 2023-01-15 |
| 9 | NULL | NULL |
| 10 | 2023-04-10 12:00:00 | 2023-04-10 |
| 11 | 2023-04-20 | 2023-04-20 |
| 12 | 2023/05/01 | 2023-05-01 |
| 13 | 2023-01-15 | 2023-01-15 |
| 14 | 05/30/2023 | 2023-05-30 |
| 15 | 2023-06-15 | 2023-06-15 |
| 16 | 2023-06-15 | 2023-06-15 |
| 17 | 2023/07/01 | 2023-07-01 |
| 18 | 07-10-2023 | 2023-07-10 |
| 19 | NULL | NULL |
| 20 | 2023-08-20 | 2023-08-20 |

**Note**: All valid date formats are converted to `YYYY-MM-DD`. NULLs remain unchanged.

---

### Step 12: Identify Duplicates

**Explanation**: This query identifies duplicate rows based on `full_name`, `email`, `phone`, `registration_date`, `age`, and `city` (case-insensitive for `full_name` and `email`). It groups rows and counts occurrences, showing groups with more than one row.

```sql
SELECT 
    LOWER(TRIM(full_name)) AS full_name,
    LOWER(email) AS email,
    phone,
    registration_date,
    age,
    city,
    COUNT(*) AS duplicate_count
FROM CustomerInfo
GROUP BY LOWER(TRIM(full_name)), LOWER(email), phone, registration_date, age, city
HAVING COUNT(*) > 1;
```

**Output**:

| full_name | email | phone | registration_date | age | city | duplicate_count |
| --- | --- | --- | --- | --- | --- | --- |
| john doe | john.doe@email.com | 555-0101 | 2023-01-15 | 30 | New York | 4 |

**Note**: Four rows (customer_id 1, 3, 8, 13) are duplicates based on the specified columns.

---

### Step 13: Remove Duplicates

**Explanation**: This query removes duplicates, keeping the row with the lowest `customer_id` for each duplicate group. It groups by `full_name`, `email`, `phone`, `registration_date`, `age`, and `city`.

```sql
DELETE FROM CustomerInfo
WHERE customer_id NOT IN (
    SELECT MIN(customer_id)
    FROM CustomerInfo
    GROUP BY LOWER(TRIM(full_name)), LOWER(email), phone, registration_date, age, city
);
```

**Output**: (3 rows affected)

**Data After Deletion** (after `SELECT * FROM CustomerInfo`):

| customer_id | full_name | email | phone | registration_date | age | city | registration_date_clean |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | john doe | john.doe@email.com | 555-0101 | 2023-01-15 | 30 | New York | 2023-01-15 |
| 2 | jane smith | jane.smith@email.com | not available | 01/20/2023 | 25 | Los Angeles | 2023-01-20 |
| 4 | mary johnson | Not Available | 555-0103 | 2023/02/10 | 28 | Chicago | 2023-02-10 |
| 5 | mike brown | mike.brown@email.com | 555-0104 | 02-25-2023 | NULL | Houston | 2023-02-25 |
| 6 | sarah wilson | sarah.wilson@email.com | 5550105 | 2023-03-01 | 35 | not available | 2023-03-01 |
| 7 | james lee | Not Available | 555-0106 | 03/15/2023 | 40 | Phoenix | 2023-03-15 |
| 9 | emma davis | emma.davis@email.com | 555-0107 | NULL | 22 | San Diego | NULL |
| 10 | robert miller | robert.miller@email.com | not available | 2023-04-10 12:00:00 | 27 | Dallas | 2023-04-10 |
| 11 | lisa taylor | lisa.taylor@email.com | 555-0109 | 2023-04-20 | NULL | Miami | 2023-04-20 |
| 12 | david wilson | david.wilson@email.com | 555-0110 | 2023/05/01 | 45 | Seattle | 2023-05-01 |
| 14 | annasmith | Not Available | not available | 05/30/2023 | 29 | Boston | 2023-05-30 |
| 15 | tom clark | tom.clark@email.com | 555-0112 | 2023-06-15 | NULL | Austin | 2023-06-15 |
| 16 | sophie brown | sophie.brown@email.com | 5550113 | 2023-06-15 | 33 | Denver | 2023-06-15 |
| 17 | william king | Not Available | 555-0114 | 2023/07/01 | 50 | Atlanta | 2023-07-01 |
| 18 | clara | clara.jones@email.com | not available | 07-10-2023 | 26 | Portland | 2023-07-10 |
| 19 | mark evans | mark.evans@email.com | 555-0116 | NULL | 31 | San Francisco | NULL |
| 20 | laura adams | laura.adams@email.com | 555-0117 | 2023-08-20 | 24 | not available | 2023-08-20 |

**Note**: Only 17 rows remain after removing 3 duplicates (customer_id 3, 8, 13).

---

### Step 14: Set customer_id as Primary Key

**Explanation**: This query ensures `customer_id` is non-nullable and sets it as the primary key to enforce uniqueness and improve query performance.

```sql
ALTER TABLE CustomerInfo
ALTER COLUMN customer_id INT NOT NULL;

ALTER TABLE CustomerInfo
ADD CONSTRAINT PK_customers PRIMARY KEY (customer_id);
```

**Output**: Commands completed successfully.

**Note**: `customer_id` is now the primary key, ensuring no duplicate IDs in the future.

---

### Step 15: Final Data Types

**Explanation**: This query checks the data types after all changes to confirm corrections.

```sql
SELECT column_name, data_type, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'CustomerInfo';
```

**Output**:

| column_name | data_type | CHARACTER_MAXIMUM_LENGTH |
| --- | --- | --- |
| customer_id | int | NULL |
| full_name | varchar | 100 |
| email | varchar | 100 |
| phone | varchar | 20 |
| registration_date | varchar | 50 |
| age | tinyint | NULL |
| city | varchar | 50 |
| registration_date_clean | date | NULL |

**Note**: `age` is now TINYINT, and `registration_date_clean` is DATE. The original `registration_date` remains VARCHAR for reference.

---

### Final Data State

**Explanation**: This query shows the fully cleaned dataset after all steps.

```sql
SELECT * FROM CustomerInfo;
```

**Output**:

| customer_id | full_name | email | phone | registration_date | age | city | registration_date_clean |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | John doe | john.doe@email.com | 555-0101 | 2023-01-15 | 30 | New York | 2023-01-15 |
| 2 | Jane smith | jane.smith@email.com | not available | 01/20/2023 | 25 | Los Angeles | 2023-01-20 |
| 4 | Mary johnson | Not Available | 555-0103 | 2023/02/10 | 28 | Chicago | 2023-02-10 |
| 5 | Mike brown | mike.brown@email.com | 555-0104 | 02-25-2023 | NULL | Houston | 2023-02-25 |
| 6 | Sarah wilson | sarah.wilson@email.com | 555-0105 | 2023-03-01 | 35 | not available | 2023-03-01 |
| 7 | James lee | Not Available | 555-0106 | 03/15/2023 | 40 | Phoenix | 2023-03-15 |
| 9 | Emma davis | emma.davis@email.com | 555-0107 | NULL | 22 | San Diego | NULL |
| 10 | Robert miller | robert.miller@email.com | not available | 2023-04-10 12:00:00 | 27 | Dallas | 2023-04-10 |
| 11 | Lisa taylor | lisa.taylor@email.com | 555-0109 | 2023-04-20 | NULL | Miami | 2023-04-20 |
| 12 | David wilson | david.wilson@email.com | 555-0110 | 2023/05/01 | 45 | Seattle | 2023-05-01 |
| 14 | Anna smith | Not Available | not available | 05/30/2023 | 29 | Boston | 2023-05-30 |
| 15 | Tom clark | tom.clark@email.com | 555-0112 | 2023-06-15 | NULL | Austin | 2023-06-15 |
| 16 | Sophie brown | sophie.brown@email.com | 555-0113 | 2023-06-15 | 33 | Denver | 2023-06-15 |
| 17 | William king | Not Available | 555-0114 | 2023/07/01 | 50 | Atlanta | 2023-07-01 |
| 18 | Clara jones | clara.jones@email.com | not available | 07-10-2023 | 26 | Portland | 2023-07-10 |
| 19 | Mark evans | mark.evans@email.com | 555-0116 | NULL | 31 | San Francisco | NULL |
| 20 | Laura adams | laura.adams@email.com | 555-0117 | 2023-08-20 | 24 | not available | 2023-08-20 |

---

Done 🥰