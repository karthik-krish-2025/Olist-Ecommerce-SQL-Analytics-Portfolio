--Step 1: Import sellers

--Step 2: After importing
--We'll perform these checks:
--Total seller records.
-- NULL seller IDs.
-- Duplicate seller IDs.
-- Create Primary Key on seller_id.
-- Create Foreign Key from order_items.seller_id to sellers.seller_id

select *
from dbo.order_items

--1 . Check total records in sellers table
SELECT COUNT(*) AS Total_Sellers
FROM dbo.sellers;

2-- Check for NULL seller IDs
SELECT COUNT(*) AS Null_Seller_IDs
FROM dbo.sellers
WHERE seller_id IS NULL;

---3. Check for duplicate seller IDs
SELECT seller_id, COUNT(*) AS Duplicate_Count
FROM dbo.sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

---4. Create Primary Key on seller_id
ALTER TABLE dbo.sellers
ADD CONSTRAINT PK_sellers PRIMARY KEY (seller_id);

---5. Create Foreign Key from order_items.seller_id to sellers.seller_id
ALTER TABLE dbo.order_items
ADD CONSTRAINT FK_order_items_sellers FOREIGN KEY (seller_id) REFERENCES dbo.sellers(seller_id);

---6. Check for order_items records without matching sellers
SELECT COUNT(*) AS Items_Without_Matching_Sellers
FROM dbo.order_items oi
LEFT JOIN dbo.sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;
