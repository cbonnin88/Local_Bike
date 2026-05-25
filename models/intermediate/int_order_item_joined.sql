WITH order_item AS (
    SELECT * FROM {{ref('stg_order_items')}}
),
products AS (
    SELECT * FROM {{ref('stg_products')}}
),
categories AS (
    SELECT * FROM {{ref('stg_categories')}}
),
brands AS (
    SELECT * FROM {{ref('stg_brands')}}
)

SELECT
    oi.order_id,
    oi.item_id,
    p.product_id,
    p.product_name,
    b.brand_name,
    c.category_name,
    oi.quantity,
    oi.list_price,
    oi.discount,
    -- Calculating actual revenue per item
    (oi.quantity * oi.list_price) * (1-oi.discount) AS net_revenue
FROM order_item AS oi
LEFT JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN categories AS c
    ON p.category_id = c.category_id
LEFT JOIN brands AS b
    ON p.brand_id = b.brand_id