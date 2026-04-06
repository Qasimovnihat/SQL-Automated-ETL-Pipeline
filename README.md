# 🚀 Automated E-Commerce Data Cleaning & ETL Pipeline

## 📌 Project Overview
This project completely automates the data cleaning process for a large-scale e-commerce dataset containing over 1,000,000 rows. 
The goal was to eliminate manual data preparation, handle data type errors (like `#N/A` strings), and provide a clean, analysis-ready dataset updated daily.

## 🛠️ Tools & Technologies Used
* **Database:** SQL Server
* **Automation:** SQL Server Agent
* **Language:** T-SQL (Stored Procedures, CTEs)
* **Future Integration:** Ready for Power BI / Tableau visualization

## ⚠️ The Problem
Working with the raw e-commerce dataset presented several challenges:
* The `item_id` and `Customer_ID` columns contained `#N/A` text values, causing type conversion failures.
* Null values in critical categorical and financial columns.
* Duplicate records distorting sales metrics.

## 💡 The Solution (My Approach)
I developed a robust Stored Procedure (`sp_DailySalesCleaning`) that executes a "Full Refresh" ETL logic:
1. **Error Handling:** Used `TRY_CAST` to safely convert messy text columns into `INT` without breaking the process.
2. **Data Imputation:** Handled `NULL` values using `ISNULL()` for categories, prices, and quantities.
3. **Deduplication:** Utilized Common Table Expressions (CTEs) with `ROW_NUMBER()` to identify and remove duplicate rows.

## ⚙️ Automation 
To ensure the data is always up-to-date, I configured a **SQL Server Agent Job** scheduled to run automatically at **02:00 AM** every night. 
It drops the old cleaned table and recreates a fresh one from the latest raw data.

## 📂 Files in this Repository
* `Data_Cleaning_Automation.sql`: The complete T-SQL script containing the Stored Procedure.
