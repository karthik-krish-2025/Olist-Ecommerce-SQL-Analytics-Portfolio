USE Olist_Ecommerce_Analytics;
GO

-- Table existence check for order_payments
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Order_payments';

--Check total records
SELECT COUNT(*) AS Total_Order_Payments
FROM dbo.order_payments;

--View sample records
SELECT TOP 10 *
FROM dbo.order_payments;

--Check NULL values
SELECT
    COUNT(*) AS Total_Order_Payments,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS Missing_Order_ID,
    SUM(CASE WHEN payment_sequential IS NULL THEN 1 ELSE 0 END) AS Missing_Payment_Sequential,
    SUM(CASE WHEN payment_type IS NULL THEN 1 ELSE 0 END) AS Missing_Payment_Type,
    SUM(CASE WHEN payment_installments IS NULL THEN 1 ELSE 0 END) AS Missing_Payment_Installments,
    SUM(CASE WHEN payment_value IS NULL THEN 1 ELSE 0 END) AS Missing_Payment_Value
FROM dbo.order_payments;

--Check duplicate combinations (Why are we checking this?One order can have multiple payment records)

SELECT
    order_id,
    payment_sequential,
    COUNT(*) AS Duplicate_Count
FROM dbo.order_payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;

--Create primary key and foreign key constraints

--Primary Key Constraint
ALTER TABLE dbo.order_payments
ADD CONSTRAINT PK_order_payments PRIMARY KEY (order_id, payment_sequential);

--Foreign Key Constraint
ALTER TABLE dbo.order_payments
ADD CONSTRAINT FK_order_payments_orders FOREIGN KEY (order_id) REFERENCES dbo.orders(order_id);