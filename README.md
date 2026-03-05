# sql-analytics-portfolio

 Text Profiling & KPI Standardization

**Source Code:**[string_functions.sql](./queries/string_functions.sql)

**Dataset:** `transactions_text_demo` – 1,000 dummy transactions with messy text: inconsistent phones, annotated categories, mixed casing, duplicates.

---

## 1️⃣ Profiling

- **Phone format diversity:** multiple formats inflate distinct counts  
- **Category fragmentation:** annotations split logical categories  
- **Functions used:** `LENGTH()`, `POSITION() / STRPOS()`, `COUNT(DISTINCT)`, `GROUP BY`  

---

## 2️⃣ Standardization Layer

- **Phone cleaned:** last 8 digits only  
- **Category cleaned:** annotations removed, trimmed  
- **Revenue per transaction:** `quantity * price`  
- **Functions used:** `REGEXP_REPLACE()`, `TRIM()`, `SUBSTRING()`, `CONCAT()`  

---

## 3️⃣ KPI Comparison

| Metric                | Raw        | Cleaned      |
| --------------------- | ---------- | ------------ |
| Revenue by category   | Fragmented | Consolidated |
| Unique customers      | Inflated   | Reduced      |
| Avg transaction value | Stable     | Stable       |

---

## 4️⃣ Analytical Notes

- **KPIs changed:** Raw text caused dimensional fragmentation  
- **Biggest impact:** Phone standardization reduced duplicate customers  
- **Assumptions:** Last 8 digits identify a customer; annotations not meaningful; revenue = quantity * price  
- **Production risks:** Variable phone lengths, new annotations, unhandled formatting, country code differences  

---

## Analytics Database Schema (SQL JOIN Practice)

source Code: [analytics_schema.sql](queries/analytics_schema.sql)

### 📖 Project Overview

This project contains a fully structured PostgreSQL schema created for practicing SQL JOIN operations and relational database design.

The database models a simplified analytical e-commerce system with geographical hierarchy and geospatial support using PostGIS.

The schema name is:

`analytics`

---

## 🗂 Database Structure

The schema includes the following logical groups of tables:

### 🌍 Geography Hierarchy

- countries
- regions
- cities

### 👥 Customers

- customers

### 🛒 Commerce

- products
- orders
- order_items

### 🗺 Geospatial Data (PostGIS)

- country_boundaries
- region_boundaries
- city_boundaries
- customer_locations

---

## 🔗 Relationships

The database follows a hierarchical and relational structure:

- One country → Many regions
- One region → Many cities
- One city → Many customers
- One customer → Many orders
- One order → Many order_items
- One product → Can appear in many order_items

Foreign key constraints are used to maintain referential integrity.

---

## 🧠 Key Features

- Custom schema creation (`CREATE SCHEMA IF NOT EXISTS analytics`)
- Use of `FOREIGN KEY` relationships
- Data validation with `CHECK` constraints
- Unique constraints (e.g. email)
- PostGIS extension enabled for geospatial support
- Geometry types:
  - MultiPolygon (countries)
  - Polygon (regions, cities)
  - Point (customer locations)

---

## ⚙️ Technologies Used

- PostgreSQL
- PostGIS Extension
- SQL (DDL)

---

## ▶️ How to Run

1. Open pgAdmin or connect via psql
2. Create a new database
3. Run the SQL script file
4. The `analytics` schema and all tables will be created automatically

---

## 🚀 Next Steps

In the next phase, analytical SQL queries will be implemented using:

- JOIN
- GROUP BY
- Aggregations
- Filtering
- Time-based analysis

This project is part of SQL analytical training (Session 08 – JOINs).

## 🌍 Geospatial Data Engineering: PostGIS ETL Pipeline

Source Code:[geospatial_data_etl.sql](sql/geospatial_data_etl.sql)

## 📖 Project Overview_2

This project demonstrates a professional-grade **Geospatial ETL pipeline** designed to handle complex spatial datasets. The workflow focuses on migrating raw administrative boundaries and customer location data into a structured **PostgreSQL/PostGIS** database, ensuring high data integrity and spatial accuracy.

The pipeline transforms raw text-based coordinates (WKT) into validated geometry objects, creating a foundation for advanced location intelligence and business analytics.

## 🛠 Tech Stack

- **Database:** PostgreSQL (with PostGIS extension)

- **Logic:** Advanced SQL (DDL/DML)
- **Spatial Standard:** WGS 84 (SRID 4326)
- **Tools:** VS Code, Git, GitHub

## 🔄 The ETL Workflow

The project follows a structured data engineering lifecycle to ensure scalability and reliability:

### 1. Data Ingestion & Staging

- Implementation of a **Staging Area pattern** using `_stg_` tables.

- Decoupling raw data imports from production tables to prevent data corruption.
- Bulk loading of datasets including Countries, Regions, Cities, and Customer Locations.

### 2. Spatial Transformation

- **WKT Parsing:** Converting Well-Known Text (WKT) strings into native PostGIS geometry types.

- **Point & Polygon Management:** Handling diverse spatial types, from specific customer coordinates to complex multi-polygon administrative boundaries.
- **Coordinate Standardization:** Enforcing **SRID 4326** across all layers for global map compatibility.

### 3. Data Quality & Validation

- **Topology Validation:** Automated checks using `ST_IsValid` to identify and filter malformed geometries.

- **Spatial Integrity Audits:** Verification of SRID consistency and geometry type classification to ensure the database is "analysis-ready."

## 📂 Project Structure

- `geospatial_data_etl.sql`: The main SQL script containing the database schema, ETL logic, and validation procedures.

- `README.md`: Documentation of the technical architecture and project goals.
- `/data/`: (Placeholder) Directory for source CSV datasets.

## 🚀 Key Learning Outcomes

- **Database Architecture:** Designing a schema that supports both relational business data and spatial geometries.

- **ETL Optimization:** Using staging-to-production logic for cleaner data pipelines.
- **Spatial Analysis Readiness:** Preparing data for complex queries like "customers within a specific delivery zone" or "regional sales density."

---
*This project is part of my Data Engineering portfolio, focusing on SQL and Geospatial analytics.*
