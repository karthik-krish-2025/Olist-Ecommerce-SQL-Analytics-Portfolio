# Stage 4 – Data Quality Report

## 1. Project Information

- **Project:** Olist Brazilian E-Commerce Analytics
- **Database:** SQL Server
- **Database Name:** Olist_Ecommerce_Analytics
- **Stage:** Stage 4 – Data Quality Checks
- **Analysis Focus:** Sales and Customer Analytics

## 2. Objective

The objective of this stage is to evaluate the quality and reliability of the Olist dataset before performing business analysis.

We performed checks for missing values, invalid values, duplicate records, and relationships between tables.

## 3. Tables Checked

The following nine tables were included:

1. customers
2. orders
3. order_items
4. order_payments
5. order_reviews
6. products
7. sellers
8. geolocation
9. category_translation

## 4. Data Quality Checks Performed

### 4.1 Relationship Checks

Checked whether records in child tables had matching records in their related parent tables.

Checks included:
- Orders without matching customers.
- Order items without matching orders.
- Order items without matching products.
- Order items without matching sellers.
- Payments without matching orders.
- Reviews without matching orders.

**Observed result:** The relationship checks reported zero unmatched records.

### 4.2 NULL Value Checks

Checked important columns across the nine tables for missing values.

### 4.3 Duplicate Checks

Checked key columns and combinations of columns for duplicate records.

### 4.4 Invalid Value Checks

Checked for:
- Negative or zero item prices and freight values.
- Invalid order dates and delivery dates.
- Invalid payment values and installment counts.
- Review scores outside the expected range of 1–5.
- Invalid product measurements.
- Missing or invalid seller location details.
- Invalid latitude and longitude values.
- Missing or duplicate category translations.

## 5. Identified Data Quality Exceptions

### 5.1 Missing Product Category Translations

Two product categories in the products table did not have matching English translations in the category_translation table.

- One unmatched category had 3 products.
- Another unmatched category had 10 products.

**Decision:** These records will be retained. We will use LEFT JOIN during category analysis so that products without English translations are not excluded.

### 5.2 Geolocation Records

The geolocation table contains repeated ZIP code prefixes.

**Decision:** The original geolocation data will be retained. Repeated ZIP prefixes are not automatically treated as errors because one ZIP prefix can have multiple geographic coordinates.

### 5.3 Review IDs

Duplicate review_id values were observed across different orders.

**Decision:** The review_id and order_id combination was used for the review table's primary key after checking the combination for uniqueness.

## 6. Data Quality Handling Decisions

| Finding | Decision |
|---|---|
| Unmatched relationship records | No unmatched records reported in the checks |
| Missing category translations | Retain and handle using LEFT JOIN |
| Repeated geolocation ZIP prefixes | Retain raw records |
| Duplicate review IDs | Use composite key with order_id |

## 7. Conclusion

The Olist dataset has undergone initial data quality validation.

Relationship checks reported zero unmatched records. Some dataset-specific exceptions, including missing category translations and repeated geolocation ZIP prefixes, were identified and documented.

The raw dataset will be preserved. Appropriate handling methods will be applied during analysis to avoid losing valid business information.

**Next Stage:** Stage 5 – Basic SQL Analysis.
