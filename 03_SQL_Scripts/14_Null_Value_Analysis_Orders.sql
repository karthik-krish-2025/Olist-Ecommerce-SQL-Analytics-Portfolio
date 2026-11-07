USE Olist_Ecommerce_Analytics;
GO

SELECT
    COUNT(*) AS Total_Order_Items,

    SUM(CASE
        WHEN price < 0 THEN 1
        ELSE 0
    END) AS Negative_Prices,

    SUM(CASE
        WHEN freight_value < 0 THEN 1
        ELSE 0
    END) AS Negative_Freight,

    SUM(CASE
        WHEN price = 0 THEN 1
        ELSE 0
    END) AS Zero_Price_Items,

    SUM(CASE
        WHEN freight_value = 0 THEN 1
        ELSE 0
    END) AS Zero_Freight_Items

FROM dbo.order_items;
GO