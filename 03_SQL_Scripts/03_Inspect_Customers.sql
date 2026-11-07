--Check whether the table exists

USE Olist_Ecommerce_Analytics;
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'customers';

--Count the total records
SELECT COUNT(*) AS Total_Customers
FROM dbo.customers;

--View the first 10 records
SELECT TOP 10 *
FROM dbo.customers;

--Check duplicate customer IDs
SELECT
    customer_id,
    COUNT(*) AS Duplicate_Count
FROM dbo.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

--Check for NULL customer IDs , Before adding the primary key, execute: 
SELECT COUNT(*) AS Null_Customer_IDs
FROM dbo.customers
WHERE customer_id IS NULL;

-- Add a primary key constraint to the customer_id column
ALTER TABLE dbo.customers
ADD CONSTRAINT PK_customers
PRIMARY KEY (customer_id);

--Verify the Primary Key 
SELECT
    name AS Primary_Key_Name
FROM sys.key_constraints
WHERE parent_object_id = OBJECT_ID('dbo.customers')
AND type = 'PK';

