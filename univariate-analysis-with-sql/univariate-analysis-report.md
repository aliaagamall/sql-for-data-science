# Univariate Analysis Report

document provides a detailed and organized explanation of how to Make report for univariate analysis . Univariate analysis focuses on examining each variable in isolation to understand its distribution, central tendencies, and potential outliers. I’ll cover numerical columns (`age`, `annual_income`, `purchase_amount`), categorical columns (`region`, `product_category`, `customer_segment`), and the date column (`purchase_date`).

## Table Structure

The `customer_data` table contains the following columns:

- `customer_id` (INT): Unique identifier for each customer.
- `age` (INT): Customer's age.
- `annual_income` (DECIMAL): Annual income in dollars.
- `purchase_amount` (DECIMAL): Amount spent on purchases.
- `region` (VARCHAR): Customer's region.
- `product_category` (VARCHAR): Category of the purchased product.
- `purchase_date` (DATE): Date of purchase.
- `customer_segment` (VARCHAR): Customer segmentation (Regular, Premium, VIP).

## Data Overview

- **Shape**: 50 rows and 8 columns.
- **Data Types**: As shown in the SQL queries below.
- **Null Values**: No NULL values found in any column.
- **Duplicates**: No duplicate rows detected.

## Univariate Analysis Breakdown

### 1. Numerical Columns Analysis

We analyze `age`, `annual_income`, and `purchase_amount` using statistical measures like mean, median, standard deviation, and interquartile range (IQR) to identify central tendencies and potential outliers.

- **Age**:

  - Range: 22 to 54 years.
  - Mean: 36.48 years.
  - Median: 35 years.
  - IQR: 14.5 years.
  - Outlier Bounds: 7.5 to 65.5 years (no outliers).

- **Annual Income**:

  - Range: $25,000 to $87,000.
  - Mean: $50,740.18.
  - Median: $46,500.25.
  - IQR: $29,249.25.
  - Outlier Bounds: -$7,623.13 to $109,373.88 (no outliers).

- **Purchase Amount**:

  - Range: $55 to $640.
  - Mean: $241.45.
  - Median: $188.07.
  - IQR: $246.51.
  - Outlier Bounds: -$258.22 to $727.83 (no outliers).

### 2. Categorical Columns Analysis

We examine the distribution of `region`, `product_category`, and `customer_segment` using frequency counts and percentages.

- **Region**:

  - Unique Values: 4 (North, South, West, East).
  - Most Frequent: North and South (26% each).
  - Distribution: Evenly spread with 12-13 occurrences per region.

- **Product Category**:

  - Unique Values: 6 (Clothing, Electronics, Furniture, Groceries, Sports, Books).
  - Most Frequent: Clothing and Electronics (18% each).
  - Distribution: Relatively balanced with 8-9 occurrences per category.

- **Customer Segment**:

  - Unique Values: 3 (Regular, Premium, VIP).
  - Most Frequent: Regular (42%).
  - Distribution: Regular (21), Premium (20), VIP (9).

### 3. Date Column Analysis

- **Purchase Date**:
  - Range: January 7, 2024, to December 19, 2024.
  - Unique Dates: 50 (one per row).
  - No missing dates, indicating consistent monthly data.

### 4. Feature Engineering

- **Age Groups**: Created categories (18-24, 25-34, 35-44, 45+) for better segmentation.
- **Purchase Month**: Extracted month from `purchase_date` for time-based analysis.

## Conclusion

This univariate analysis provides a solid foundation for understanding the dataset. The data is clean with no missing values or duplicates, and the distributions offer insights into customer behavior across different segments and regions. Further analysis can build on this with bivariate or multivariate techniques.