# Database Schema – Olist E-Commerce Analytics

## 1. Database Information

- **Database Name:** Olist_Ecommerce_Analytics
- **Database Platform:** Microsoft SQL Server
- **Dataset:** Olist Brazilian E-Commerce Public Dataset

## 2. Database Tables

| Table Name | Description |
|---|---|
| customers | Contains customer details and location information |
| orders | Contains order dates, status and delivery information |
| order_items | Contains products purchased within each order |
| order_payments | Contains payment methods, instalments and payment values |
| order_reviews | Contains customer reviews and ratings |
| products | Contains product details and category information |
| sellers | Contains seller information and location details |
| category_translation | Maps Portuguese product categories to English names |
| geolocation | Contains geographical coordinates associated with ZIP code prefixes |

## 3. Primary Keys

| Table | Primary Key |
|---|---|
| customers | customer_id |
| orders | order_id |
| order_items | order_id, order_item_id |
| order_payments | order_id, payment_sequential |
| order_reviews | review_id, order_id |
| products | product_id |
| sellers | seller_id |
| category_translation | product_category_name |

**Note:** The geolocation table does not have a primary key because ZIP code prefixes can appear multiple times.

## 4. Foreign Key Relationships

| Child Table | Child Column | Parent Table | Parent Column |
|---|---|---|---|
| orders | customer_id | customers | customer_id |
| order_items | order_id | orders | order_id |
| order_items | product_id | products | product_id |
| order_items | seller_id | sellers | seller_id |
| order_payments | order_id | orders | order_id |
| order_reviews | order_id | orders | order_id |
| products | product_category_name | category_translation | product_category_name |

## 5. Important Data Relationships

- One customer can place multiple orders.
- One order can contain multiple product items.
- One order can have multiple payment records.
- One seller can fulfil multiple order items.
- One product can appear in multiple order items.
- One order can have review records.

## 6. Important Analytical Considerations

- The order_items table contains one row per order item.
- The order_payments table can contain multiple payment records for one order.
- The customer_unique_id column identifies the same customer across different customer records.
- The geolocation table can contain repeated ZIP code prefixes.
- Category translations are joined using LEFT JOIN because some categories do not have English translations.
- Aggregation should be performed carefully before joining tables with multiple records per order to avoid duplicated values.