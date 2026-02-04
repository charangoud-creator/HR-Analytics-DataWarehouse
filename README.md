# HR-Analytics-DataWarehouse
HR Analytics Data Warehouse and Power BI Dashboard using SQL Server

## Project Overview
This project implements an HR Analytics Data Warehouse using SQL Server and visualizes insights using Power BI. 
The data warehouse follows a Star Schema design with fact and dimension tables to enable efficient analytical queries.

## Tech Stack
- SQL Server
- T-SQL (ETL)
- Power BI
- GitHub

## Dataset
- IBM HR Analytics Employee Attrition Dataset
- Source: Kaggle

## Data Warehouse Architecture
- Staging Layer
- Dimension Tables
- Fact Table
- Star Schema Modeling

## ETL Process
1. Loaded raw CSV data into staging tables
2. Transformed and normalized data into dimension tables
3. Populated fact table with analytical measures
4. Validated data integrity using row count checks

## Analytical Insights
- Job-wise average monthly income
- Department-wise employee count and attrition
- Satisfaction and overtime impact on attrition
- Experience vs salary analysis
- Performance rating based attrition

## Power BI Dashboard
The Power BI dashboard provides interactive insights using:
- KPI cards
- Department and job role analysis
- Attrition rate visualization
- Slicers for dynamic filtering

## Repository Structure

HR-Analytics-DataWarehouse/
│
├── data/
│   └── HR-Employee-Attrition.csv
│
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_staging_tables.sql
│   ├── 03_dimension_fact_tables.sql
│   ├── 05_etl_load.sql
│   ├── 06_analytical_queries.sql
│
├── powerbi/
│   └── HR_Analytics_Dashboard.pbix
│
├── docs/
│   ├── data_model.png
│   └── dashboard_screenshots/
│
└── README.md
