# SQL Performance Optimization

## Project Objective ##

The objective of this stage is to understand and improve SQL query performance using SQL Server optimization techniques.

This stage focuses on:

- Understanding clustered and non-clustered indexes.
- Creating indexes to improve data retrieval.
- Exploring composite and filtered indexes.
- Understanding index scans, seeks and key lookups.
- Reviewing execution plans.
- Identifying missing index recommendations.
- Evaluating index usage and potential performance improvements.

**Tools Used:** SQL Server, SQL Server Management Studio (SSMS), VS Code.


## 1. Indexes Created

Indexes were created on selected tables to improve data retrieval and support frequently used filtering and joining operations.

| Table | Index Name | Index Type | Purpose |
|---|---|---|---|
| customers | IX_customers_unique_id | Non-Clustered | Customer lookup using customer_unique_id |
| order_items | PK_order_items | Clustered | Primary key structure |
| order_payments | IX_order_payments_installments | Non-Clustered | Payment installment filtering |
| order_payments | IX_order_payments_type | Non-Clustered | Payment type filtering |
| orders | IX_orders_customer_id | Non-Clustered | Customer-based order lookups |
| orders | IX_orders_delivered_dates | Non-Clustered | Delivery-date analysis |
| orders | IX_orders_purchase_ts | Non-Clustered | Purchase-date filtering |
| orders | IX_orders_status_delivery | Non-Clustered | Order status and delivery analysis |

**Business Insight:**

- Non-clustered indexes provide additional lookup structures for selected columns.
- Indexes on customer_id support joins between orders and customers.
- Indexes on order status and delivery dates support delivery performance analysis.
- Indexes on payment columns support payment-related filtering.

**Note:** Indexes should be evaluated using execution plans and index usage statistics. Creating too many indexes can increase storage requirements and slow down data modification operations.


## 2. Index Performance Concepts

The following SQL Server concepts were explored during the project:

| Concept | Description |
|---|---|
| Clustered Index | Determines how table data rows are organized and stored. |
| Non-Clustered Index | Creates a separate index structure containing indexed keys and row locators. |
| Composite Index | Uses two or more columns in a single index. |
| Filtered Index | Stores only rows that meet a specified filter condition. |
| Index Seek | Allows SQL Server to navigate directly to matching index entries. |
| Index Scan | Reads multiple or all entries in an index. |
| Key Lookup | Retrieves additional columns from the base table when they are not available in the non-clustered index. |
| INCLUDE Columns | Stores additional non-key columns in a non-clustered index to help cover queries. |

**Key Learning:**

Indexes can improve query performance, but the correct index design depends on query filters, join conditions, selected columns and data distribution.


## 3. Execution Plan Analysis

Execution plans were explored to understand how SQL Server processes queries and retrieves data.

**Concepts Explored:**

- Table Scan – Reads rows directly from a table.
- Index Scan – Reads entries from an index.
- Index Seek – Locates matching records using an index.
- Key Lookup – Retrieves additional columns from the underlying table.
- Estimated Execution Plan – Shows the expected query execution strategy.
- Actual Execution Plan – Shows the execution operations after running the query.

**Key Learning:**

Execution plans help identify expensive operations and understand whether indexes are being used effectively.

They also help identify opportunities to improve query performance through better indexing and query design.

## 4. Missing Index Analysis

SQL Server's missing index recommendations were reviewed to identify potential indexing improvements for frequently executed queries.

**Recommendations Identified:**

**Recommendation 1:**
- Table: `dbo.orders`
- Equality Column: `order_status`
- Inequality Column: `order_delivered_customer_date`
- Included Column: `order_purchase_timestamp`

**Recommendation 2:**
- Table: `dbo.orders`
- Equality Column: `order_status`
- Inequality Columns: `order_delivered_customer_date`, `order_estimated_delivery_date`
- Included Column: `customer_id`

**Key Learning:**

- Equality columns are commonly used with conditions such as `=`.
- Inequality columns are commonly used with conditions such as `>`, `<` and `BETWEEN`.
- Included columns can help cover queries without adding those columns to the index key.
- Missing index recommendations are suggestions, not guaranteed improvements. They should be evaluated against existing indexes and actual query execution plans before implementation.

## 5. AI-Assisted SQL Development

AI tools were used to support SQL development, query review, debugging and performance optimization learning.

**Tools Used:**

**GitHub Copilot (VS Code):**
- Assisted with SQL query completion and contextual code suggestions.
- Helped write queries faster.
- Suggested syntax improvements and query structure.

**AI Assistants (ChatGPT & Claude):**
- Reviewed SQL queries and helped identify potential issues.
- Explained complex SQL concepts, indexing and execution plans.
- Assisted with debugging and understanding query logic.
- Explored alternative query approaches and optimization techniques.
- Helped interpret SQL Server index recommendations.

**Key Learning:**

AI tools accelerated SQL development, improved productivity and supported technical learning. All suggested queries and indexing approaches were reviewed and tested in SQL Server before being used in the project.

## 6. Performance Optimization Learnings

During the project, different indexing and query optimization techniques were explored to understand how SQL Server retrieves and processes data.

**Key Learnings:**

- Indexes can improve data retrieval for frequently used filters and joins.
- Composite indexes can support queries that filter using multiple columns.
- Filtered indexes can reduce index size by storing only qualifying rows.
- INCLUDE columns can help reduce additional key lookups.
- Execution plans help identify scans, seeks and other query operations.
- Missing index recommendations can provide ideas for potential improvements.
- Excessive or overlapping indexes can increase storage usage and affect INSERT, UPDATE and DELETE performance.

**Conclusion:**

Effective SQL performance optimization requires selecting appropriate indexes, understanding query execution plans and balancing read performance with data modification overhead.