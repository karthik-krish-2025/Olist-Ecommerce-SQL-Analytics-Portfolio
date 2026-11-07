USE Olist_Ecommerce_Analytics;
GO

-- Table existence check for order_items
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'order_items';

--Check total records
SELECT COUNT(*) AS Total_Order_Items
FROM dbo.order_items;

--View sample records
SELECT TOP 10 *
FROM dbo.order_items;

--Check duplicate combinations
SELECT
    order_id,
    order_item_id,
    COUNT(*) AS Duplicate_Count
FROM dbo.order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

--Check whether every item belongs to an existing order
SELECT COUNT(*) AS Items_Without_Order
FROM dbo.order_items oi
LEFT JOIN dbo.orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


--Create the composite Primary Key
ALTER TABLE dbo.order_items
ADD CONSTRAINT PK_order_items
PRIMARY KEY (order_id, order_item_id);

-- Create the Foreign Key
ALTER TABLE dbo.order_items
ADD CONSTRAINT FK_order_item_orders
FOREIGN KEY (order_id) REFERENCES dbo.orders(order_id);


--Check for NULL values
SELECT
    COUNT(*) AS Total_Order_Items,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS Missing_Order_ID,
    SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Item_ID
FROM dbo.order_items;

