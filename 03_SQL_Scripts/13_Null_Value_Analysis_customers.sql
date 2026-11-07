USE Olist_Ecommerce_Analytics;
GO

SELECT
    COUNT(*) AS Total_Customers,

    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END)
        AS Null_Customer_ID,

    SUM(CASE WHEN customer_unique_id IS NULL THEN 1 ELSE 0 END)
        AS Null_Customer_Unique_ID,

    SUM(CASE WHEN customer_city IS NULL THEN 1 ELSE 0 END)
        AS Null_Customer_City,

    SUM(CASE WHEN customer_state IS NULL THEN 1 ELSE 0 END)
        AS Null_Customer_State

FROM dbo.customers;
GO