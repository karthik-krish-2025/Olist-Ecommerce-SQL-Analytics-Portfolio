
-- =====================================================
-- STAGE 7: CUSTOMER ANALYTICS
-- Project  : Olist E-Commerce Analytics
-- Database : Olist_Ecommerce_Analytics
-- =====================================================


-- =====================================================
-- Exercise 1: Total Unique Customers
-- Business Question:
-- How many unique customers have made purchases on Olist?
-- =====================================================

SELECT
    COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM dbo.customers;

-- =====================================================
-- Exercise 2: State wise customers
-- Business Question:
-- Which states have the highest number of unique customers?
-- =====================================================

SELECT
    customer_state,
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM dbo.customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- =====================================================
-- Exercise 3: Identify Repeat Customers
-- Business Question:
-- How many customers have placed more than one order?
-- =====================================================

WITH repeated_customers AS
(
    SELECT
        customer_unique_id,
        COUNT(*) AS total_orders
    FROM dbo.customers
    GROUP BY 
        customer_unique_id
    HAVING COUNT(*) > 1
)
SELECT
    COUNT(*) AS repeat_customers
FROM repeated_customers;


-- =====================================================
-- Exercise 4: One-time vs Repeat Customers
-- Business Question:
-- How many customers placed only one order vs multiple orders?
-- =====================================================

WITH cx_orders AS
(
    SELECT
        customer_unique_id,
        COUNT(*) AS orders_count
    FROM dbo.customers
    GROUP BY customer_unique_id
)
SELECT
    SUM(CASE
            WHEN orders_count = 1 THEN 1
            ELSE 0
        END) AS one_time_customers,

    SUM(CASE
            WHEN orders_count > 1 THEN 1
            ELSE 0
        END) AS repeat_customers ,
    ( SUM(CASE
            WHEN orders_count > 1 THEN 1
            ELSE 0
        END) * 1.0 / SUM(CASE
            WHEN orders_count = 1 THEN 1
            ELSE 0
        END)) * 100.0 as repeat_cx_rate
FROM cx_orders;


-- =====================================================
-- Exercise 5: Average Orders per Customer
-- Business Question:
-- What is the average number of orders placed per customer?
-- =====================================================

WITH cx_orders AS
(
    SELECT
        customer_unique_id,
        COUNT(*) AS orders_count
    FROM dbo.customers
    GROUP BY 
        customer_unique_id
)
SELECT
    AVG(orders_count) AS avg_order_per_cx
FROM cx_orders;


-- =====================================================
-- Exercise 6: Top 10 Customers by Number of Orders
-- Business Question:
-- Which 10 customers have placed the highest number of orders?
-- =====================================================

WITH cx_orders AS
(
    SELECT
        customer_unique_id,
        COUNT(*) AS total_orders
    FROM dbo.customers
    GROUP BY customer_unique_id
)
SELECT TOP 10
    customer_unique_id,
    total_orders
FROM cx_orders
ORDER BY 
    total_orders DESC;


-- =====================================================
-- Exercise 7: Customer Distribution by Order Frequency
-- Business Question:
-- How many customers placed 1, 2, 3, or more orders?
-- =====================================================

WITH cx_orders AS
(
    SELECT
        customer_unique_id AS customers,
        COUNT(*) AS orders_count
    FROM dbo.customers
    GROUP BY customer_unique_id
)
SELECT
    orders_count,
    COUNT(*) AS customers
FROM cx_orders
GROUP BY orders_count
ORDER BY orders_count;


-- =====================================================
-- Exercise 8: Customer Repeat Rate
-- Business Question:
-- What percentage of customers have placed more than one order?
-- =====================================================

WITH cx_orders AS
(
    SELECT
        customer_unique_id AS customers,
        COUNT(*) AS orders_count
    FROM dbo.customers
    GROUP BY customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,

    SUM(CASE
            WHEN orders_count > 1 THEN 1
            ELSE 0
        END) AS repeat_cx,

    ROUND(
        SUM(CASE
                WHEN orders_count > 1 THEN 1
                ELSE 0
            END) * 1.0 / COUNT(*) * 100.0,
        2
    ) AS repeat_cx_percentage
FROM cx_orders;


-- =====================================================
-- Exercise 9: Customer Order Segmentation
-- Business Requirement:
-- Understand how frequently customers purchase from the store.
--
-- Segmentation Rules:
-- One-time   : 1 order
-- Occasional : 2–3 orders
-- Frequent   : 4 or more orders
-- =====================================================

WITH cx_orders AS
(
    SELECT
        customer_unique_id,
        COUNT(*) AS orders_count
    FROM dbo.customers
    GROUP BY 
        customer_unique_id
),
segmentation AS
(
    SELECT
        customer_unique_id,
        CASE
            WHEN orders_count = 1 THEN 'One-time'
            WHEN orders_count BETWEEN 2 AND 3 THEN 'Occasional'
            WHEN orders_count >= 4 THEN 'Frequent'
        END AS customer_segment
    FROM cx_orders
)
SELECT
    customer_segment,
    COUNT(*) AS total_customers,
      SUM(COUNT(*)) OVER() AS overall_customers,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),
        2
    ) AS customer_percentage
FROM segmentation
GROUP BY 
    customer_segment
ORDER BY 
    total_customers DESC;


-- =====================================================
-- END OF STAGE 7: CUSTOMER ANALYTICS
-- =====================================================
