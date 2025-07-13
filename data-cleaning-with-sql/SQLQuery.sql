-- SQL Data Cleaning Script for CustomerInfo Table
-- This script cleans a sample CustomerInfo table with issues like NULLs, duplicates,
-- inconsistent formats, extra spaces, and incorrect data types. Each step is explained
-- in simple English for clarity.

-- 1. Create the CustomerInfo table
-- Creates a table with columns that have intentional issues, such as VARCHAR for dates
-- and ages, to simulate a messy dataset.
CREATE TABLE CustomerInfo (
    customer_id INTEGER,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    registration_date VARCHAR(50), -- Stored as VARCHAR to simulate inconsistent date formats
    age VARCHAR(10), -- Stored as VARCHAR to simulate incorrect data type
    city VARCHAR(50)
);

-- 2. Insert sample data
-- Inserts 20 records with issues like NULLs, duplicates, extra spaces, inconsistent
-- date formats, and an invalid age value ('abc').
INSERT INTO CustomerInfo (customer_id, full_name, email, phone, registration_date, age, city) VALUES
(1, 'John  Doe', 'john.doe@email.com', '555-0101', '2023-01-15', '30', 'New York'),
(2, 'Jane Smith ', 'jane.smith@email.com', NULL, '01/20/2023', '25', 'Los Angeles'),
(3, 'John Doe', 'john.doe@email.com', '555-0101', '2023-01-15', '30', 'New York'),
(4, '  Mary Johnson', NULL, '555-0103', '2023/02/10', '28', 'Chicago'),
(5, 'mike brown', 'mike.brown@email.com', '555-0104', '02-25-2023', NULL, 'Houston'),
(6, 'Sarah   Wilson', 'sarah.wilson@email.com', '5550105', '2023-03-01', '35', NULL),
(7, 'James  Lee', NULL, '555-0106', '03/15/2023', '40', 'Phoenix'),
(8, 'john DOE', 'john.doe@email.com', '555-0101', '2023-01-15', '30', 'New York'),
(9, 'Emma  Davis', 'emma.davis@email.com', '555-0107', NULL, '22', 'San Diego'),
(10, 'Robert Miller', 'robert.miller@email.com', NULL, '2023-04-10 12:00:00', '27', 'Dallas'),
(11, 'Lisa    Taylor', 'lisa.taylor@email.com', '555-0109', '2023-04-20', NULL, 'Miami'),
(12, 'david Wilson', 'david.wilson@email.com', '555-0110', '2023/05/01', '45', 'Seattle'),
(13, 'John  Doe  ', 'JOHN.DOE@email.com', '555-0101', '2023-01-15', '30', 'New York'),
(14, 'AnnaSmith', NULL, '555-0111', '05/30/2023', '29', 'Boston'),
(15, 'Tom   Clark', 'tom.clark@email.com', '555-0112', '2023-06-15', 'abc', 'Austin'),
(16, 'Sophie  Brown', 'sophie.brown@email.com', '5550113', '2023-06-15', '33', 'Denver'),
(17, 'WILLIAM KING', NULL, '555-0114', '2023/07/01', '50', 'Atlanta'),
(18, 'Clara   ', 'clara.jones@email.com', NULL, '07-10-2023', '26', 'Portland'),
(19, '   Mark Evans', 'mark.evans@email.com', '555-0116', NULL, '31', 'San Francisco'),
(20, 'Laura  Adams', 'laura.adams@email.com', '555-0117', '2023-08-20', '24', NULL);

-- 3. Display initial data
-- Shows the raw dataset to inspect issues like duplicates, NULLs, and inconsistent formats.
SELECT * FROM CustomerInfo;

-- 4. Clean full_name column
-- Removes leading/trailing spaces and converts names to lowercase for consistency.
UPDATE CustomerInfo
SET full_name = LOWER(TRIM(full_name));

-- Removes extra spaces between words (e.g., 'John  Doe' becomes 'john doe').
UPDATE CustomerInfo
SET full_name = REPLACE(full_name, '  ', ' ');

-- 5. Clean email column
-- Trims spaces and converts emails to lowercase for uniformity.
UPDATE CustomerInfo
SET email = LOWER(TRIM(email));

-- 6. Count NULLs in each column
-- Dynamically counts NULL values in all columns to identify missing data.
DECLARE @table_name NVARCHAR(MAX) = 'CustomerInfo';
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql = @sql + 
    'SELECT ''' + COLUMN_NAME + ''' AS column_name, COUNT(*) AS null_count FROM ' + @table_name + 
    ' WHERE [' + COLUMN_NAME + '] IS NULL UNION ALL '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @table_name;
SET @sql = LEFT(@sql, LEN(@sql) - 10);
EXEC sp_executesql @sql;

-- 7. Replace NULLs in city column
-- Replaces NULL values in the city column with 'not available' for completeness.
UPDATE CustomerInfo
SET city = 'not available'
WHERE city IS NULL;

-- 8. Replace NULLs in phone column
-- Replaces NULL values in the phone column with 'not available'.
UPDATE CustomerInfo
SET phone = 'not available'
WHERE phone IS NULL;

-- 9. Replace NULLs in email column
-- Replaces NULL values in the email column with 'Not Available'.
UPDATE CustomerInfo
SET email = 'Not Available'
WHERE email IS NULL;

-- 10. Check data types
-- Displays the data types of all columns to identify those needing correction (e.g., age, registration_date).
SELECT column_name, data_type, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'CustomerInfo';

-- 11. Identify invalid age value
-- Finds rows with invalid age values (e.g., 'abc') before changing the data type.
SELECT * FROM CustomerInfo
WHERE age = 'abc';

-- 12. Replace invalid age with NULL
-- Replaces 'abc' in the age column with NULL to allow data type conversion.
UPDATE CustomerInfo
SET age = NULL
WHERE age = 'abc';

-- 13. Change age data type
-- Converts the age column to TINYINT, suitable for small positive integers.
ALTER TABLE CustomerInfo
ALTER COLUMN age TINYINT;

-- 14. Display registration_date column
-- Shows the registration_date column to inspect its inconsistent formats.
SELECT registration_date FROM CustomerInfo;

-- 15. Standardize registration_date
-- Adds a new DATE column and converts inconsistent date formats to a standard DATE format.
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

-- 16. Compare registration_date and cleaned version
-- Displays both the original and cleaned date columns to verify standardization.
SELECT registration_date, registration_date_clean
FROM CustomerInfo;

-- 17. Identify duplicate rows
-- Finds duplicate rows based on key columns, ignoring case for full_name and email.
SELECT 
    LOWER(TRIM(full_name)) AS full_name,
    LOWER(email) AS email,
    phone,
    registration_date,
    age,
    city,
    COUNT(*) AS dupicate_count
FROM CustomerInfo 
GROUP BY full_name, email, phone, registration_date, age, city
HAVING COUNT(*) > 1;

-- 18. Remove duplicates
-- Deletes duplicate rows, keeping the row with the lowest customer_id for each duplicate group.
DELETE FROM CustomerInfo
WHERE customer_id NOT IN (
    SELECT MIN(customer_id)
    FROM CustomerInfo
    GROUP BY full_name, email, phone, registration_date, age, city
);

-- 19. Display data after cleaning
-- Shows the dataset after all cleaning steps to verify changes.
SELECT * FROM CustomerInfo;

-- 20. Check final data types
-- Confirms the data types after all corrections, including the new registration_date_clean column.
SELECT column_name, data_type
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'CustomerInfo';

-- 21. Set customer_id as primary key
-- Makes customer_id non-nullable and sets it as the primary key to enforce uniqueness.
ALTER TABLE CustomerInfo
ALTER COLUMN customer_id INT NOT NULL;

ALTER TABLE CustomerInfo
ADD CONSTRAINT PK_customers PRIMARY KEY (customer_id);

-- 22. Display final cleaned data
-- Shows the final cleaned dataset for verification.
SELECT * FROM CustomerInfo;