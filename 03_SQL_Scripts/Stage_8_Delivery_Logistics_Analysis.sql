-- =====================================================
-- STAGE 8: DELIVERY LOGISTICS ANALYSIS
-- Project  : Olist E-Commerce Analytics
-- Database : Olist_Ecommerce_Analytics
-- =====================================================

USE Olist_Ecommerce_Analytics;
GO

--Exercise : Delivery Status Distribution

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM dbo.orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Exercise 1 – Average Delivery Time
-- Business Question: "On average, how many days does Olist take to deliver an order?"

WITH delivery_cal AS
(
    SELECT
        *,
        DATEDIFF(
            DAY,
            order_purchase_timestamp,
            order_delivered_customer_date
        ) AS delivery_taken
    FROM dbo.orders
    WHERE order_status = 'delivered'
)
SELECT
    AVG(delivery_taken) AS avg_delivery_time
FROM delivery_cal;


--Exercise 2 – On-time vs Late Deliveries
--Business Question: How many delivered orders reached customers on time, and how many were delivered late?

WITH delivery_cal AS
(
    SELECT
        order_id,
        order_purchase_timestamp,
        order_delivered_customer_date,
        order_estimated_delivery_date,

        DATEDIFF(
            DAY,
            order_purchase_timestamp,
            order_delivered_customer_date
        ) AS delivery_taken,

        DATEDIFF(
            DAY,
            order_purchase_timestamp,
            order_estimated_delivery_date
        ) AS estimated_delivery

    FROM dbo.orders
    WHERE order_status = 'delivered'
)

SELECT
    COUNT(*) AS total_delivered_orders,

    SUM(CASE
        WHEN delivery_taken <= estimated_delivery
        THEN 1 ELSE 0
    END) AS ontime_delivery,

    SUM(CASE
        WHEN delivery_taken > estimated_delivery
        THEN 1 ELSE 0
    END) AS late_delivery,

    SUM(CASE
        WHEN delivery_taken IS NULL
          OR estimated_delivery IS NULL
        THEN 1 ELSE 0
    END) AS missing_date_orders
FROM delivery_cal;


--Exercise 3 – On-Time Delivery Percentage
--Business Question: What percentage of delivered orders reached customers on time?

WITH delivery_cal AS 
(
    SELECT
        *,
        DATEDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date) AS delivery_taken,
        DATEDIFF(DAY, order_purchase_timestamp, order_estimated_delivery_date) AS estimated_delivery
    FROM dbo.orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
)
SELECT
    COUNT(*) AS total_delivered_orders,
    SUM(CASE
        WHEN delivery_taken <= estimated_delivery THEN 1
        ELSE 0
    END) AS ontime_delivery,
    ROUND(
        SUM(CASE
            WHEN delivery_taken <= estimated_delivery THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS ontime_delivery_per
FROM delivery_cal;


--Exercise 4 – Average Delivery Time by State
--Business Question: Which customer states take the longest average time to receive their orders?

WITH avg_delivery AS ( 
SELECT 
	c.customer_state,
	DATEDIFF(Day, order_purchase_timestamp , order_delivered_customer_date) as delivery_taken
FROM dbo.orders as o
	LEFT JOIN dbo.customers as c
	on o.customer_id= c.customer_id 
WHERE o.order_status = 'delivered')
SELECT 
		customer_state , avg(delivery_taken) as avg_delivery
	FROM avg_delivery
	GROUP BY customer_state
	ORDER BY avg_delivery DESC

--Exercise 5 – On-Time Delivery Performance by State.
--Which Brazilian states have the highest and lowest on-time delivery percentages?

WITH delivery_analysis as (
SELECT 
o.order_id , o.order_status , o.order_purchase_timestamp,o.order_estimated_delivery_date , o.order_delivered_customer_date,
DATEDIFF(DAY, o.order_purchase_timestamp,o.order_estimated_delivery_date) as SLA ,
DATEDIFF(DAY , o.order_purchase_timestamp , O.order_delivered_customer_date) as Delivery_taken,
CASE 
    WHEN DATEDIFF(DAY , o.order_purchase_timestamp , O.order_delivered_customer_date) > DATEDIFF(DAY, o.order_purchase_timestamp,o.order_estimated_delivery_date)
    THEN 'late' ELSE 'ontime' END as delivery_performance,
 c.customer_state
FROM dbo.orders o
LEFT JOIN dbo.customers c
    on c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
      AND o.order_estimated_delivery_date IS NOT NULL 
)
SELECT 
customer_state , 
count(*) as total_delivered_orders , 
SUM(CASE WHEN delivery_performance = 'ontime' then 1 else 0 end ) as ontime_delivered_orders , 
SUM(CASE WHEN delivery_performance = 'late' then 1 else 0 end ) as late_delivered_orders,
(SUM(CASE WHEN delivery_performance = 'ontime' then 1 else 0 end ) * 100.0 / count(*) ) as ontime_percentage 
FROM delivery_analysis
GROUP BY customer_state 
order by ontime_percentage DESC





SELECT * FROM 
dbo.customers

SELECT * FROM 
dbo.orders

SELECT * 
FROM dbo.geolocation


--Exercise 6: Undelivered Orders
--Business Question: How many orders have not yet been delivered, and what are their order statuses?

SELECT
    order_status,
    COUNT(*) AS undelivered_orders
FROM dbo.orders
WHERE order_status != 'delivered'
GROUP BY order_status
ORDER BY undelivered_orders DESC;

-- Exercise 7 – Estimated vs Actual Delivery Time
-- Business Question: On average, how many days earlier or later than estimated were orders delivered?

WITH delivery_cal AS
(
    SELECT
        order_id,
        DATEDIFF(
            DAY,
            order_estimated_delivery_date,
            order_delivered_customer_date
        ) AS delivery_difference
    FROM dbo.orders
    WHERE order_status = 'delivered'
        AND order_delivered_customer_date IS NOT NULL
        AND order_estimated_delivery_date IS NOT NULL
)
SELECT
    COUNT(*) AS total_delivered_orders,
    AVG(delivery_difference) AS avg_delivery_difference
FROM delivery_cal;

--Exercise 8 – Monthly Delivery Performance
---Business Question: How does average delivery time change month by month?

WITH Monthly_avg_delivery_performance AS
(
    SELECT
        YEAR(order_purchase_timestamp)  AS years,
        MONTH(order_purchase_timestamp) AS months,
        AVG(DATEDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date)) AS avg_delivery
    FROM dbo.orders
    WHERE order_status = 'delivered'
        AND order_delivered_customer_date IS NOT NULL
    GROUP BY
        YEAR(order_purchase_timestamp),
        MONTH(order_purchase_timestamp)
)
SELECT
    years,
    months,
    avg_delivery,
    LAG(avg_delivery) OVER (ORDER BY years, months) AS previous_month,
    avg_delivery - LAG(avg_delivery) OVER (ORDER BY years, months) AS avg_diff_monthly
FROM Monthly_avg_delivery_performance;

--Average Delivery Delay
--Business Question For orders delivered late, how many days late were they on average?

SELECT
    AVG(
        CAST(
            DATEDIFF(
                DAY,
                order_estimated_delivery_date,
                order_delivered_customer_date
            ) AS DECIMAL(10,2)
        )
    ) AS avg_delay_days
FROM dbo.orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date > order_estimated_delivery_date;