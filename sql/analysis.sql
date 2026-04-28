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

 Query 3: Orders and revenue by state

SELECT
    customer_state     AS state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(ot.price),2) AS total_revenue,
    ROUND(AVG(ot.price),2) AS avg_order_value,
    ROUND(COUNT(DISTINCT o.order_id) * 100 /
        SUM(COUNT(DISTINCT o.order_id)) OVER(),2) AS order_share_pct
FROM 
    ORDERS o 
    JOIN ORDER_ITEMS ot
        ON o.order_id = ot.order_id
    JOIN CUSTOMERS c
        ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_orders DESC;

Add Query 4: Late delivery analysis by category

-- ============================================
-- QUERY 4: Late Delivery Analysis
-- Business Question: What % of orders are delivered late
--                   and which categories suffer the most?
-- ============================================

SELECT
    ct.product_category_name_english AS category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(CASE WHEN TO_DATE(o.order_delivered_customer_date, 'YYYY-MM-DD HH24:MI:SS') > o.order_estimated_delivery_date THEN 1 ELSE 0 END) AS late_deliveries,
    ROUND(SUM(CASE WHEN TO_DATE(o.order_delivered_customer_date, 'YYYY-MM-DD HH24:MI:SS') > o.order_estimated_delivery_date THEN 1 ELSE 0 END) * 100 / COUNT(DISTINCT o.order_id), 2) AS late_pct,
    ROUND(AVG(CASE WHEN TO_DATE(o.order_delivered_customer_date, 'YYYY-MM-DD HH24:MI:SS') > o.order_estimated_delivery_date THEN (TO_DATE(o.order_delivered_customer_date, 'YYYY-MM-DD HH24:MI:SS') - o.order_estimated_delivery_date) ELSE NULL END), 1) AS avg_days_late
FROM ORDERS o
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
JOIN PRODUCTS p ON oi.product_id = p.product_id
JOIN CATEGORY_TRANSLATION ct ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY ct.product_category_name_english
ORDER BY late_pct DESC
FETCH FIRST 15 ROWS ONLY;

Add Query 5: Late delivery impact on review scores

-- ============================================
-- QUERY 5: Late Delivery Impact on Review Scores
-- Business Question: Does late delivery hurt customer satisfaction?
-- Tables Used: ORDERS, REVIEWS
-- ============================================

SELECT
    CASE 
        WHEN TO_DATE(o.order_delivered_customer_date, 'YYYY-MM-DD HH24:MI:SS') <= o.order_estimated_delivery_date 
        THEN 'On Time'
        ELSE 'Late'
    END                                         AS delivery_status,
    COUNT(DISTINCT o.order_id)                  AS total_orders,
    ROUND(AVG(r.review_score), 2)               AS avg_review_score,
    SUM(CASE WHEN r.review_score = 5 THEN 1 ELSE 0 END) AS five_star,
    SUM(CASE WHEN r.review_score = 4 THEN 1 ELSE 0 END) AS four_star,
    SUM(CASE WHEN r.review_score = 3 THEN 1 ELSE 0 END) AS three_star,
    SUM(CASE WHEN r.review_score = 2 THEN 1 ELSE 0 END) AS two_star,
    SUM(CASE WHEN r.review_score = 1 THEN 1 ELSE 0 END) AS one_star
FROM
    ORDERS o
    JOIN REVIEWS r
        ON o.order_id = r.order_id
WHERE
    o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY
    CASE 
        WHEN TO_DATE(o.order_delivered_customer_date, 'YYYY-MM-DD HH24:MI:SS') <= o.order_estimated_delivery_date 
        THEN 'On Time'
        ELSE 'Late'
    END
ORDER BY
    avg_review_score DESC;
