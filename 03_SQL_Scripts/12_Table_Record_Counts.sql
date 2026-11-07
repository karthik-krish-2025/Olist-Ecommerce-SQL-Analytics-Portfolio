USE Olist_Ecommerce_Analytics;
GO

--Step 1 — Record count validation

SELECT 'customers' AS Table_Name, COUNT(*) AS Total_Rows
FROM dbo.customers

UNION ALL

SELECT 'orders', COUNT(*)
FROM dbo.orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM dbo.order_items

UNION ALL

SELECT 'order_payments', COUNT(*)
FROM dbo.order_payments

UNION ALL

SELECT 'order_reviews', COUNT(*)
FROM dbo.order_reviews

UNION ALL

SELECT 'products', COUNT(*)
FROM dbo.products

UNION ALL

SELECT 'sellers', COUNT(*)
FROM dbo.sellers

UNION ALL

SELECT 'geolocation', COUNT(*)
FROM dbo.geolocation

UNION ALL

SELECT 'category_translation', COUNT(*)
FROM dbo.product_category_name_translation;
GO



