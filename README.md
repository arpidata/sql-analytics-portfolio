# sql-analytics-portfolio
# SQL—06 – Text Profiling & KPI Standardization

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

| Metric | Raw | Cleaned |
|--------|-----|---------|
| Revenue by category | Fragmented | Consolidated |
| Unique customers | Inflated | Reduced |
| Avg transaction value | Stable | Stable |

---

## 4️⃣ Analytical Notes

- **KPIs changed:** Raw text caused dimensional fragmentation  
- **Biggest impact:** Phone standardization reduced duplicate customers  
- **Assumptions:** Last 8 digits identify a customer; annotations not meaningful; revenue = quantity * price  
- **Production risks:** Variable phone lengths, new annotations, unhandled formatting, country code differences  

---
