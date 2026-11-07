-- Project: Olist E-Commerce Analytics
-- Purpose: Create the project database

CREATE DATABASE Olist_Ecommerce_Analytics;
GO

-- Verify database creation

SELECT name
FROM sys.databases
WHERE name = 'Olist_Ecommerce_Analytics';
GO