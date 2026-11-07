
--Table existence check for product_category_name_translation

SELECT Table_Name
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'product_category_name_translation';


--Check total records
select count(*) as Total_Records
from dbo.product_category_name_translation;

--View sample records
SELECT TOP 10 *
FROM dbo.product_category_name_translation;

--check NULLs and duplicates

SELECT
    SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS Null_Portuguese_Category,
    SUM(CASE WHEN product_category_name_english IS NULL THEN 1 ELSE 0 END) AS Null_English_Category
FROM dbo.product_category_name_translation;
GO

--4. Check duplicate Portuguese category names
SELECT
    product_category_name,
    COUNT(*) AS Duplicate_Count
FROM dbo.product_category_name_translation
GROUP BY product_category_name
HAVING COUNT(*) > 1;

--primary key constraint
ALTER TABLE dbo.product_category_name_translation
ADD CONSTRAINT PK_product_category_name_translation
PRIMARY KEY (product_category_name);

--Check unmatched categories

select p.product_category_name, ct.product_category_name
from dbo.products p
left join dbo.product_category_name_translation ct
    on p.product_category_name = ct.product_category_name
    where p.product_category_name is not null
    and ct.product_category_name is null

SELECT
    p.product_category_name,
    COUNT(*) AS Product_Count
FROM dbo.products p
LEFT JOIN dbo.product_category_name_translation ct
    ON p.product_category_name = ct.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND ct.product_category_name IS NULL
GROUP BY p.product_category_name;

select p.product_category_name, ct.product_category_name
from dbo.products p
left join dbo.product_category_name_translation ct
    on p.product_category_name = ct.product_category_name
    where p.product_category_name is not null
    and ct.product_category_name is null

--Check whether the category names have spelling differences

SELECT DISTINCT product_category_name
FROM dbo.products
WHERE product_category_name IS NOT NULL
ORDER BY product_category_name;

USE Olist_Ecommerce_Analytics;
GO

SELECT
    fk.name AS Foreign_Key_Name,
    OBJECT_NAME(fk.parent_object_id) AS Child_Table,
    OBJECT_NAME(fk.referenced_object_id) AS Parent_Table
FROM sys.foreign_keys fk
ORDER BY Child_Table;