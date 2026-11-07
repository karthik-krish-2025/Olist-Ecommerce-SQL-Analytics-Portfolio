# Key Business Findings – Olist E-Commerce Analytics

## 1. Sales Performance

- **Total Product Revenue:** Olist generated R$ 13,591,643.70 in total product revenue from the order items dataset, excluding freight charges.

- **Monthly Revenue:** November 2017 recorded the highest monthly product revenue at R$ 1,010,271.37. Several months in early 2018 also generated revenue close to R$ 1 million.

- **Yearly Revenue:** Olist generated R$ 6.16 million in 2017 and R$ 7.39 million in 2018. Revenue increased by approximately 20% in 2018 compared with 2017. However, 2018 contains data only through September, so the comparison is between partial-year periods.

- **Top Revenue-Generating Categories:** Health & Beauty was the highest revenue-generating category, contributing R$ 1,258,681.34. Watches & Gifts ranked second with R$ 1,205,005.68, followed by Bed, Bath & Table with R$ 1,036,988.68. These categories were major contributors to Olist's product revenue.

- **Missing Category Translations:** Products generating R$ 185,049.76 in revenue had no matching English category translation. A LEFT JOIN was used to retain these products in the revenue analysis instead of excluding them.

- **Top 10 Products by Revenue:** The highest revenue-generating individual product was `bb50f2e236e5eea0100680137654686c`, generating R$ 63,885.00. The top 10 products generated individual revenues ranging from R$ 37,608.90 to R$ 63,885.00.

- **Average Order Value (AOV):** Olist generated an average product revenue of R$136.68 per order, excluding freight charges. This indicates the average product value associated with each order.

- **Revenue by State:** São Paulo (SP) generated the highest product revenue at R$5,202,955.05, followed by Rio de Janeiro (RJ) at R$1,824,092.67 and Minas Gerais (MG) at R$1,585,308.03. São Paulo was the leading revenue-generating state in the Olist marketplace.

## 2. Customer Behaviour

**Total Unique Customers:** Olist had 96,096 unique customers in the dataset, representing the distinct customers identified using `customer_unique_id`.

**Repeat Customers:** Out of 96,096 unique customers, 2,997 placed more than one order, indicating that a smaller portion of Olist customers made repeat purchases.

**Repeat Customer Rate:** Approximately 3.22% of Olist's unique customers placed more than one order, while 96.78% made only one purchase.

**Average Orders per Customer:** Olist recorded approximately 1.00 order per unique customer, indicating that most customers placed only one order.

**Customer Purchase Frequency:** 93,099 customers placed exactly one order, while 2,997 customers made repeat purchases. Only one customer placed as many as 17 orders, showing that repeat purchasing was relatively uncommon.

**Top 10 Customers:** The most frequent customer placed 17 orders, followed by a customer with 9 orders. The remaining customers in the top 10 placed between 6 and 7 orders, highlighting a small group of highly active repeat customers.

**Customer Segmentation:** Out of 96,096 unique customers, 93,099 (96.88%) were one-time buyers, 2,948 (3.07%) were occasional buyers, and only 49 (0.05%) were frequent buyers. This indicates an opportunity to improve customer retention and repeat purchases.

## 3. Delivery Performance

**Average Delivery Time:** Olist took approximately 12 days on average to deliver orders from the purchase date to the customer delivery date, considering delivered orders only.

2. **On-Time Delivery Rate:** Olist achieved an on-time delivery rate of 93.23%, with 89,936 out of 96,470 valid delivered orders reaching customers on or before the estimated delivery date. The remaining 6.77% were delivered late.

 **On-time vs Late Deliveries:** Olist delivered 89,936 orders on time and 6,534 orders late. Eight additional delivered orders were excluded from this comparison because one or both delivery dates were missing.
 
 **Average Delivery Time by State:** Roraima (RR) recorded the longest average delivery time at 29 days, followed by Amapá (AP) at 27 days and Amazonas (AM) at 26 days. São Paulo (SP) had the shortest average delivery time at 8 days, highlighting regional differences in delivery performance.

**Late Delivery Rate by State:** Alagoas (AL) recorded the highest late-delivery rate at 23.93%, followed by Maranhão (MA) at 19.67% and Piauí (PI) at 15.97%. São Paulo (SP), despite having the highest number of late orders (2,387), recorded a lower late-delivery rate of 5.89%.

**Undelivered Orders:** A total of 2,963 orders had not reached the delivered status. The largest group was shipped orders (1,107), followed by canceled orders (625) and unavailable orders (609). These results highlight orders requiring further delivery-status monitoring.

**Estimated vs Actual Delivery Difference:** Olist delivered orders approximately 11 days earlier than the estimated delivery date on average, indicating that actual deliveries generally occurred ahead of the promised dates.

**Monthly Delivery Performance:** Average delivery time generally improved over the analysis period. During 2017, delivery time mostly ranged between 11 and 15 days. By August 2018, the average delivery time had decreased to approximately 7 days, indicating improved delivery efficiency.

## 4. Payment Analysis

**Total Payment Value:** Olist recorded a total payment value of R$16,008,872.12 across all payment records, representing the overall value collected through its payment transactions.

**Popular Payment Methods:** Credit cards were the most commonly used payment method, with 76,505 payment records, followed by Boleto with 19,784. Vouchers accounted for 3,866 records, while debit cards accounted for 1,528. Only 3 records had an undefined payment type.

**Payment Value by Method:** Credit cards accounted for the highest payment value at R$12,542,084.19, followed by Boleto at R$2,869,361.27. Voucher payments contributed R$379,436.87, while debit card payments contributed R$217,989.79.

**Payment Installment Analysis:** Most customers preferred paying in a single installment, accounting for 52,546 orders. Two-installment payments accounted for 12,413 orders, followed by three-installment payments with 10,461 orders. This indicates a strong preference for single-installment payments, although some customers opted for longer payment plans.

**Average Payment Value:** The average payment value was approximately R$154.10 per payment record, indicating the typical amount recorded in an individual payment transaction.

**Monthly Payment Trends:** Monthly payment value generally increased throughout 2017, reaching its highest level in November 2017 at R$1,194,882.80. During 2018, monthly payment value remained around R$1 million for most months. The sharp decline in September and October 2018 may be due to incomplete data for the final months of the dataset.

**Payment Contribution Percentage:** Credit cards accounted for the largest share of total payment value at 78.34%, followed by Boleto at 17.92%. Vouchers contributed 2.37%, while debit cards contributed 1.36%. Together, credit cards and Boleto represented approximately 96.27% of total payment value.

**Payment Behaviour by Installments:** Single-installment payments were the most common, accounting for 49,060 orders. Ten-installment payments generated the highest total payment value among the installment options at R$2,211,577.34. Average payment value generally increased with longer installment plans, although some longer plans had relatively few orders.


## 5. Business Recommendations

### 1. Improve Customer Retention
With approximately 96.88% of customers making only one purchase, Olist should focus on customer retention through loyalty programmes, personalised offers, and repeat-purchase campaigns.

### 2. Improve Delivery Performance Across States
States such as Alagoas (AL), Maranhão (MA), and Piauí (PI) recorded higher late-delivery rates. Olist should investigate logistics challenges in these regions and work with delivery partners to improve delivery reliability.

### 3. Strengthen Sales Opportunities in High-Revenue Categories
Health & Beauty, Watches & Gifts, and Bed Bath & Table were among the top revenue-generating categories. Olist should monitor demand, maintain adequate inventory, and explore opportunities to grow sales in these categories.

### 4. Focus on High-Revenue Geographic Markets
São Paulo, Rio de Janeiro, and Minas Gerais generated the highest product revenue. Olist should continue strengthening its presence in these markets while identifying opportunities in lower-revenue states.

### 5. Optimise Payment Experience
Credit cards contributed approximately 78.34% of total payment value, followed by Boleto at 17.92%. Olist should maintain a smooth payment experience for these popular methods while evaluating opportunities to improve adoption of other payment options.