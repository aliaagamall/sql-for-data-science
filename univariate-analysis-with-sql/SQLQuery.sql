-- Create the customer_data table
-- This creates a table to store customer data with specified columns and data types
CREATE TABLE customer_data (
    customer_id INT PRIMARY KEY,        -- Unique identifier for each customer
    age INT,                           -- Customer's age
    annual_income DECIMAL(10, 2),       -- Annual income in dollars
    purchase_amount DECIMAL(8, 2),      -- Amount spent on purchases
    region VARCHAR(50),                 -- Customer's region
    product_category VARCHAR(50),       -- Category of the purchased product
    purchase_date DATE,                 -- Date of purchase
    customer_segment VARCHAR(50)        -- Customer segmentation (Regular, Premium, VIP)
);

-- Insert sample data into customer_data
-- Populates the table with 50 rows of sample customer data
INSERT INTO customer_data (customer_id, age, annual_income, purchase_amount, region, product_category, purchase_date, customer_segment) VALUES
(1, 25, 35000.50, 150.75, 'North', 'Electronics', '2024-01-15', 'Regular'),
(2, 34, 45000.00, 200.25, 'South', 'Clothing', '2024-02-10', 'Premium'),
(3, 28, 30000.75, 100.50, 'East', 'Books', '2024-03-05', 'Regular'),
(4, 45, 60000.00, 350.00, 'West', 'Groceries', '2024-04-12', 'Premium'),
(5, 52, 80000.25, 500.50, 'North', 'Furniture', '2024-05-20', 'VIP'),
(6, 31, 42000.75, 75.00, 'East', 'Sports', '2024-06-01', 'Regular'),
(7, 22, 25000.00, 60.25, 'South', 'Books', '2024-01-19', 'Regular'),
(8, 39, 55000.00, 220.40, 'West', 'Electronics', '2024-02-14', 'Premium'),
(9, 27, 32000.00, 95.30, 'North', 'Clothing', '2024-03-22', 'Regular'),
(10, 36, 48000.50, 180.00, 'South', 'Groceries', '2024-04-05', 'Premium'),
(11, 44, 72000.00, 400.00, 'East', 'Furniture', '2024-05-11', 'VIP'),
(12, 30, 39000.75, 130.25, 'West', 'Sports', '2024-06-18', 'Regular'),
(13, 24, 27000.00, 55.00, 'North', 'Books', '2024-07-09', 'Regular'),
(14, 40, 56000.00, 250.50, 'South', 'Electronics', '2024-08-13', 'Premium'),
(15, 33, 47000.25, 190.40, 'East', 'Clothing', '2024-09-15', 'Premium'),
(16, 50, 82000.00, 600.00, 'West', 'Groceries', '2024-10-20', 'VIP'),
(17, 29, 35000.00, 110.30, 'North', 'Sports', '2024-11-02', 'Regular'),
(18, 37, 51000.75, 210.00, 'South', 'Furniture', '2024-12-07', 'Premium'),
(19, 42, 68000.00, 370.00, 'East', 'Electronics', '2024-01-18', 'VIP'),
(20, 26, 31000.00, 85.50, 'West', 'Clothing', '2024-02-23', 'Regular'),
(21, 35, 46000.00, 175.75, 'North', 'Groceries', '2024-03-11', 'Premium'),
(22, 48, 75000.00, 450.00, 'South', 'Furniture', '2024-04-22', 'VIP'),
(23, 32, 40000.00, 140.20, 'East', 'Sports', '2024-05-16', 'Regular'),
(24, 23, 26000.50, 65.00, 'West', 'Books', '2024-06-25', 'Regular'),
(25, 41, 57000.00, 230.60, 'North', 'Electronics', '2024-07-30', 'Premium'),
(26, 38, 49000.00, 195.40, 'South', 'Clothing', '2024-08-21', 'Premium'),
(27, 53, 85000.00, 620.00, 'East', 'Groceries', '2024-09-29', 'VIP'),
(28, 30, 37000.75, 115.30, 'West', 'Sports', '2024-10-08', 'Regular'),
(29, 45, 63000.00, 340.00, 'North', 'Furniture', '2024-11-14', 'Premium'),
(30, 27, 32000.25, 90.50, 'South', 'Books', '2024-12-19', 'Regular'),
(31, 34, 45000.00, 185.75, 'East', 'Electronics', '2024-01-25', 'Premium'),
(32, 39, 52000.00, 205.00, 'West', 'Clothing', '2024-02-17', 'Premium'),
(33, 51, 80000.00, 580.00, 'North', 'Groceries', '2024-03-28', 'VIP'),
(34, 28, 34000.00, 105.25, 'South', 'Sports', '2024-04-09', 'Regular'),
(35, 43, 69000.50, 390.00, 'East', 'Furniture', '2024-05-03', 'Premium'),
(36, 31, 38000.00, 125.40, 'West', 'Books', '2024-06-11', 'Regular'),
(37, 46, 64000.00, 360.50, 'North', 'Electronics', '2024-07-17', 'Premium'),
(38, 29, 36000.75, 120.00, 'South', 'Clothing', '2024-08-04', 'Regular'),
(39, 49, 77000.00, 470.00, 'East', 'Groceries', '2024-09-12', 'VIP'),
(40, 33, 42000.00, 160.75, 'West', 'Sports', '2024-10-27', 'Regular'),
(41, 47, 66000.00, 380.20, 'North', 'Furniture', '2024-11-06', 'Premium'),
(42, 25, 29000.50, 80.00, 'South', 'Books', '2024-12-14', 'Regular'),
(43, 40, 55000.00, 240.50, 'East', 'Electronics', '2024-01-07', 'Premium'),
(44, 35, 46000.25, 170.00, 'West', 'Clothing', '2024-02-19', 'Premium'),
(45, 54, 87000.00, 640.00, 'North', 'Groceries', '2024-03-08', 'VIP'),
(46, 32, 40000.00, 135.50, 'South', 'Sports', '2024-04-15', 'Regular'),
(47, 44, 71000.00, 410.00, 'East', 'Furniture', '2024-05-27', 'Premium'),
(48, 30, 37000.75, 110.20, 'West', 'Books', '2024-06-04', 'Regular'),
(49, 42, 68000.00, 350.75, 'North', 'Electronics', '2024-07-19', 'Premium'),
(50, 26, 31000.25, 95.00, 'South', 'Clothing', '2024-08-29', 'Regular');

-- Show the shape of the data (rows and columns)
-- Counts the total number of rows and columns in the customer_data table
SELECT
    (SELECT COUNT(*) FROM customer_data) AS row_count,
    (SELECT COUNT(*) 
     FROM INFORMATION_SCHEMA.COLUMNS 
     WHERE table_name = 'customer_data') AS column_count;
-- Output:
-- | row_count | column_count |
-- |-----------|--------------|
-- | 50        | 8            |

-- Display column data types
-- Retrieves the data types of all columns in the customer_data table
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    table_name = 'customer_data';
-- Output:
-- | COLUMN_NAME      | DATA_TYPE |
-- |------------------|-----------|
-- | customer_id      | int       |
-- | age              | int       |
-- | annual_income    | decimal   |
-- | purchase_amount  | decimal   |
-- | region           | varchar   |
-- | product_category | varchar   |
-- | purchase_date    | date      |
-- | customer_segment | varchar   |

-- Count NULL values per column
-- Dynamically checks for NULL values in each column of the customer_data table
DECLARE @table_name NVARCHAR(MAX) = 'customer_data';
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql = @sql + 
    'SELECT ''' + COLUMN_NAME + ''' AS column_name, COUNT(*) AS null_count FROM ' + @table_name + 
    ' WHERE [' + COLUMN_NAME + '] IS NULL UNION ALL '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @table_name;
SET @sql = LEFT(@sql, LEN(@sql) - 10);
EXEC sp_executesql @sql;
-- Output:
-- | column_name      | null_count |
-- |------------------|------------|
-- | customer_id      | 0          |
-- | age              | 0          |
-- | annual_income    | 0          |
-- | purchase_amount  | 0          |
-- | region           | 0          |
-- | product_category | 0          |
-- | purchase_date    | 0          |
-- | customer_segment | 0          |

-- Identify duplicate rows
-- Groups all columns to detect any duplicate rows in the table
SELECT 
    *, 
    COUNT(*) AS duplicate_count
FROM 
    customer_data
GROUP BY 
    customer_id, age, annual_income, purchase_amount, region, product_category, purchase_date, customer_segment
HAVING 
    COUNT(*) > 1;
-- Output:
-- | (No rows returned) |

-- Univariate analysis for numerical columns (age, annual_income, purchase_amount)
-- Calculates statistical measures (min, max, mean, std, median, IQR, outlier bounds) for numerical columns
WITH stats_base AS (
    SELECT
        COUNT(age) AS age_count,
        MIN(age) AS age_min,
        MAX(age) AS age_max,
        AVG(CAST(age AS FLOAT)) AS age_mean,
        STDEV(CAST(age AS FLOAT)) AS age_std,
        COUNT(annual_income) AS income_count,
        MIN(annual_income) AS income_min,
        MAX(annual_income) AS income_max,
        AVG(CAST(annual_income AS FLOAT)) AS income_mean,
        STDEV(CAST(annual_income AS FLOAT)) AS income_std,
        COUNT(purchase_amount) AS purchase_count,
        MIN(purchase_amount) AS purchase_min,
        MAX(purchase_amount) AS purchase_max,
        AVG(CAST(purchase_amount AS FLOAT)) AS purchase_mean,
        STDEV(CAST(purchase_amount AS FLOAT)) AS purchase_std
    FROM customer_data
),
age_percentiles AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY age) OVER () AS q1,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age) OVER () AS median,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY age) OVER () AS q3
    FROM customer_data WHERE age IS NOT NULL
),
income_percentiles AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY annual_income) OVER () AS q1,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY annual_income) OVER () AS median,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY annual_income) OVER () AS q3
    FROM customer_data WHERE annual_income IS NOT NULL
),
purchase_percentiles AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY purchase_amount) OVER () AS q1,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY purchase_amount) OVER () AS median,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY purchase_amount) OVER () AS q3
    FROM customer_data WHERE purchase_amount IS NOT NULL
)
SELECT
    'age' AS column_name,
    sb.age_count AS non_null_count,
    sb.age_min AS min_value,
    sb.age_max AS max_value,
    ROUND(sb.age_mean, 2) AS mean_value,
    ROUND(sb.age_std, 2) AS std_dev,
    ROUND(ap.median, 2) AS median_value,
    ROUND(ap.q3 - ap.q1, 2) AS iqr,
    ROUND(ap.q1 - 1.5 * (ap.q3 - ap.q1), 2) AS lower_bound,
    ROUND(ap.q3 + 1.5 * (ap.q3 - ap.q1), 2) AS upper_bound
FROM stats_base sb
CROSS JOIN age_percentiles ap
UNION ALL
SELECT
    'annual_income',
    sb.income_count,
    sb.income_min,
    sb.income_max,
    ROUND(sb.income_mean, 2),
    ROUND(sb.income_std, 2),
    ROUND(ip.median, 2),
    ROUND(ip.q3 - ip.q1, 2),
    ROUND(ip.q1 - 1.5 * (ip.q3 - ip.q1), 2),
    ROUND(ip.q3 + 1.5 * (ip.q3 - ip.q1), 2)
FROM stats_base sb
CROSS JOIN income_percentiles ip
UNION ALL
SELECT
    'purchase_amount',
    sb.purchase_count,
    sb.purchase_min,
    sb.purchase_max,
    ROUND(sb.purchase_mean, 2),
    ROUND(sb.purchase_std, 2),
    ROUND(pp.median, 2),
    ROUND(pp.q3 - pp.q1, 2),
    ROUND(pp.q1 - 1.5 * (pp.q3 - pp.q1), 2),
    ROUND(pp.q3 + 1.5 * (pp.q3 - pp.q1), 2)
FROM stats_base sb
CROSS JOIN purchase_percentiles pp;


-- Univariate analysis for categorical columns (region, product_category, customer_segment)
-- Summarizes categorical columns with counts, unique values, and most frequent values
WITH cat_stats AS (
    SELECT 'region' AS column_name, region AS value, COUNT(*) AS frequency,
           COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
    FROM customer_data WHERE region IS NOT NULL
    GROUP BY region
    UNION ALL
    SELECT 'product_category' AS column_name, product_category AS value, COUNT(*) AS frequency,
           COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
    FROM customer_data WHERE product_category IS NOT NULL
    GROUP BY product_category
    UNION ALL
    SELECT 'customer_segment' AS column_name, customer_segment AS value, COUNT(*) AS frequency,
           COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage
    FROM customer_data WHERE customer_segment IS NOT NULL
    GROUP BY customer_segment
),
max_freq AS (
    SELECT DISTINCT
        column_name,
        FIRST_VALUE(value) OVER (PARTITION BY column_name ORDER BY frequency DESC, value ASC) AS most_frequent_value,
        MAX(frequency) OVER (PARTITION BY column_name) AS max_frequency
    FROM cat_stats
),
summary AS (
    SELECT 'region' AS column_name, COUNT(region) AS non_null_count, COUNT(DISTINCT region) AS unique_values
    FROM customer_data
    UNION ALL
    SELECT 'product_category' AS column_name, COUNT(product_category) AS non_null_count, COUNT(DISTINCT product_category) AS unique_values
    FROM customer_data
    UNION ALL
    SELECT 'customer_segment' AS column_name, COUNT(customer_segment) AS non_null_count, COUNT(DISTINCT customer_segment) AS unique_values
    FROM customer_data
)
SELECT
    s.column_name,
    s.non_null_count,
    s.unique_values,
    m.most_frequent_value,
    m.max_frequency,
    ROUND(m.max_frequency * 100.0 / s.non_null_count, 2) AS most_frequent_percentage
FROM summary s
JOIN max_freq m ON s.column_name = m.column_name
ORDER BY s.column_name;


-- Frequency distribution for categorical columns
-- Provides a detailed frequency count and percentage for each value in categorical columns
SELECT 'region' AS column_name, region AS value, COUNT(*) AS value_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM customer_data WHERE region IS NOT NULL
GROUP BY region
UNION ALL
SELECT 'product_category' AS column_name, product_category AS value, COUNT(*) AS value_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM customer_data WHERE product_category IS NOT NULL
GROUP BY product_category
UNION ALL
SELECT 'customer_segment' AS column_name, customer_segment AS value, COUNT(*) AS value_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM customer_data WHERE customer_segment IS NOT NULL
GROUP BY customer_segment
ORDER BY column_name, value_count DESC;
-- Output:
-- | column_name      | value         | value_count | percentage |
-- |------------------|---------------|-------------|------------|
-- | customer_segment | Regular       | 21          | 42.00      |
-- | customer_segment | Premium       | 20          | 40.00      |
-- | customer_segment | VIP           | 9           | 18.00      |
-- | product_category | Clothing      | 9           | 18.00      |
-- | product_category | Electronics   | 9           | 18.00      |
-- | product_category | Furniture     | 8           | 16.00      |
-- | product_category | Groceries     | 8           | 16.00      |
-- | product_category | Sports        | 8           | 16.00      |
-- | product_category | Books         | 8           | 16.00      |
-- | region           | North         | 13          | 26.00      |
-- | region           | South         | 13          | 26.00      |
-- | region           | West          | 12          | 24.00      |
-- | region           | East          | 12          | 24.00      |

-- Univariate analysis for date column (purchase_date)
-- Summarizes the purchase_date column with min, max, and unique date counts
WITH date_stats AS (
    SELECT
        'purchase_date' AS column_name,
        COUNT(purchase_date) AS non_null_count,
        MIN(purchase_date) AS min_date,
        MAX(purchase_date) AS max_date,
        COUNT(DISTINCT purchase_date) AS unique_dates
    FROM customer_data
)
SELECT
    d.column_name,
    d.non_null_count,
    d.min_date,
    d.max_date,
    d.unique_dates
FROM date_stats d;
-- Output:
-- | column_name  | non_null_count | min_date   | max_date   | unique_dates |
-- |--------------|----------------|------------|------------|--------------|
-- | purchase_date| 50             | 2024-01-07 | 2024-12-19 | 50           |

-- Feature engineering: Add age_group and purchase_month columns
-- Adds and populates new columns for age groups and purchase months
ALTER TABLE customer_data ADD age_group VARCHAR(50);
UPDATE customer_data
SET age_group = CASE
    WHEN age < 25 THEN '18-24'
    WHEN age < 35 THEN '25-34'
    WHEN age < 45 THEN '35-44'
    ELSE '45+' END;

ALTER TABLE customer_data ADD purchase_month VARCHAR(7);
UPDATE customer_data
SET purchase_month = FORMAT(purchase_date, 'MM');

-- Display the updated table
-- Retrieves all columns from the updated customer_data table
SELECT * FROM customer_data;
