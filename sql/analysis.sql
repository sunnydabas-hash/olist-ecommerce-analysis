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
