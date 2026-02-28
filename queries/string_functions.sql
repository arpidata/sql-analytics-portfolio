DROP TABLE IF EXISTS customers_raw_text;

CREATE TABLE customers_raw_text (
  customer_id   INTEGER,
  first_name    TEXT,
  last_name     TEXT,
  raw_phone     TEXT,
  category_raw  TEXT,
  birth_date    DATE
);

INSERT INTO customers_raw_text (
  customer_id,
  first_name,
  last_name,
  raw_phone,
  category_raw,
  birth_date
) VALUES
  (1, 'joHN',     'doE',        '   077600945  ',   'Accessories (Promo)', DATE '1994-03-12'),
  (2, 'MARY',     'sMiTh',      '077-600-045',      'Electronics (Old)',   DATE '1988-11-05'),
  (3, 'aLEx',     'johnSON',    '(374)-77-600-945', 'Accessories',         DATE '2001-07-23'),
  (4, 'anna',     'VAN DYKE',   '37477600945',      'Electronics (Promo)', DATE '1999-01-30'),
  (5, NULL,       'brOwn',      '77600945',         'Accessories (Test)',  DATE '1994-03-12');
  SELECT
  raw_phone,
  LENGTH(raw_phone) AS phone_length
FROM customers_raw_text;
SELECT
  raw_phone,
  LENGTH(raw_phone) AS length,
  TRIM(raw_phone) AS trimmed_phone,
  LENGTH(TRIM(raw_phone)) AS trimmed_length
FROM customers_raw_text;
SELECT
  first_name,
  LOWER(first_name) AS first_name_lower
FROM customers_raw_text;
SELECT
  last_name,
  UPPER(last_name) AS last_name_upper
FROM customers_raw_text;
SELECT
  first_name,
  INITCAP(first_name) AS first_name_clean
FROM customers_raw_text;
SELECT
  raw_phone,
  REPLACE(raw_phone, '-', '') AS phone_no_hyphen
FROM customers_raw_text;
SELECT
  raw_phone,
  REPLACE(
    REPLACE(
      REPLACE(TRIM(raw_phone), '-', ''),
    '(', ''),
  ')', '') AS phone_partial_clean
FROM customers_raw_text;
SELECT
  raw_phone,
  REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g') AS digits_only
FROM customers_raw_text;
SELECT
    category_raw,
    REGEXP_REPLACE(category_raw, '\([^)]*\)', '', 'g')
   AS category_clean1
FROM customers_raw_text;
SELECT
    category_raw,
    TRIM(
      REGEXP_REPLACE(category_raw, '\([^)]*\)', '', 'g')
    ) AS category_clean2
FROM customers_raw_text;SELECT
    category_raw,
    REGEXP_REPLACE(category_raw, '\s*\(.*?\)', '', 'g')
      AS category_clean3
FROM customers_raw_text;
SELECT
  raw_phone,
  SUBSTRING(raw_phone FROM LENGTH(raw_phone) - 7 FOR 8) AS phone_core
FROM customers_raw_text;
SELECT
  category_raw,
  SUBSTRING(category_raw FROM 1 FOR 11) AS category_prefix
  FROM customers_raw_text;
  SELECT
  raw_phone,
  SUBSTRING(raw_phone FROM '[0-9]+') AS first_digit_sequence
FROM customers_raw_text;
SELECT
  customer_id,
  first_name,
  last_name,
  CONCAT(first_name, ' ', last_name) AS full_name
FROM customers_raw_text;
SELECT
  customer_id,
  INITCAP(first_name) AS first_name_clean,
  INITCAP(last_name)  AS last_name_clean,
  INITCAP(CONCAT(
    first_name,
    ' ',
    last_name
  )) AS full_name_clean
FROM customers_raw_text;
SELECT
  customer_id,
  INITCAP(first_name) || ' ' || INITCAP(last_name) AS full_name_clean
FROM customers_raw_text;
SELECT
  category_raw,
  POSITION('(' IN category_raw) AS open_paren_pos
FROM customers_raw_text;
SELECT
  raw_phone,
  STRPOS(raw_phone, '-') AS hyphen_pos,
  STRPOS(raw_phone, '(') AS paren_pos

FROM customers_raw_text;
SELECT
  customer_id,
  category_raw,
  POSITION('(' IN category_raw) > 0 AS has_annotation
FROM customers_raw_text;
SELECT
  raw_phone,
  SPLIT_PART(raw_phone, '-', 1) AS first_part
FROM customers_raw_text;
SELECT
  raw_phone,
  SPLIT_PART(raw_phone, '-', 2) AS second_part
FROM customers_raw_text;
SELECT
  raw_phone,
  SPLIT_PART(
    REGEXP_REPLACE(raw_phone, '[^0-9-]', '', 'g'),
    '-',
    2
  ) AS clean_second_part
FROM customers_raw_text;
SELECT
  customer_id,
  last_name,
  NULLIF(last_name, '') AS last_name_clean
FROM customers_raw_text;
SELECT
  category_raw,
  NULLIF(category_raw, 'UNKNOWN') AS category_clean
FROM customers_raw_text;
SELECT
  COUNT(NULLIF(category_raw, 'UNKNOWN')) AS valid_categories
FROM customers_raw_text;
SELECT
  customer_id,
  CONCAT(
    first_name,
    ' ',
    NULLIF(last_name, '')
  ) AS full_name_safe
FROM customers_raw_text;
SELECT
  raw_phone,
  LEFT(
    REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g'),
    3
  ) AS phone_prefix
FROM customers_raw_text;
SELECT
  raw_phone,
  RIGHT(
    REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g'),
    8
  ) AS phone_core
FROM customers_raw_text;
DROP TABLE IF EXISTS transactions_text_demo;

CREATE TABLE transactions_text_demo (
  transaction_id INTEGER,
  customer_id    INTEGER,
  raw_phone      TEXT,
  category_raw   TEXT,
  quantity       INTEGER,
  price          NUMERIC(10,2)
);
INSERT INTO transactions_text_demo
SELECT
  gs AS transaction_id,
  (RANDOM() * 200)::INT + 1 AS customer_id,

  CASE (gs % 6)
    WHEN 0 THEN '   077600945  '
    WHEN 1 THEN '077-600-045'
    WHEN 2 THEN '(374)-77-600-945'
    WHEN 3 THEN '37477600945'
    WHEN 4 THEN '77600945'
    ELSE '077600945'
  END AS raw_phone,

  CASE (gs % 5)
    WHEN 0 THEN 'Accessories (Promo)'
    WHEN 1 THEN 'Accessories (Test)'
    WHEN 2 THEN 'Electronics (Old)'
    WHEN 3 THEN 'Electronics (Promo)'
    ELSE 'Accessories'
  END AS category_raw,

  (RANDOM() * 5)::INT + 1 AS quantity,
  (RANDOM() * 500 + 10)::NUMERIC(10,2) AS price
FROM generate_series(1, 1000) AS gs;
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT raw_phone) AS distinct_raw_phones,
  COUNT(DISTINCT category_raw) AS distinct_categories
FROM transactions_text_demo;
-- Phone pattern diagnostics
SELECT
    raw_phone,
    LENGTH(raw_phone) AS phone_length,
    POSITION('-' IN raw_phone) AS dash_position,
    POSITION('(' IN raw_phone) AS parenthesis_position,
    COUNT(*) AS row_count
FROM transactions_text_demo
GROUP BY
    raw_phone,
    LENGTH(raw_phone),
    POSITION('-' IN raw_phone),
    POSITION('(' IN raw_phone)
ORDER BY row_count DESC;
SELECT
    category_raw,
    COUNT(*) AS transaction_count
FROM transactions_text_demo
GROUP BY category_raw
ORDER BY transaction_count DESC;
SELECT COUNT(DISTINCT raw_phone) AS distinct_raw_phones
FROM transactions_text_demo;

SELECT COUNT(DISTINCT category_raw) AS distinct_raw_categories
FROM transactions_text_demo;
-- Clean projection layer
SELECT
    transaction_id,
    customer_id,

    -- standardized phone (last 8 digits only)
    RIGHT(
        REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g'),
        8
    ) AS phone_clean,

    -- cleaned category (remove annotations)
    TRIM(
        REGEXP_REPLACE(category_raw, '\s*\(.*\)', '')
    ) AS category_clean,

    quantity,
    price,

    -- revenue per transaction
    quantity * price AS revenue

FROM transactions_text_demo;
SELECT
    category_raw,
    SUM(quantity * price) AS revenue
FROM transactions_text_demo
GROUP BY category_raw
ORDER BY revenue DESC;
SELECT
    TRIM(REGEXP_REPLACE(category_raw, '\s*\(.*\)', '')) AS category_clean,
    SUM(quantity * price) AS revenue
FROM transactions_text_demo
GROUP BY category_clean
ORDER BY revenue DESC;
SELECT COUNT(DISTINCT raw_phone) AS raw_unique_phones
FROM transactions_text_demo;
SELECT COUNT(DISTINCT
    RIGHT(REGEXP_REPLACE(raw_phone, '[^0-9]', '', 'g'), 8)
) AS clean_unique_phones
FROM transactions_text_demo;
