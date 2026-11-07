USE Olist_Ecommerce_Analytics;
GO

--Table existence check for order_reviews
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'order_reviews';

--Check total records
SELECT COUNT(*) AS Total_Reviews
FROM dbo.order_reviews;

--Top 10 records
SELECT TOP 10 *
FROM dbo.order_reviews;

--Data quality checks

--Check NULL values
SELECT
    COUNT(*) AS Total_Reviews,
    SUM(CASE WHEN review_id IS NULL THEN 1 ELSE 0 END) AS Missing_Review_ID,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS Missing_Order_ID,
    SUM(CASE WHEN review_score IS NULL THEN 1 ELSE 0 END) AS Missing_Review_Score,
    SUM(CASE WHEN review_comment_title IS NULL THEN 1 ELSE 0 END) AS Missing_Review_Comment_Title,
    SUM(CASE WHEN review_comment_message IS NULL THEN 1 ELSE 0 END) AS Missing_Review_Comment_Message,
    SUM(CASE WHEN review_creation_date IS NULL THEN 1 ELSE 0 END) AS Missing_Review_Creation_Date,
    SUM(CASE WHEN review_answer_timestamp IS NULL THEN 1 ELSE 0 END) AS Missing_Review_Answer_Timestamp
FROM dbo.order_reviews;

--Check duplicate review IDs
SELECT review_id, COUNT(*) AS Duplicate_Count
FROM dbo.order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

--Check review scores are within the expected range (1-5)
SELECT
    review_score,
    COUNT(*) AS Total_Reviews
FROM dbo.order_reviews
GROUP BY review_score
ORDER BY review_score;

--Create primary key and foreign key constraints

--Primary Key Constraint
ALTER TABLE dbo.order_reviews
ADD CONSTRAINT PK_order_reviews PRIMARY KEY (review_id);

--Primary Key creation failed SQL Server found that this review_id appears more than once:

---Don't delete any records or create keys yet 

--( Step 1: Check whether the duplicate review ID is associated with different orders )

SELECT
    review_id,
    order_id,
    review_score,
    review_creation_date,
    review_answer_timestamp
FROM dbo.order_reviews
WHERE review_id = '00130cbe1f9d422698c812ed8ded1919';

--Step 2: Check whether the same combination repeats
SELECT
    review_id,
    order_id,
    COUNT(*) AS Duplicate_Count
FROM dbo.order_reviews
GROUP BY review_id, order_id
HAVING COUNT(*) > 1;


--Step 3: Check for NULL values
SELECT
    SUM(CASE WHEN review_id IS NULL THEN 1 ELSE 0 END) AS Null_Review_ID,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS Null_Order_ID
FROM dbo.order_reviews;

--Step 4: If both are zero, create the Composite Primary Key

ALTER TABLE dbo.order_reviews
ADD CONSTRAINT PK_order_reviews
PRIMARY KEY (review_id, order_id);

--Foreign Key Constraint ( The order_id in order_reviews must refer to an existing order in orders )
ALTER TABLE dbo.order_reviews
ADD CONSTRAINT FK_order_reviews_orders FOREIGN KEY (order_id) REFERENCES dbo.orders(order_id);


--Verify the Foreign Key
SELECT
    name AS Foreign_Key_Name,
    OBJECT_NAME(parent_object_id) AS Child_Table,
    OBJECT_NAME(referenced_object_id) AS Parent_Table
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('dbo.order_reviews');
