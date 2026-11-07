# Sales Analysis – Findings

## 1. Total Product Revenue

**Business Question:** What is the total revenue generated from product sales?

**SQL Result:** 
- Total Product Revenue: R$ 13,591,643.70

**Business Insight:**
- The Olist dataset generated approximately R$ 13.59 million in product revenue.
- This provides an overall view of the revenue generated through product sales.
- This figure can serve as a baseline for comparing monthly sales, product categories, and customer segments.

## 2. Monthly Revenue

**Business Question:** How does revenue change month over month?

**SQL Result:**
- Highest monthly product revenue: November 2017
- Revenue: R$ 1,010,271.37
- Several months in early 2018 also generated revenue close to R$ 1 million.



**Business Insight:**
- November 2017 recorded the highest monthly product revenue.
- Revenue remained strong during several months in early 2018.
- Monthly revenue analysis helps identify sales trends and periods of strong business performance.

## 3. Yearly Revenue

**Business Question:** How does revenue compare across years?

**SQL Result:**
- 2017 Revenue: R$ 6.16 million
- 2018 Revenue: R$ 7.39 million
- Approximate Revenue Growth: 20%

**Business Insight:**
- Olist generated R$ 6.16 million in product revenue during 2017.
- Revenue reached R$ 7.39 million in 2018.
- Revenue increased by approximately 20% compared with 2017.
- However, 2018 contains data only through September. Therefore, this is a partial-year comparison and should not be interpreted as full-year growth.

**Screenshot:**
![Yearly Revenue](Screenshots/03_yearly_revenue.png)

## 4. Top Revenue-Generating Categories

**Business Question:** Which product categories generate the highest revenue?

**SQL Result:**
| Rank | Product Category | Revenue |
| 1 | Health & Beauty | R$ 1,258,681.34 |
| 2 | Watches & Gifts | R$ 1,205,005.68 |
| 3 | Bed Bath Table | R$ 1,036,988.68 |
| 4 | Sports & Leisure | R$ 988,048.97 |
| 5 | Computers & Accessories | R$ 911,954.32 |

**Business Insight:**
- Health & Beauty is the highest revenue-generating category.
- Watches & Gifts ranks second, followed by Bed Bath Table.
- The top five categories contribute significantly to overall product revenue.
- These insights can help businesses prioritise inventory planning, product availability, and category-level sales strategies.
- The NULL category represents products without a mapped category name and should be investigated separately.

**Screenshot:**
![Top Revenue Categories](Screenshots/04_top_categories.png)

## 5. Top 10 Revenue-Generating Products

**Business Question:** Which 10 products generate the highest revenue?

**SQL Result:**

| Rank | Product ID | Revenue |
|---:|---|---:|
| 1 | bb50f2e236e5eea0100680137654686c | R$ 63,885.00 |
| 2 | 6cdd53843498f92890544667809f1595 | R$ 54,730.20 |
| 3 | d6160fb7873f184099d9bc95e30376af | R$ 48,899.34 |
| 4 | d1c427060a0f73f6b889a5c7c61f2ac4 | R$ 47,214.51 |
| 5 | 99a4788cb24856965c36a24e339b6058 | R$ 43,025.56 |
| 6 | 3dd2a17168ec895c781a9191c1e95ad7 | R$ 41,082.60 |
| 7 | 25c38557cf793876c5abdd5931f922db | R$ 38,907.32 |
| 8 | 5f504b3a1c75b73d6151be81eb05bdc9 | R$ 37,733.90 |
| 9 | 53b36df67ebb7c41585e8d54d6772e08 | R$ 37,683.42 |
| 10 | aca2eb7d00ea1a7b8ebd4e68314663af | R$ 37,608.90 |

**Business Insight:**
- The highest revenue-generating product generated R$ 63,885.00.
- The top 10 products generated individual revenues ranging from R$ 37,608.90 to R$ 63,885.00.
- Identifying high-revenue products helps businesses prioritise inventory availability and product-level sales strategies.
- Product IDs can be joined with the products table to retrieve product category information.


**Screenshot:**
![Top 10 Products](Screenshots/05_top_10_products.png)

## 6. Average Order Value (AOV)

**Business Question:** What is the average order value?

**SQL Result:**
- Average Order Value: R$ 136.68

**Business Insight:**
- The average order value is approximately R$ 136.68 per order.
- This indicates the average product value generated per order.
- Businesses can use AOV to understand customer spending patterns and identify opportunities for increasing order value through product bundles, cross-selling, and promotions.

**Screenshot:**
![Average Order Value](Screenshots/06_average_order_value.png)

## 7. Revenue by Customer State

**Business Question:** Which customer states contribute the most revenue?

**SQL Result:**

| Rank | State | Revenue |
| 1 | SP | R$ 5,202,955.05 |
| 2 | RJ | R$ 1,824,092.67 |
| 3 | MG | R$ 1,585,308.03 |
| 4 | RS | R$ 750,304.02 |
| 5 | PR | R$ 683,083.76 |
| 6 | SC | R$ 520,553.34 |
| 7 | BA | R$ 511,349.99 |
| 8 | DF | R$ 302,603.94 |
| 9 | GO | R$ 294,591.95 |
| 10 | ES | R$ 275,037.31 |

**Business Insight:**
- São Paulo (SP) is the leading revenue-generating state, with approximately R$ 5.20 million in product revenue.
- Rio de Janeiro (RJ) and Minas Gerais (MG) rank second and third.
- The top three states contribute a significant share of total product revenue.
- Businesses can use these insights for regional marketing, inventory allocation, and logistics planning.
- Revenue is concentrated in the leading states, indicating opportunities to investigate growth potential in other regions.

**Screenshot:**
![Revenue by Customer State](Screenshots/07_revenue_by_state.png)

