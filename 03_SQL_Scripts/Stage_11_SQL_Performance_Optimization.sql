
/*
============================================================
PROJECT       : Olist E-Commerce Analytics
STAGE         : 11 - SQL Performance Optimization
DATABASE      : Olist_Ecommerce_Analytics
ENVIRONMENT   : Microsoft SQL Server

OBJECTIVES:
1. Inspect existing indexes
2. Understand index usage statistics
3. Review missing index recommendations
4. Analyse query performance
5. Identify suitable index improvements
6. Compare performance before and after indexing
============================================================
*/


/* =========================================================
   SECTION 1: INSPECT EXISTING INDEXES
   =========================================================

   Purpose:
   Identify existing indexes before creating new ones.

   Why?
   Creating duplicate indexes increases storage and
   maintenance overhead without necessarily improving speed.
*/

SELECT
    t.name AS table_name,
    i.name AS index_name,
    i.type_desc AS index_type,
    i.is_primary_key,
    i.is_unique,
    i.is_disabled
FROM sys.indexes AS i
INNER JOIN sys.tables AS t
    ON i.object_id = t.object_id
WHERE i.index_id > 0
ORDER BY
    t.name,
    i.name;
GO


/* =========================================================
   SECTION 2: INDEX USAGE STATISTICS
   =========================================================

   user_seeks:
   Number of times an index seek was used.

   user_scans:
   Number of times an index scan was used.

   user_lookups:
   Number of times an index lookup was used.

   user_updates:
   Number of index maintenance operations due to
   INSERT, UPDATE or DELETE.

   Note:
   Statistics can reset after SQL Server restarts.
*/

SELECT
    t.name AS table_name,
    i.name AS index_name,
    i.type_desc AS index_type,

    COALESCE(u.user_seeks, 0) AS user_seeks,
    COALESCE(u.user_scans, 0) AS user_scans,
    COALESCE(u.user_lookups, 0) AS user_lookups,
    COALESCE(u.user_updates, 0) AS user_updates,

    u.last_user_seek,
    u.last_user_scan,
    u.last_user_lookup,
    u.last_user_update

FROM sys.indexes AS i

INNER JOIN sys.tables AS t
    ON i.object_id = t.object_id

LEFT JOIN sys.dm_db_index_usage_stats AS u
    ON i.object_id = u.object_id
    AND i.index_id = u.index_id
    AND u.database_id = DB_ID()

WHERE i.index_id > 0

ORDER BY
    t.name,
    i.name;
GO


/* =========================================================
   SECTION 3: MISSING INDEX RECOMMENDATIONS
   =========================================================

   SQL Server tracks possible missing index opportunities
   based on queries that have been executed.

   These are recommendations, not guaranteed improvements.

   Review the suggestions before creating an index.
*/

SELECT
    DB_NAME(mid.database_id) AS database_name,

    OBJECT_NAME(
        mid.object_id,
        mid.database_id
    ) AS table_name,

    mid.equality_columns,
    mid.inequality_columns,
    mid.included_columns,

    migs.user_seeks,
    migs.user_scans,
    migs.avg_total_user_cost,
    migs.avg_user_impact

FROM sys.dm_db_missing_index_details AS mid

INNER JOIN sys.dm_db_missing_index_groups AS mig
    ON mid.index_handle = mig.index_handle

INNER JOIN sys.dm_db_missing_index_group_stats AS migs
    ON mig.index_group_handle = migs.group_handle

WHERE mid.database_id = DB_ID()

ORDER BY
    migs.avg_user_impact DESC;
GO


/* =========================================================
   SECTION 4: QUERY PERFORMANCE ANALYSIS
   =========================================================

   Query:
   Monthly order volume.

   Purpose:
   Measure how SQL Server executes a real analytical query.

   Before executing:
   Enable Include Actual Execution Plan in VS Code.

   STATISTICS IO:
   Displays data reads.

   STATISTICS TIME:
   Displays CPU time and elapsed time.
*/

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT
    YEAR(order_purchase_timestamp) AS order_year,

    MONTH(order_purchase_timestamp) AS order_month,

    DATENAME(
        MONTH,
        order_purchase_timestamp
    ) AS month_name,

    COUNT(*) AS total_orders

FROM dbo.orders

GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp),
    DATENAME(MONTH, order_purchase_timestamp)

ORDER BY
    order_year,
    order_month;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO


/* =========================================================
   SECTION 5: POTENTIAL INDEX IMPROVEMENTS
   =========================================================

   The following are candidate index designs.

   Do not execute all of them automatically.

   First:
   1. Review existing indexes.
   2. Check whether an existing index already covers
      the same workload.
   3. Measure query performance.
   4. Select an index only when justified.
*/


/* ---------------------------------------------------------
   INDEX 1: ORDERS - CUSTOMER ID
   ---------------------------------------------------------

   Purpose:
   Help SQL Server locate orders belonging to a customer.

   Useful for:
   Customer-order joins and customer-level analysis.
*/

-- CREATE NONCLUSTERED INDEX IX_orders_customer_id
-- ON dbo.orders (customer_id);
GO


/* ---------------------------------------------------------
   INDEX 2: ORDERS - PURCHASE TIMESTAMP
   ---------------------------------------------------------

   Purpose:
   Help queries filtering orders using purchase date ranges.

   Useful for:
   Monthly, yearly and date-range analysis.

   Note:
   A query aggregating the entire orders table may still
   require a scan.
*/

-- CREATE NONCLUSTERED INDEX IX_orders_purchase_ts
-- ON dbo.orders (order_purchase_timestamp);
GO


/* ---------------------------------------------------------
   INDEX 3: CUSTOMERS - CUSTOMER UNIQUE ID
   ---------------------------------------------------------

   Purpose:
   Help locate customers using customer_unique_id.

   Useful for:
   Repeat customer analysis.
*/

-- CREATE NONCLUSTERED INDEX IX_customers_unique_id
-- ON dbo.customers (customer_unique_id);
GO


/* ---------------------------------------------------------
   INDEX 4: ORDER ITEMS - PRODUCT ID
   ---------------------------------------------------------

   Purpose:
   Help locate order items belonging to a particular product.

   Included column:
   price

   Useful for:
   Product revenue and top product analysis.
*/

-- CREATE NONCLUSTERED INDEX IX_order_items_product_id
-- ON dbo.order_items (product_id)
-- INCLUDE (price);
GO


/* ---------------------------------------------------------
   INDEX 5: ORDER PAYMENTS - ORDER ID
   ---------------------------------------------------------

   Purpose:
   Help locate payment records belonging to an order.

   Included column:
   payment_value

   Useful for:
   Order and payment analysis.
*/

-- CREATE NONCLUSTERED INDEX IX_order_payments_order_id
-- ON dbo.order_payments (order_id)
-- INCLUDE (payment_value);
GO


/* =========================================================
   SECTION 6: OPTIONAL INDEX DESIGNS
   =========================================================

   These are alternative designs that require testing.

   Do not automatically create both options.
*/


/* ---------------------------------------------------------
   OPTION A: ORDERS - STATUS AND DELIVERY COLUMNS
   ---------------------------------------------------------

   Key:
   order_status

   Included:
   Purchase date, delivered date, estimated date,
   customer ID.

   Purpose:
   Potentially cover Stage 8 delivery queries and
   Stage 5 status analysis.

   Trade-off:
   Additional storage and index maintenance.
*/

-- CREATE NONCLUSTERED INDEX IX_orders_status_delivery
-- ON dbo.orders (order_status)
-- INCLUDE
-- (
--     order_purchase_timestamp,
--     order_delivered_customer_date,
--     order_estimated_delivery_date,
--     customer_id
-- );
GO


/* ---------------------------------------------------------
   OPTION B: FILTERED INDEX FOR DELIVERED ORDERS
   ---------------------------------------------------------

   Purpose:
   Maintain an index containing only delivered orders.

   Useful when queries frequently filter on:
   order_status = 'delivered'

   Trade-off:
   This still requires storage and maintenance.
*/

-- CREATE NONCLUSTERED INDEX IX_orders_delivered_dates
-- ON dbo.orders (order_purchase_timestamp)
-- INCLUDE
-- (
--     order_delivered_customer_date,
--     order_estimated_delivery_date,
--     customer_id
-- )
-- WHERE order_status = 'delivered';
GO


/* =========================================================
   SECTION 7: PERFORMANCE COMPARISON
   =========================================================

   After selecting and creating an index:

   1. Run the same query before creating the index.
   2. Record logical reads and execution time.
   3. Create the selected index.
   4. Run the same query again.
   5. Compare actual execution plans.
   6. Compare logical reads and execution time.

   Important:
   An index is useful when its performance benefits
   justify its storage and maintenance costs.


   Our execution plan
1. Inspect existing indexes
   Run Section 1 and understand the indexs already present.

2. Inspect index usage
   Run Section 2 and understand seeks, scans, lookups and updates.

3. Review missing index recommendations
   Run Section 3.

4. Measure query performance
   Run Section 4 and record logical reads and execution time.

5. Create selected indexes
   We will uncomment only the indexes justified by our findings.

6. Compare before and after
   Compare execution plans, logical reads and execution time.

============================================================
*/
