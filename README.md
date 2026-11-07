# Olist E-Commerce Analytics | End-to-End SQL Server Portfolio Project

## 1. Project Overview

This project focuses on analysing real-world e-commerce data using Microsoft SQL Server to identify business insights across sales performance, customer behaviour, payment patterns and delivery performance.

Using the Brazilian E-Commerce Public Dataset by Olist, I developed an end-to-end SQL analytics project covering business requirement analysis, data preparation, data quality validation, analytical query development and SQL Server performance optimization.

The project demonstrates how SQL can transform raw transactional data into meaningful business insights that support data-driven decision-making.

AI-assisted development tools, including GitHub Copilot, ChatGPT and Claude, were also used to support query development, debugging, SQL concept understanding and technical problem-solving.

## 2. Business Objectives

The primary objectives of this project were to:

- Analyse total product revenue and sales performance.
- Identify monthly and yearly sales trends.
- Determine top-performing product categories and products.
- Calculate Average Order Value (AOV).
- Analyse revenue distribution across customer states.
- Understand customer purchasing behaviour and repeat purchases.
- Evaluate payment methods and instalment patterns.
- Analyse order statuses and delivery performance.
- Evaluate on-time delivery performance across customer states.
- Explore SQL Server indexing and query performance optimization.
- Translate analytical findings into meaningful business recommendations.

## 3. Tools & Technologies

| Category | Tools |
|---|---|
| Database Management | Microsoft SQL Server |
| Query Language | SQL |
| Development Environment | Visual Studio Code |
| AI Coding Assistant | GitHub Copilot |
| AI Analysis Assistants | ChatGPT, Claude |
| Data Inspection | Microsoft Excel |
| Version Control / Portfolio | GitHub |

## 4. Dataset Description

**Dataset:** Brazilian E-Commerce Public Dataset by Olist

The dataset contains approximately 100,000 orders from a Brazilian e-commerce marketplace and provides information about customers, orders, products, sellers, payments, reviews and geographical locations.

The project uses nine CSV datasets:

| Dataset | Description |
|---|---|
| Customers | Customer identifiers and location details |
| Orders | Order information, status and timestamps |
| Order Items | Products, sellers, prices and freight values |
| Order Payments | Payment methods, values and instalments |
| Order Reviews | Customer reviews and ratings |
| Products | Product details and categories |
| Sellers | Seller information and locations |
| Geolocation | Brazilian geographical information |
| Category Translation | Portuguese-to-English product category translations |

Raw datasets were maintained separately from SQL scripts and analysis files to preserve the original source data.

## 5. Project Folder Structure

```text
Olist_SQL_Portfolio/
│
├── 01_Business_Requirements/
│
├── 02_Dataset/
│   └── Raw/
│
├── 03_SQL_Scripts/
│
├── 04_Data_Quality/
│
├── 05_Analysis/
│
├── 06_Results/
│   ├── 01_Sales_Analysis/
│   │   ├── Screenshots/
│   │   └── Sales_Findings.md
│   │
│   ├── 02_Customer_Analysis/
│   │   ├── Screenshots/
│   │   └── Customer_Findings.md
│   │
│   ├── 03_Payment_Analysis/
│   │   ├── Screenshots/
│   │   └── Payment_Findings.md
│   │
│   ├── 04_Delivery_Analysis/
│   │   ├── Screenshots/
│   │   └── Delivery_Findings.md
│   │
│   └── 05_Performance_Optimization/
│       ├── Screenshots/
│       └── Performance_Findings.md
│
├── 07_Documentation/
│   └── README.md
│
└── README.md
```

## 6. Project Workflow

The project followed a structured end-to-end analytical workflow.

1. **Business Requirements:** Defined business questions and analytical objectives.
2. **Data Preparation:** Imported the nine CSV datasets into Microsoft SQL Server.
3. **Data Quality Validation:** Investigated duplicate records, missing values, data types and table relationships.
4. **Sales Performance Analysis:** Analysed revenue, sales trends, products and categories.
5. **Customer Analytics:** Investigated customer distribution and purchasing patterns.
6. **Payment Analytics:** Examined payment methods, payment values and instalments.
7. **Delivery Performance Analysis:** Evaluated order statuses, delivery timelines and on-time performance.
8. **SQL Performance Optimization:** Explored indexes, execution plans and query performance.
9. **Documentation:** Consolidated findings, technical challenges, recommendations and project outcomes.

## 7. SQL Concepts Demonstrated

The project provided practical experience with the following SQL concepts.

### SQL Fundamentals

- SELECT, WHERE and ORDER BY
- GROUP BY and HAVING
- DISTINCT
- Aggregate functions: SUM, COUNT, AVG, MIN and MAX
- CASE expressions

### Joins and Data Relationships

- INNER JOIN
- LEFT JOIN
- Primary keys and foreign keys
- Relational database concepts

### Intermediate and Advanced SQL

- Common Table Expressions (CTEs)
- Subqueries
- Date and string functions
- DATEDIFF and date-based analysis
- Window functions
- ROW_NUMBER, RANK and DENSE_RANK
- LAG and analytical calculations

### SQL Server Performance

- Clustered and nonclustered indexes
- Composite indexes
- Included columns
- Filtered indexes
- Index usage statistics
- Missing index recommendations
- Execution plans
- Logical reads and execution time

## 8. Business Analysis Areas

### 8.1 Sales Performance Analysis

**Business Questions:**

- What is the total product revenue?
- How does revenue change month over month and year over year?
- Which product categories generate the highest revenue?
- Which are the top 10 revenue-generating products?
- What is the Average Order Value (AOV)?
- Which customer states contribute the highest revenue?

**Key Analytical Areas:**

- Total product revenue
- Monthly revenue trends
- Yearly revenue trends
- Revenue by product category
- Top 10 products
- Average Order Value
- Revenue by customer state

### 8.2 Customer Analytics

**Business Questions:**

- How are customers distributed across states?
- How many customers have placed repeat orders?
- What is the difference between one-time and repeat customers?
- What purchasing patterns can be identified?

**Key Analytical Areas:**

- Customer distribution
- Repeat customer analysis
- One-time versus repeat customers
- Customer purchasing behaviour
- Customer order distribution

### 8.3 Payment Analytics

**Business Questions:**

- Which payment methods are commonly used?
- What is the total payment value by payment type?
- How do payment instalments vary?
- How do payment values change over time?
- What is the average payment value per order?

**Key Analytical Areas:**

- Payment method distribution
- Total payment value by payment type
- Credit card instalment analysis
- Monthly payment trends
- Average payment per order

### 8.4 Delivery Performance Analysis

**Business Questions:**

- How many orders have been delivered and not delivered?
- How many orders were delivered on time?
- How do actual delivery dates compare with estimated dates?
- How many days do late orders exceed their estimated delivery dates?
- Which customer states have better or weaker delivery performance?

**Key Analytical Areas:**

- Order status distribution
- On-time versus late delivery analysis
- Average delivery time
- Average delivery delay
- Average delivery time by customer state
- On-time delivery percentage by customer state

## 9. Key Business Findings

The following results were identified through the completed SQL analysis.

| Business Metric | Analytical Result |
|---|---:|
| Total Product Revenue | R$13,591,643.70 |
| Average Order Value | R$136.68 |
| Total Unique Customers | 96,096 |
| Repeat Customers | 2,997 |
| Average Payment per Order | R$160.99 |
| Average Delivery Time | 12 days |
| Average Delivery Delay for Late Orders | 8.87 days |
| Total Delivered Orders | 96,478 |
| On-Time Delivered Orders | 89,936 |
| Late Delivered Orders | 6,534 |

**Additional Insights:**

- Health & Beauty was the highest-revenue product category.
- São Paulo (SP) contributed the highest customer-state revenue.
- Credit cards were the most frequently used payment method.
- November 2017 recorded the highest monthly product revenue in the analysed results.
- Most customers placed only one order.
- AM recorded the highest state-level on-time delivery percentage at 97.24%.
- AL recorded the lowest state-level on-time delivery percentage at 78.59%.

*Note: These figures represent the results of the specific SQL queries and definitions used in this project.*

## 10. SQL Performance Optimization

A dedicated stage was included to understand how SQL Server indexes and query execution affect database performance.

**Topics Explored:**

- Existing index inspection
- Clustered versus nonclustered indexes
- Composite index structures
- Included columns and their purpose
- Filtered indexes
- Index usage statistics
- User seeks, scans, lookups and updates
- Missing index recommendations
- Actual execution plans
- Logical reads and execution time

**Optimization Approach:**

- Reviewed existing indexes in SQL Server.
- Explored how indexes support filtering and data retrieval.
- Studied the difference between index key columns and included columns.
- Investigated missing index recommendations.
- Examined how index design relates to analytical query requirements.
- Considered index maintenance and storage overhead.

The objective was to understand SQL Server performance optimization principles and make informed indexing decisions rather than creating indexes without evaluating their purpose.

## 11. AI-Assisted SQL Development

AI tools were incorporated into the development workflow to improve productivity, accelerate query writing and support technical analysis.

### GitHub Copilot – Visual Studio Code

Used as an AI coding assistant during SQL development.

- Accelerated SQL query writing through contextual code suggestions.
- Assisted with query completion and syntax improvements.
- Supported faster development directly within Visual Studio Code.
- Helped refine SQL scripts during development.

### AI Assistants – ChatGPT & Claude

Used as AI-assisted learning, review and problem-solving tools.

- Reviewed SQL queries and explored potential improvements.
- Assisted with debugging and troubleshooting SQL errors.
- Helped understand complex joins, CTEs and window functions.
- Supported analysis of query logic and alternative approaches.
- Explained SQL Server index structures and indexing strategies.
- Assisted in understanding execution plans and performance optimization concepts.

### Validation Approach

AI-generated suggestions were reviewed and tested using Microsoft SQL Server. Final query implementation and technical decisions were based on SQL correctness, database behaviour and performance considerations rather than relying entirely on AI-generated outputs.

## 12. Project Outcomes

The project provided practical experience in building an end-to-end SQL analytics solution using a real-world e-commerce dataset.

### Technical Outcomes

- Imported and worked with nine related CSV datasets in Microsoft SQL Server.
- Explored relational database structures and relationships between multiple tables.
- Performed data quality checks and investigated duplicate records, missing values and data type inconsistencies.
- Developed analytical SQL queries using joins, aggregations, CTEs and window functions.
- Analysed sales, customer, payment and delivery-related business questions.
- Explored SQL Server indexing strategies and query performance concepts.
- Organised SQL scripts, analysis files, results and documentation into a structured portfolio project.

### Business Analysis Outcomes

- Evaluated product and category revenue performance.
- Identified monthly and yearly sales patterns.
- Analysed customer purchasing and repeat-order behaviour.
- Examined payment methods and instalment patterns.
- Evaluated order statuses and delivery performance.
- Compared on-time delivery performance across customer states.
- Translated analytical findings into potential business recommendations.

### Professional Development Outcomes

- Improved practical SQL query-writing and analytical skills.
- Strengthened understanding of relational databases and data quality.
- Gained exposure to SQL Server performance optimization.
- Developed experience using AI tools to support coding, debugging and technical learning.
- Improved the ability to translate business questions into structured SQL analysis.

## 13. Challenges & Solutions

During development, several practical database and SQL challenges were encountered.

| Challenges | Approach / Solution |
|---|---|
| CSV import errors | Reviewed column definitions, data types and NULL handling to resolve import issues. |
| Data type mismatches | Identified incompatible column types between related tables and corrected them before establishing relationships. |
| Duplicate records | Investigated duplicate key values that prevented certain primary key constraints from being created. |
| Primary and foreign key relationships | Examined table relationships and validated key columns before defining database constraints. |
| Complex multi-table joins | Studied table relationships and used appropriate join conditions to retrieve accurate results. |
| Analytical query development | Broke down business questions into smaller steps using CTEs, aggregations and subqueries. |
| Understanding window functions | Practised ranking and analytical calculations using practical examples. |
| Understanding index structures | Explored clustered, nonclustered, composite and filtered indexes to understand how SQL Server stores and accesses data. |
| Index selection | Reviewed existing indexes and missing index recommendations to understand potential indexing improvements. |
| Query performance concepts | Explored execution plans, index usage statistics, logical reads and execution time. |
| SQL debugging | Used SQL error messages, query testing and AI-assisted explanations to investigate and resolve development issues. |

These challenges helped build a better understanding of real-world database development, data validation and SQL troubleshooting.

## 14. Key Learnings

Through this project, I strengthened my understanding of:

- Converting business requirements into analytical SQL queries.
- Working with multiple related datasets.
- Relational database design and table relationships.
- Data quality checks and validation.
- Sales, customer, payment and delivery analytics.
- Writing SQL queries using joins, CTEs and window functions.
- Understanding clustered, nonclustered and filtered indexes.
- Exploring SQL Server query performance and execution plans.
- Using AI-assisted tools to improve SQL development productivity.
- Documenting analytical findings and communicating business insights.

## 15. Business Recommendations

The analytical findings can support business teams in identifying opportunities for improvement.

- **Sales Monitoring:** Track monthly revenue and category performance to identify sales trends and changes in demand.
- **Product Strategy:** Monitor high-performing products and categories to support product planning and inventory decisions.
- **Customer Retention:** Use repeat-purchase analysis to understand customer retention and identify opportunities to improve engagement.
- **Payment Analysis:** Monitor payment method and instalment patterns to better understand customer payment preferences.
- **Delivery Monitoring:** Track on-time delivery performance and delays to identify areas requiring operational attention.
- **Geographical Analysis:** Use state-level revenue, customer distribution and delivery performance to support regional planning.

These recommendations should be interpreted alongside the actual findings and limitations of the dataset.

## 16. Conclusion

This project demonstrates an end-to-end SQL analytics workflow using a real-world e-commerce dataset.

From importing and validating raw data to developing business-focused analytical queries and exploring SQL performance optimization, the project provided practical exposure to the key stages of data analysis using Microsoft SQL Server.

It also demonstrated how AI-assisted tools such as GitHub Copilot, ChatGPT and Claude can support faster SQL development, query review, troubleshooting and technical learning when combined with independent validation.

*Overall, the project reflects the application of SQL, analytical thinking, database concepts and AI-assisted development to convert raw e-commerce data into meaningful business insights.*