# Univariate Analysis with SQL: A Step-by-Step Guide

Welcome to this guide on performing univariate analysis using SQL Univariate analysis examines each variable individually to understand its distribution, central tendencies, and characteristics. This tutorial will walk you through SQL queries, explain their purpose, and show the expected output tables to help you master this technique.

## Table Overview

The `customer_data` table includes:

- `customer_id` (INT): Unique customer identifier.
- `age` (INT): Customer age.
- `annual_income` (DECIMAL): Annual income in dollars.
- `purchase_amount` (DECIMAL): Purchase amount.
- `region` (VARCHAR): Customer region.
- `product_category` (VARCHAR): Product category purchased.
- `purchase_date` (DATE): Purchase date.
- `customer_segment` (VARCHAR): Customer segment (Regular, Premium, VIP).

The table contains 50 rows with no NULL values or duplicates.

---

## 1. Checking Data Shape

### Query

```sql
SELECT
    (SELECT COUNT(*) FROM customer_data) AS row_count,
    (SELECT COUNT(*) 
     FROM INFORMATION_SCHEMA.COLUMNS 
     WHERE table_name = 'customer_data') AS column_count;
```

### Explanation

This query determines the dataset's shape by counting the number of rows and columns. `COUNT(*)` counts all rows, while `INFORMATION_SCHEMA.COLUMNS` provides metadata about the table's structure.

### Output Table

| **row_count** | **column_count** |
| --- | --- |
| 50 | 8 |

---

## 2. Inspecting Column Data Types

### Query

```sql
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    table_name = 'customer_data';
```

### Explanation

This query retrieves the data types of each column in the `customer_data` table using the `INFORMATION_SCHEMA.COLUMNS` view, helping you understand the variable formats (e.g., INT, DECIMAL, VARCHAR).

### Output Table

| **COLUMN_NAME** | **DATA_TYPE** |
| --- | --- |
| customer_id | int |
| age | int |
| annual_income | decimal |
| purchase_amount | decimal |
| region | varchar |
| product_category | varchar |
| purchase_date | date |
| customer_segment | varchar |

---

## 3. Counting NULL Values

### Query

```sql
DECLARE @table_name NVARCHAR(MAX) = 'customer_data';
DECLARE @sql NVARCHAR(MAX) = '';
SELECT @sql = @sql + 
    'SELECT ''' + COLUMN_NAME + ''' AS column_name, COUNT(*) AS null_count FROM ' + @table_name + 
    ' WHERE [' + COLUMN_NAME + '] IS NULL UNION ALL '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @table_name;
SET @sql = LEFT(@sql, LEN(@sql) - 10);
EXEC sp_executesql @sql;
```

### Explanation

This dynamic SQL query checks for NULL values in each column by constructing a `SELECT` statement for every column and counting rows where the value is NULL. The result shows the cleanliness of the data.

### Output Table

| **column_name** | **null_count** |
| --- | --- |
| customer_id | 0 |
| age | 0 |
| annual_income | 0 |
| purchase_amount | 0 |
| region | 0 |
| product_category | 0 |
| purchase_date | 0 |
| customer_segment | 0 |

---

## 4. Identifying Duplicates

### Query

```sql
SELECT 
    *, 
    COUNT(*) AS duplicate_count
FROM 
    customer_data
GROUP BY 
    customer_id, age, annual_income, purchase_amount, region, product_category, purchase_date, customer_segment
HAVING 
    COUNT(*) > 1;
```

### Explanation

This query groups all columns to detect duplicate rows. The `HAVING` clause filters groups with more than one occurrence. If no rows are returned, the data has no duplicates.

### Output Table

| **(No rows returned)** |
| --- |

---

## 5. Analyzing Numerical Columns

### Query

```sql
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
```

### Explanation

This query uses Common Table Expressions (CTEs) to calculate statistics for numerical columns:

- `stats_base`: Computes count, min, max, mean, and standard deviation.
- `*_percentiles`: Calculates quartiles (Q1, median, Q3) using `PERCENTILE_CONT`.
- The final `SELECT` combines results, rounding for readability, and includes IQR and outlier bounds.

### Output Table

| **column_name** | **non_null_count** | **min_value** | **max_value** | **mean_value** | **std_dev** | **median_value** | **iqr** | **lower_bound** | **upper_bound** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| age | 50 | 22.00 | 54.00 | 36.48 | 8.88 | 35.00 | 14.50 | 7.50 | 65.50 |
| annual_income | 50 | 25000.00 | 87000.00 | 50740.18 | 17733.54 | 46500.25 | 29249.25 | \-7623.13 | 109373.88 |
| purchase_amount | 50 | 55.00 | 640.00 | 241.45 | 162.93 | 188.07 | 246.51 | \-258.22 | 727.83 |

---

## 6. Analyzing Categorical Columns

### Query

```sql
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
```

### Explanation

This query analyzes categorical columns by:

- Counting frequencies and calculating percentages using `GROUP BY`.
- Identifying the most frequent value and its percentage with `FIRST_VALUE` and `MAX`.

### Output Table

| **column_name** | **non_null_count** | **unique_values** | **most_frequent_value** | **max_frequency** | **most_frequent_percentage** |
| --- | --- | --- | --- | --- | --- |
| customer_segment | 50 | 3 | Regular | 21 | 42.00 |
| product_category | 50 | 6 | Clothing | 9 | 18.00 |
| region | 50 | 4 | North | 13 | 26.00 |

---

## 7. Frequency Distribution for Categorical Columns

### Query

```sql
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
```

### Explanation

This query provides a detailed frequency distribution for each categorical column, showing the count and percentage of each value. The `UNION ALL` combines results, and `ORDER BY` ensures a descending order by count.

### Output Table

| **column_name** | **value** | **value_count** | **percentage** |
| --- | --- | --- | --- |
| customer_segment | Regular | 21 | 42.00 |
| customer_segment | Premium | 20 | 40.00 |
| customer_segment | VIP | 9 | 18.00 |
| product_category | Clothing | 9 | 18.00 |
| product_category | Electronics | 9 | 18.00 |
| product_category | Furniture | 8 | 16.00 |
| product_category | Groceries | 8 | 16.00 |
| product_category | Sports | 8 | 16.00 |
| product_category | Books | 8 | 16.00 |
| region | North | 13 | 26.00 |
| region | South | 13 | 26.00 |
| region | West | 12 | 24.00 |
| region | East | 12 | 24.00 |

---

## 8. Analyzing Date Column

### Query

```sql
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
```

### Explanation

This query provides a summary of the `purchase_date` column, including the range and number of unique dates, useful for time-based analysis.

### Output Table

| **column_name** | **non_null_count** | **min_date** | **max_date** | **unique_dates** |
| --- | --- | --- | --- | --- |
| purchase_date | 50 | 2024-01-07 | 2024-12-19 | 50 |

---

## 9. Feature Engineering

### Query

```sql
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
```

### Explanation

- `age_group`: Categorizes `age` into groups for segmented analysis.
- `purchase_month`: Extracts the month from `purchase_date` for time-based insights. Use `SELECT * FROM customer_data` to view the updated table.

### Output Table (Sample)

| **customer_id** | **age** | **annual_income** | **purchase_amount** | **region** | **product_category** | **purchase_date** | **customer_segment** | **age_group** | **purchase_month** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | 25 | 35000.50 | 150.75 | North | Electronics | 2024-01-15 | Regular | 25-34 | 01 |
| 2 | 34 | 45000.00 | 200.25 | South | Clothing | 2024-02-10 | Premium | 25-34 | 02 |
| 3 | 28 | 30000.75 | 100.50 | East | Books | 2024-03-05 | Regular | 25-34 | 03 |
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |

---

## Conclusion

This guide demonstrates how to use SQL for univariate analysis, from data inspection to feature engineering. Practice these queries to explore your datasets and build a strong foundation for data science tasks
