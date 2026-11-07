USE Olist_Ecommerce_Analytics;
GO

-- Table existence check for payments
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'products';

--Check total records
SELECT COUNT(*) AS Total_Products
FROM dbo.products;

--View sample records
SELECT TOP 10 *
FROM dbo.products;

--Check NULLs and duplicates

--Check duplicate product IDs
SELECT product_id, COUNT(*) AS Duplicate_Count
FROM dbo.products
GROUP BY product_id
HAVING COUNT(*) > 1;

--Check missing product details

SELECT
    COUNT(*) AS Total_Products,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS Missing_Product_ID,
    SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Category_Name,
    SUM(CASE WHEN product_name_lenght IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Name_Length,
    SUM(CASE WHEN product_description_lenght IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Description_Length,
    SUM(CASE WHEN product_photos_qty IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Photos_Qty,
    SUM(CASE WHEN product_weight_g IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Weight_G,
    SUM(CASE WHEN product_length_cm IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Length_CM,
    SUM(CASE WHEN product_height_cm IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Height_CM,
    SUM(CASE WHEN product_width_cm IS NULL THEN 1 ELSE 0 END) AS Missing_Product_Width_CM
FROM dbo.products;

--Check product IDs linked to order items
SELECT
    p.product_id,
    COUNT(oi.order_id) AS Total_Orders
FROM dbo.products p
LEFT JOIN dbo.order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY Total_Orders DESC;

--Step 4: Create the Primary Key ( First, make sure- product_id has no NULL values Duplicate product ID check returned zero rows )

--Primary Key Constraint
ALTER TABLE dbo.products
ADD CONSTRAINT PK_products
PRIMARY KEY (product_id);

--Connect products with order_items
SELECT COUNT(*) AS Items_Without_Matching_Products
FROM dbo.order_items oi
LEFT JOIN dbo.products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

--Create Foreign Key Constraint for order items referencing products
ALTER TABLE dbo.order_items
ADD CONSTRAINT FK_order_items_products
FOREIGN KEY (product_id)
REFERENCES dbo.products(product_id);
GO

--The products table does not need a Foreign Key to order_items.We created the relationship in the opposite direction:


