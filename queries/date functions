CREATE TABLE IF NOT EXISTS sales_analysis AS
SELECT
    s.transaction_id,

    o.order_date,
    DATE(o.order_date) AS order_date_date,
    o.year,
    o.quarter,
    o.month,

    c.customer_name,
    c.city,
    c.zip_code,

    p.product_name,
    p.category,
    p.price,

    e.first_name  AS employee_first_name,
    e.last_name   AS employee_last_name,
    e.salary      AS employee_salary,

    s.quantity,
    s.discount,
    s.total_sales

FROM sales AS s
JOIN orders AS o
    ON s.order_id = o.order_id
JOIN customers AS c
    ON s.customer_id = c.customer_id
JOIN products AS p
    ON s.product_id = p.product_id
LEFT JOIN employees AS e
    ON s.employee_id = e.employee_id;
SELECT
  order_date_date,
  EXTRACT(YEAR FROM order_date_date)  AS year,
  EXTRACT(MONTH FROM order_date_date) AS month,
  EXTRACT(DAY FROM order_date_date)   AS day, 
  EXTRACT(DOW FROM order_date_date) as weekday
FROM sales_analysis
LIMIT 5;
SELECT
  DATE_TRUNC('month', order_date_date) AS month,
  SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY DATE_TRUNC('month', order_date_date)
ORDER BY month;
SELECT
  DATE_TRUNC('month', order_date_date) AS month,
  SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY DATE_TRUNC('month', order_date_date)
ORDER BY SUM(total_sales) DESC
LIMIT 5;
SELECT
  DATE_TRUNC('quarter', order_date_date) AS quarter,
  SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY DATE_TRUNC('quarter', order_date_date)
ORDER BY quarter
LIMIT 8
;
SELECT
  DATE_TRUNC('year', order_date_date) AS year,
  SUM(total_sales) AS total_revenue
FROM sales_analysis
GROUP BY DATE_TRUNC('year', order_date_date)
ORDER BY year;
SELECT
  order_date_date,
  CURRENT_DATE - order_date_date AS days_since_order
FROM sales_analysis
LIMIT 5;
SELECT
  order_date_date,
  (CURRENT_DATE - order_date_date )/30  AS days_since_order
FROM sales_analysis
LIMIT 5;
SELECT
  (CURRENT_DATE - order_date_date) / 30.4375 AS approx_months
FROM sales_analysis;
SELECT
  order_date_date,
    (DATE_PART('year', CURRENT_DATE) - DATE_PART('year', order_date_date)) * 12
  + (DATE_PART('month', CURRENT_DATE) - DATE_PART('month', order_date_date))
  - CASE
      WHEN DATE_PART('day', CURRENT_DATE)
        < DATE_PART('day', order_date_date)
      THEN 1 ELSE 0
  END AS full_months
FROM sales_analysis
ORDER BY order_date_date DESC
LIMIT 10;
SELECT
  COUNT(*) AS recent_orders
FROM sales_analysis
WHERE order_date_date >= CURRENT_DATE - INTERVAL '30 days';
SELECT
  order_date_date,
  order_date_date + INTERVAL '14 days' AS follow_up_date
FROM sales_analysis
LIMIT 5;
SELECT
  order_date_date,
  AGE(CURRENT_DATE, order_date_date) AS order_age
FROM sales_analysis
LIMIT 5;
SELECT
  order_date_date,
  EXTRACT(YEAR FROM AGE(CURRENT_DATE, order_date_date))  AS years,
  EXTRACT(MONTH FROM AGE(CURRENT_DATE, order_date_date)) AS months,
  EXTRACT(DAY FROM AGE(CURRENT_DATE, order_date_date))   AS days
FROM sales_analysis
LIMIT 5;