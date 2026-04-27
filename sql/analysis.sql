-- Olist E-Commerce Analysis
-- Author: Sunny
-- Tool: Oracle SQL
-- Dataset: Brazilian E-Commerce (Kaggle)

-- Queries will be added here

Top 10 Categories by Revenue

SELECT ct.product_category_name_english AS category,
        COUNT(DISTINCT oi.order_id) AS total_orders,
        ROUND(SUM(oi.price),2) AS total_revenue,
        ROUND(AVG(oi.price),2) AS average_order_value,
        ROUND(SUM(oi.price)*100/
                (SELECT SUM(price) FROM ORDER_ITEMS), 2) AS revenue_share_pct
    



FROM order_items oi
    JOIN PRODUCTS p
        ON oi.product_id = p.product_id
    JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
    JOIN ORDERS o
        ON oi.order_id = o.order_id
WHERE 
    o.order_status = 'delivered'
GROUP BY 
    ct.product_category_name_english 
ORDER BY 
    total_revenue DESC
FETCH FIRST 10 ROWS ONLY;


 Monthly revenue trend

-- ============================================
-- QUERY 2 (FIXED): Monthly Revenue Trend
-- Business Question: Is the business growing month over month?
-- Tables Used: ORDER_ITEMS, ORDERS
-- ============================================

SELECT
    TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')    AS order_month,
    COUNT(DISTINCT o.order_id)                         AS total_orders,
    ROUND(SUM(oi.price), 2)                            AS monthly_revenue,
    ROUND(AVG(oi.price), 2)                            AS avg_order_value,
    ROUND(SUM(oi.price) - LAG(SUM(oi.price))
        OVER (ORDER BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')), 2) AS revenue_vs_prev_month
FROM
    ORDERS o
    JOIN ORDER_ITEMS oi
        ON o.order_id = oi.order_id
WHERE
    o.order_status = 'delivered'
    AND o.order_purchase_timestamp IS NOT NULL
GROUP BY
    TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')
ORDER BY
    order_month;
