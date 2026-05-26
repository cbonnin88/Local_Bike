# 🚲 Local Bike - Analytics Engineering Project

## 📌 Overview
This repository contains the dbt (Data Build Tool) project for **Local Bike**, an analytics engineering class project. The primary objective of this project is to build a robust data pipeline to analyze and optimize revenue for a fictional bicycle retail chain.

## 🏗️ Data Architecture
The modern data stack used for this project includes:
- **Data Source:** Raw CSV files stored in Google Cloud Storage (GCS).
- **Data Ingestion:** **Fivetran** (using GCS connectors to load distinct tables).
- **Data Warehouse:** **Google BigQuery** (`local_bike_raw` dataset).
- **Data Transformation:** **dbt Cloud**.
- **Data Visualization:** **Looker Studio**.

## 🗂️ dbt Project Structure
The data transformation follows the industry-standard modular dimensional modeling architecture:

1. **Staging (`models/staging/`)**: 1-to-1 mapping of raw BigQuery tables. Handles basic cleaning, type casting, and renaming.
   - `stg_orders`, `stg_order_items`, `stg_products`, `stg_customers`, etc.
2. **Intermediate (`models/intermediate/`)**: Complex logic and entity joins.
   - `int_order_items_joined`: Joins order items with products, brands, and categories to calculate item-level `net_revenue`.
3. **Marts (`models/marts/`)**: Business-ready presentation layer (Facts and Dimensions) meant for the BI tool.
   - **Facts:** `fct_orders` (Aggregated order-level metrics to prevent fan-out issues).
   - **Dimensions:** `dim_customers`, `dim_products`, `dim_stores`.
  
<img width="965" height="653" alt="Capture d’écran 2026-05-25 à 12 27 32" src="https://github.com/user-attachments/assets/df71ac38-12fc-4297-a206-6c9e41a2824f" />


## 🧪 Data Quality & Testing
To ensure data integrity before feeding it into the Looker Studio dashboard, this project includes comprehensive testing configured in `marts_models.yml`:
- **Primary Key Tests:** `unique` and `not_null` on IDs (`order_id`, `customer_id`).
- **Referential Integrity:** `relationships` tests (e.g., ensuring a `customer_id` in the orders fact table actually exists in the customers dimension).
- **Accepted Values:** Ensuring `order_status` strictly contains valid integers (`1`, `2`, `3`, `4`).

## 📊 Dashboard & Analytics
The final models power a [**Looker Studio**](https://datastudio.google.com/s/jQLpKvwtp_I) dashboard focused on Revenue Optimization, featuring:
- **Executive KPIs:** Total Revenue, Total Orders, and Average Order Value (AOV).
- **Revenue by Time:** Time-series analysis to identify seasonality and sales trends.
- **Product Strategy:** Revenue breakdown by brand and category to guide inventory decisions.
- **Discount Impact:** Analysis of the correlation between discount rates and sales volume/profitability.
