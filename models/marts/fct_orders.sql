WITH orders AS (
    SELECT * FROM {{ref('stg_orders')}}
),
order_item_metrics AS (
    SELECT
        order_id,
        SUM(quantity) AS total_items,
        SUM(net_revenue) AS order_revenue
    FROM {{ref('int_order_item_joined')}}
    GROUP BY
        1
)
SELECT
    o.order_id,
    o.customer_id,
    o.store_id,
    o.staff_id,
    o.order_date,
    o.order_status,
    o.shipped_date,
    m.total_items,
    m.order_revenue
FROM orders AS o
LEFT JOIN order_item_metrics AS m 
    ON o.order_id = m.order_id