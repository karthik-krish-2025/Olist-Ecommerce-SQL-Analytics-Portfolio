--Step 1 :Check invalid prices and freight values

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

--Step 2 : Check order status and date consistency
-- 1. Check order statuses
SELECT
    order_status,
    COUNT(*) AS Total_Orders
FROM dbo.orders
GROUP BY order_status
ORDER BY Total_Orders DESC;
GO

-- 2. Check approval date before purchase date
SELECT COUNT(*) AS Invalid_Approval_Dates
FROM dbo.orders
WHERE order_approved_at < order_purchase_timestamp;
GO

-- 3. Check delivery date before purchase date
SELECT COUNT(*) AS Invalid_Delivery_Dates
FROM dbo.orders
WHERE order_delivered_customer_date < order_purchase_timestamp;
GO

-- 4. Check delivery after estimated delivery date
SELECT COUNT(*) AS Delivered_After_Estimated_Date
FROM dbo.orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;
GO

-- STEP 3 : Check payment values and installments
-- 1. Check payment types
SELECT
    payment_type,
    COUNT(*) AS Total_Payments
FROM dbo.order_payments
GROUP BY payment_type
ORDER BY Total_Payments DESC;
GO

-- 2. Check negative payment values
SELECT COUNT(*) AS Negative_Payment_Values
FROM dbo.order_payments
WHERE payment_value < 0;
GO

-- 3. Check zero payment values
SELECT COUNT(*) AS Zero_Payment_Values
FROM dbo.order_payments
WHERE payment_value = 0;
GO

-- 4. Check invalid installment values
SELECT COUNT(*) AS Invalid_Installments
FROM dbo.order_payments
WHERE payment_installments < 0;
GO

--step 4 : Review Data Quality Checks.
--Check review score distribution

SELECT
    review_score,
    COUNT(*) AS Total_Reviews
FROM dbo.order_reviews
GROUP BY review_score
ORDER BY review_score;
GO

-- Find invalid review scores

SELECT COUNT(*) AS Invalid_Review_Scores
FROM dbo.order_reviews
WHERE review_score < 1 OR review_score > 5;
GO

--Check review dates

SELECT COUNT(*) AS Invalid_Review_Dates
FROM dbo.order_reviews
WHERE review_answer_timestamp < review_creation_date;
GO

--Check reviews without comments

SELECT
    COUNT(*) AS Total_Reviews,
    SUM(CASE
        WHEN review_comment_message IS NULL
             OR LTRIM(RTRIM(review_comment_message)) = ''
        THEN 1 ELSE 0
    END) AS Reviews_Without_Comments
FROM dbo.order_reviews;
GO

--STEP 5 : Products Table Validation.

--Check invalid product measurements

SELECT
    COUNT(*) AS Total_Products,
    SUM(CASE WHEN product_weight_g < 0 THEN 1 ELSE 0 END)
        AS Negative_Weight,
    SUM(CASE WHEN product_length_cm < 0 THEN 1 ELSE 0 END)
        AS Negative_Length,
    SUM(CASE WHEN product_height_cm < 0 THEN 1 ELSE 0 END)
        AS Negative_Height,
    SUM(CASE WHEN product_width_cm < 0 THEN 1 ELSE 0 END)
        AS Negative_Width
FROM dbo.products;
GO

--Check zero product measurements

SELECT
    SUM(CASE WHEN product_weight_g = 0 THEN 1 ELSE 0 END)
        AS Zero_Weight,
    SUM(CASE WHEN product_length_cm = 0 THEN 1 ELSE 0 END)
        AS Zero_Length,
    SUM(CASE WHEN product_height_cm = 0 THEN 1 ELSE 0 END)
        AS Zero_Height,
    SUM(CASE WHEN product_width_cm = 0 THEN 1 ELSE 0 END)
        AS Zero_Width
FROM dbo.products;
GO


--Check product category distribution
SELECT
    product_category_name,
    COUNT(*) AS Total_Products
FROM dbo.products
GROUP BY product_category_name
ORDER BY Total_Products DESC;
GO

--  STEP 6 : Sellers Table Validation.

--Check seller state distribution
SELECT
    seller_state,
    COUNT(*) AS Total_Sellers
FROM dbo.sellers
GROUP BY seller_state
ORDER BY Total_Sellers DESC;
GO

--Check missing or blank seller locations
SELECT
    SUM(CASE
        WHEN seller_city IS NULL OR LTRIM(RTRIM(seller_city)) = ''
        THEN 1 ELSE 0
    END) AS Missing_City,
    SUM(CASE
        WHEN seller_state IS NULL OR LTRIM(RTRIM(seller_state)) = ''
        THEN 1 ELSE 0
    END) AS Missing_State
FROM dbo.sellers;
GO

--Check invalid ZIP prefixes
SELECT COUNT(*) AS Invalid_Seller_Zip_Prefixes
FROM dbo.sellers
WHERE seller_zip_code_prefix IS NULL
   OR LEN(seller_zip_code_prefix) <> 5
   OR seller_zip_code_prefix LIKE '%[^0-9]%';
GO

--STEP 7 : Geolocation Table Validation.

--Check invalid latitude and longitude
SELECT
    COUNT(*) AS Total_Records,
    SUM(CASE
        WHEN geolocation_lat NOT BETWEEN -90 AND 90
        THEN 1 ELSE 0
    END) AS Invalid_Latitude,
    SUM(CASE
        WHEN geolocation_lng NOT BETWEEN -180 AND 180
        THEN 1 ELSE 0
    END) AS Invalid_Longitude
FROM dbo.geolocation;
GO

--Check missing geographical information
SELECT
    SUM(CASE WHEN geolocation_zip_code_prefix IS NULL THEN 1 ELSE 0 END)
        AS Missing_ZIP,
    SUM(CASE WHEN geolocation_lat IS NULL THEN 1 ELSE 0 END)
        AS Missing_Latitude,
    SUM(CASE WHEN geolocation_lng IS NULL THEN 1 ELSE 0 END)
        AS Missing_Longitude,
    SUM(CASE WHEN geolocation_city IS NULL THEN 1 ELSE 0 END)
        AS Missing_City,
    SUM(CASE WHEN geolocation_state IS NULL THEN 1 ELSE 0 END)
        AS Missing_State
FROM dbo.geolocation;
GO

--Check ZIP prefix distribution
SELECT
    geolocation_zip_code_prefix,
    COUNT(*) AS Total_Records
FROM dbo.geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1
ORDER BY Total_Records DESC;
GO

--STEP 8 : Category Translation Validation

--Check missing translations
SELECT
    COUNT(*) AS Total_Categories,
    SUM(CASE
        WHEN product_category_name IS NULL
        THEN 1 ELSE 0
    END) AS Missing_Portuguese_Category,
    SUM(CASE
        WHEN product_category_name_english IS NULL
        THEN 1 ELSE 0
    END) AS Missing_English_Category
FROM dbo.product_category_name_translation;
GO

--Check duplicate category names
SELECT
    product_category_name,
    COUNT(*) AS Duplicate_Count
FROM dbo.product_category_name_translation
GROUP BY product_category_name
HAVING COUNT(*) > 1;
GO

--Check blank English translations
SELECT *
FROM dbo.product_category_name_translation
WHERE LTRIM(RTRIM(product_category_name_english)) = '';
GO