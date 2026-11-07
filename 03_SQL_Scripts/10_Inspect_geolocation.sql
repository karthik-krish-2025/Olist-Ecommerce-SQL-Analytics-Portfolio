-- Inspect geolocation data

USE Olist_Ecommerce_Analytics;
GO

-- Table existence check for Geolocation
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'geolocation';

--Check total records
SELECT COUNT(*) AS Total_Geolocations
FROM dbo.geolocation;

--View sample records
SELECT TOP 10 *
FROM dbo.geolocation;

--Check NULLs 

SELECT
    SUM(CASE WHEN geolocation_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS Null_Zip_Code,
    SUM(CASE WHEN geolocation_lat IS NULL THEN 1 ELSE 0 END) AS Null_Latitude,
    SUM(CASE WHEN geolocation_lng IS NULL THEN 1 ELSE 0 END) AS Null_Longitude,
    SUM(CASE WHEN geolocation_city IS NULL THEN 1 ELSE 0 END) AS Null_City,
    SUM(CASE WHEN geolocation_state IS NULL THEN 1 ELSE 0 END) AS Null_State
FROM dbo.geolocation;

--Check duplicate ZIP code prefixes

SELECT geolocation_zip_code_prefix, COUNT(*) AS Duplicate_Count
FROM dbo.geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1;

--Understand how many unique ZIP prefixes exist
SELECT 
        COUNT(*) AS Total_Records,
        COUNT(DISTINCT geolocation_zip_code_prefix) AS Unique_Zip_Prefixes
FROM dbo.geolocation;

--Check ZIP code prefixes linked to customers
SELECT 
    COUNT(*) AS Customers_Without_Geolocation
FROM dbo.customers c
LEFT JOIN dbo.geolocation g
    ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
WHERE g.geolocation_zip_code_prefix IS NULL;

SELECT 
    c.customer_zip_code_prefix AS Customers_Without_Geolocation , g.geolocation_zip_code_prefix AS Geolocation_Zip_Code_Prefix
FROM dbo.customers c
LEFT JOIN dbo.geolocation g
    ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
WHERE g.geolocation_zip_code_prefix IS NULL;

