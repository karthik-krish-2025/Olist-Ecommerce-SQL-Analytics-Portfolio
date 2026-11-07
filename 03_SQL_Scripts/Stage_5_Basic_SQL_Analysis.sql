
-- =====================================================
-- STAGE 5: BASIC SQL ANALYSIS
-- Project  : Olist E-Commerce Analytics
-- Database : Olist_Ecommerce_Analytics
-- =====================================================


-- =====================================================
-- EXERCISE 1: Total Number of Orders
-- Business Question: How many orders are in the database?
-- =====================================================

SELECT
    COUNT(*) AS total_orders
FROM dbo.orders;


-- =====================================================
-- EXERCISE 2: Identify Unique Order Statuses
-- Business Question: What different order statuses exist?
-- =====================================================

SELECT DISTINCT
    order_status
FROM dbo.orders;


-- =====================================================
-- EXERCISE 3: Count Orders by Status
-- Business Question: How many orders are delivered, shipped,
-- canceled, processing, etc.?
-- =====================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM dbo.orders
GROUP BY order_status
ORDER BY order_status DESC;


-- =====================================================
-- EXERCISE 4: Find the Percentage of Delivered Orders
-- Business Question: Out of all orders, what percentage
-- were successfully delivered?
-- =====================================================

-- Option 1: Using subqueries

SELECT
    (SELECT COUNT(*)
     FROM dbo.orders) AS total_orders,

    (SELECT COUNT(*)
     FROM dbo.orders
     WHERE order_status = 'delivered') AS delivered_orders,

    (SELECT COUNT(*) * 100.0
     FROM dbo.orders
     WHERE order_status = 'delivered')
    /
    (SELECT COUNT(*)
     FROM dbo.orders) AS delivered_percentage;


-- Option 2: Using conditional aggregation

SELECT
    COUNT(*) AS total_orders,

    SUM(CASE
            WHEN order_status = 'delivered' THEN 1
            ELSE 0
        END) AS delivered_orders,

    (SUM(CASE
            WHEN order_status = 'delivered' THEN 1
            ELSE 0
        END) * 100.0) / COUNT(*) AS delivered_percentage
FROM dbo.orders;


-- =====================================================
-- EXERCISE 5: Delivered and Canceled Order KPIs
-- Business Question: Out of all orders, how many were
-- delivered and canceled, and what percentage does each
-- represent?
-- =====================================================

-- Option 1: Using subqueries

SELECT
    COUNT(*) AS total_orders,

    (SELECT COUNT(*)
     FROM dbo.orders
     WHERE order_status = 'delivered') AS delivered_orders,

    (SELECT COUNT(*)
     FROM dbo.orders
     WHERE order_status = 'canceled') AS canceled_orders,

    ((SELECT COUNT(*)
      FROM dbo.orders
      WHERE order_status = 'delivered') * 100.00
     /
     (SELECT COUNT(*)
      FROM dbo.orders)) AS delivered_percentage,

    ((SELECT COUNT(*)
      FROM dbo.orders
      WHERE order_status = 'canceled') * 100.00
     /
     (SELECT COUNT(*)
      FROM dbo.orders)) AS cancelled_percentage
FROM dbo.orders;


-- Option 2: Using conditional aggregation

SELECT
    COUNT(*) AS total_orders,

    SUM(CASE
            WHEN order_status = 'delivered' THEN 1
            ELSE 0
        END) AS delivered_orders,

    SUM(CASE
            WHEN order_status = 'canceled' THEN 1
            ELSE 0
        END) AS canceled_orders,

    (SUM(CASE
            WHEN order_status = 'delivered' THEN 1
            ELSE 0
        END) * 100.00
     / (SELECT COUNT(*) FROM dbo.orders)) AS delivered_percentage,

    ROUND(
        SUM(CASE
                WHEN order_status = 'canceled' THEN 1
                ELSE 0
            END) * 100.00
        / (SELECT COUNT(*) FROM dbo.orders),
        2
    ) AS canceled_percentage
FROM dbo.orders;


-- =====================================================
-- EXERCISE 6: Orders by Year
-- Business Question: How many orders did Olist receive
-- in each year?
--
-- Why is this useful?
-- A business analyst needs to understand how order
-- volume changes over time.
-- =====================================================

SELECT
    YEAR(order_purchase_timestamp) AS year,
    COUNT(*) AS total_orders
FROM dbo.orders
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY year;


-- =====================================================
-- EXERCISE 7: Monthly Order Analysis
-- Business Question: How many orders did Olist receive
-- in each month?
-- =====================================================

SELECT
    YEAR(order_purchase_timestamp) AS year,
    DATENAME(MONTH, order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM dbo.orders
GROUP BY
    YEAR(order_purchase_timestamp),
    DATENAME(MONTH, order_purchase_timestamp)
ORDER BY
    year,
    DATENAME(MONTH, order_purchase_timestamp);


-- =====================================================
-- EXERCISE 8: Year-over-Year Order Comparison
-- Business Question: How much did the number of orders
-- increase or decrease compared with the previous year?
-- =====================================================

WITH yearly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY YEAR(order_purchase_timestamp)
)
SELECT
    yearly,
    total_orders,
    LAG(total_orders) OVER (ORDER BY yearly) AS previous_year_orders
FROM yearly_sales;


-- =====================================================
-- EXERCISE 9: Calculate Year-over-Year Growth %
-- Business Question: By what percentage did orders
-- increase or decrease compared with the previous year?
-- =====================================================

WITH yearly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY YEAR(order_purchase_timestamp)
)
SELECT
    yearly,
    total_orders,

    LAG(total_orders) OVER (ORDER BY yearly) AS previous_year_orders,

    total_orders - LAG(total_orders) OVER (ORDER BY yearly)
        AS order_difference,

    CONCAT(
        ROUND(
            (total_orders - LAG(total_orders) OVER (ORDER BY yearly))
            * 100
            / NULLIF(
                LAG(total_orders) OVER (ORDER BY yearly),
                0
            ),
            2
        ),
        '%'
    ) AS percentage_increase
FROM yearly_sales;


-- =====================================================
-- EXERCISE 10: Monthly Year-over-Year Sales Comparison
-- Business Question: How did monthly order volume change
-- compared with the same month in the previous year?
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly,
        MONTH(order_purchase_timestamp) AS monthly,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY
        MONTH(order_purchase_timestamp),
        YEAR(order_purchase_timestamp)
)
SELECT
    yearly,
    monthly,
    total_orders,

    LAG(total_orders, 12) OVER (
        ORDER BY yearly, monthly
    ) AS previous_year,

    ROUND(
        (
            total_orders -
            LAG(total_orders, 12) OVER (ORDER BY yearly, monthly)
        ) * 100.00
        /
        NULLIF(
            LAG(total_orders, 12) OVER (ORDER BY yearly, monthly),
            0
        ),
        2
    ) AS growth_percentage
FROM monthly_sales;


-- =====================================================
-- EXERCISE 11: Monthly Running Total of Orders
-- Business Question: How many total orders have accumulated
-- from the beginning of each year up to each month?
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly,
        MONTH(order_purchase_timestamp) AS monthly,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY
        MONTH(order_purchase_timestamp),
        YEAR(order_purchase_timestamp)
)
SELECT
    yearly,
    monthly,
    total_orders,

    SUM(total_orders) OVER (
        PARTITION BY yearly
        ORDER BY monthly
    ) AS running_total
FROM monthly_sales;


-- Alternative: Explicitly specify ROWS BETWEEN

-- Without ROWS BETWEEN, SQL Server uses a default
-- RANGE frame for ordered aggregate window functions.

WITH monthly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly,
        MONTH(order_purchase_timestamp) AS monthly,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY
        MONTH(order_purchase_timestamp),
        YEAR(order_purchase_timestamp)
)
SELECT
    yearly,
    monthly,
    total_orders,

    SUM(total_orders) OVER (
        PARTITION BY yearly
        ORDER BY monthly
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM monthly_sales;


-- =====================================================
-- EXERCISE 12: Rank Months by Order Volume
-- Business Question: Which months had the highest
-- number of orders in each year?
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly,
        MONTH(order_purchase_timestamp) AS monthly,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY
        MONTH(order_purchase_timestamp),
        YEAR(order_purchase_timestamp)
),
monthly_ranking AS
(
    SELECT
        yearly,
        monthly,
        total_orders,

        DENSE_RANK() OVER (
            PARTITION BY yearly
            ORDER BY total_orders DESC
        ) AS ranking
    FROM monthly_sales
)
SELECT *
FROM monthly_ranking
WHERE ranking = 1;


-- =====================================================
-- EXERCISE 14: Find the Top 3 Months by Order Volume
-- Business Question: Which three months generated the
-- highest number of orders in each year?
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly,
        MONTH(order_purchase_timestamp) AS monthly,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY
        MONTH(order_purchase_timestamp),
        YEAR(order_purchase_timestamp)
),
monthly_ranking AS
(
    SELECT
        yearly,
        monthly,
        total_orders,

        DENSE_RANK() OVER (
            PARTITION BY yearly
            ORDER BY total_orders DESC
        ) AS ranking
    FROM monthly_sales
)
SELECT *
FROM monthly_ranking
WHERE ranking < 4;


-- =====================================================
-- EXERCISE 15: Find the Bottom 3 Months by Order Volume
-- Business Question: Which three months had the lowest
-- order volume in each year?
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly,
        MONTH(order_purchase_timestamp) AS monthly,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY
        MONTH(order_purchase_timestamp),
        YEAR(order_purchase_timestamp)
),
monthly_ranking AS
(
    SELECT
        yearly,
        monthly,
        total_orders,

        DENSE_RANK() OVER (
            PARTITION BY yearly
            ORDER BY total_orders ASC
        ) AS ranking
    FROM monthly_sales
)
SELECT *
FROM monthly_ranking
WHERE ranking < 4;


-- =====================================================
-- EXERCISE 16: Calculate Each Month's Contribution
-- to Annual Orders (%)
--
-- Business Question: What percentage of the year's
-- total orders came from each month?
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly,
        MONTH(order_purchase_timestamp) AS monthly,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY
        MONTH(order_purchase_timestamp),
        YEAR(order_purchase_timestamp)
)
SELECT
    yearly,
    monthly,
    total_orders,

    SUM(total_orders) OVER (
        PARTITION BY yearly
    ) AS yearly_orders,

    ROUND(
        total_orders * 100.00
        / SUM(total_orders) OVER (PARTITION BY yearly),
        2
    ) AS monthly_contribution
FROM monthly_sales
ORDER BY yearly, monthly;


-- =====================================================
-- EXERCISE 17: Cumulative Monthly Contribution
-- to Annual Orders (%)
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly_sales,
        MONTH(order_purchase_timestamp) AS monthly_sales,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY
        YEAR(order_purchase_timestamp),
        MONTH(order_purchase_timestamp)
)
SELECT
    yearly_sales,
    monthly_sales,
    total_orders,

    SUM(total_orders) OVER (
        PARTITION BY yearly_sales
        ORDER BY monthly_sales
    ) AS cumulative_orders,

    SUM(total_orders) OVER (
        PARTITION BY yearly_sales
    ) AS yearly_orders,

    ROUND(
        SUM(total_orders) OVER (
            PARTITION BY yearly_sales
            ORDER BY monthly_sales
        ) * 100.0
        /
        SUM(total_orders) OVER (
            PARTITION BY yearly_sales
        ),
        2
    ) AS yearly_contribution
FROM monthly_sales
ORDER BY yearly_sales, monthly_sales;


-- =====================================================
-- EXERCISE 18: Month-over-Month (MoM) Order Growth
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly_sales,
        MONTH(order_purchase_timestamp) AS monthly_sales,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY
        YEAR(order_purchase_timestamp),
        MONTH(order_purchase_timestamp)
)
SELECT
    yearly_sales,
    monthly_sales,
    total_orders,

    LAG(total_orders) OVER (
        PARTITION BY yearly_sales
        ORDER BY monthly_sales
    ) AS previous_month,

    (
        total_orders -
        LAG(total_orders) OVER (
            PARTITION BY yearly_sales
            ORDER BY monthly_sales
        )
    ) * 100.0
    /
    NULLIF(
        LAG(total_orders) OVER (
            PARTITION BY yearly_sales
            ORDER BY monthly_sales
        ),
        0
    ) AS growth_percentage
FROM monthly_sales
ORDER BY yearly_sales, monthly_sales;


-- =====================================================
-- EXERCISE 19: Month-over-Month Growth Across
-- Year Boundaries
--
-- Business Question: How did orders change from
-- December to January?
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly_sales,
        MONTH(order_purchase_timestamp) AS monthly_sales,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY
        YEAR(order_purchase_timestamp),
        MONTH(order_purchase_timestamp)
)
SELECT
    yearly_sales,
    monthly_sales,
    total_orders,

    LAG(total_orders) OVER (
        ORDER BY yearly_sales, monthly_sales
    ) AS previous_month,

    ROUND(
        (
            total_orders -
            LAG(total_orders) OVER (
                ORDER BY yearly_sales, monthly_sales
            )
        ) * 100.0
        /
        NULLIF(
            LAG(total_orders) OVER (
                ORDER BY yearly_sales, monthly_sales
            ),
            0
        ),
        2
    ) AS growth_percentage
FROM monthly_sales
ORDER BY yearly_sales, monthly_sales;


-- =====================================================
-- EXERCISE 20: Final Stage 5 Challenge
-- Business Question: Which year had the highest number
-- of orders, and what was its percentage contribution
-- to all orders?
-- =====================================================

WITH yearly_sales AS
(
    SELECT
        YEAR(order_purchase_timestamp) AS yearly_sale,
        COUNT(*) AS total_orders
    FROM dbo.orders
    GROUP BY YEAR(order_purchase_timestamp)
),
yearly_contri AS
(
    SELECT
        yearly_sale,
        total_orders,

        SUM(total_orders) OVER () AS overall_orders,

        ROUND(
            total_orders * 100.0
            / SUM(total_orders) OVER (),
            2
        ) AS percentage_contribution
    FROM yearly_sales
)
SELECT TOP 1 *
FROM yearly_contri
ORDER BY total_orders DESC;


-- =====================================================
-- END OF STAGE 5: BASIC SQL ANALYSIS
-- =====================================================
