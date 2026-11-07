--Inspect the orders table

--Check total records
SELECT COUNT(*) AS Total_Orders
FROM dbo.orders;

--Check the table columns ( This shows the column names, data types and whether NULL values are allowed )
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'orders'
ORDER BY ORDINAL_POSITION;

--Check duplicate order IDs
SELECT
    order_id,
    COUNT(*) AS Duplicate_Count
FROM dbo.orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS TotalRows,
       COUNT(DISTINCT order_id) AS UniqueOrders
FROM dbo.orders;

--Check missing delivery dates
SELECT
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN order_delivered_carrier_date IS NULL
        THEN 1 ELSE 0 END) AS Missing_Carrier_Date,
    SUM(CASE WHEN order_delivered_customer_date IS NULL
        THEN 1 ELSE 0 END) AS Missing_Customer_Date
FROM dbo.orders;

--Check customer relationships

SELECT COUNT(*) AS Orders_Without_Customer
FROM dbo.orders o
LEFT JOIN dbo.customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


--Create Primary Key and Foreign Key

ALTER TABLE dbo.orders
ADD CONSTRAINT PK_orders
PRIMARY KEY (order_id);

ALTER TABLE dbo.orders
ADD CONSTRAINT FK_orders_customers
FOREIGN KEY (customer_id)
REFERENCES dbo.customers(customer_id);

