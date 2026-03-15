SELECT
  c.customer_id,
  c.first_name,
  o.order_id,
  o.order_date
FROM analytics.customers c
INNER JOIN analytics.orders o
  ON c.customer_id = o.customer_id;

SELECT
  c.customer_id,
  c.first_name,
  o.order_id
FROM analytics.customers c
LEFT JOIN analytics.orders o
  ON c.customer_id = o.customer_id;

SELECT
  c.customer_id,
  c.first_name
FROM analytics.customers c
LEFT JOIN analytics.orders o
  ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT
  o.order_id, 
  p.product_name, 
  oi.quantity
FROM analytics.orders o
JOIN analytics.order_items oi
  ON o.order_id = oi.order_id
JOIN analytics.products p
  ON oi.product_id = p.product_id;

SELECT
  o.order_id,
  SUM(oi.quantity * p.price) AS order_revenue
FROM analytics.orders o
JOIN analytics.order_items oi
  ON o.order_id = oi.order_id
JOIN analytics.products p
  ON oi.product_id = p.product_id
GROUP BY o.order_id;

SELECT
  c.customer_id,
  ci.city_name,
  r.region_name,
  co.country_name
FROM analytics.customers c
JOIN analytics.cities ci
  ON c.city_id = ci.city_id
JOIN analytics.regions r
  ON ci.region_id = r.region_id
JOIN analytics.countries co
  ON r.country_id = co.country_id;

SELECT
  c.customer_id,
  ci.city_name,
  ST_Within(cl.geom, cb.geom) AS inside_city
FROM analytics.customers c
JOIN analytics.customer_locations cl
  ON c.customer_id = cl.customer_id
JOIN analytics.cities ci
  ON c.city_id = ci.city_id
JOIN analytics.city_boundaries cb
  ON ci.city_id = cb.city_id;

SELECT COUNT(*) AS joined_rows
FROM analytics.orders o
JOIN analytics.order_items oi
  ON o.order_id = oi.order_id;
  