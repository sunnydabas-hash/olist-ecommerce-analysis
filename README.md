# 🛒 Olist E-Commerce Performance Analysis

> A end-to-end data analysis project using **Oracle SQL**, **Tableau**, and **Python (D3.js)** to uncover revenue trends, delivery failures, and customer satisfaction insights from 100,000+ real Brazilian e-commerce orders.

---

## 📌 Project Overview

This project analyzes the **Olist Brazilian E-Commerce dataset** (sourced from Kaggle) to answer 9 critical business questions across revenue, logistics, customer behavior, and seller performance.

The goal: turn raw transactional data into **actionable business recommendations** that a real e-commerce manager could act on immediately.

---

## 🎯 Business Questions Answered

| # | Question | Tool |

| 1 | Which product categories generate the most revenue? | SQL + Tableau |
| 2 | Is the business growing month over month? | SQL + Tableau |
| 3 | Which Brazilian states drive the most orders? | SQL + D3.js Map |
| 4 | What % of orders are delivered late — and which categories suffer most? | SQL + Tableau |
| 5 | Does late delivery directly hurt customer review scores? | SQL + Tableau |
| 6 | Which categories have the highest average order value? | SQL |
| 7 | Who are the top sellers — and are high-revenue sellers reliable? | SQL + Tableau |
| 8 | How do customers prefer to pay? | SQL + Tableau |
| 9 | When do customers shop most — by day and hour? | SQL + Tableau |

---

## 💡 Key Findings

### 1. 🚀 Hypergrowth — 24x Revenue in 13 Months
Revenue grew from ~$40K (Oct 2016) to ~$988K (Nov 2017) — a **24x increase in just 13 months**. The business entered a revenue plateau in 2018 ($826K–$977K/month), signaling maturity.

### 2. 🏆 Health & Beauty Leads Revenue
**Health & Beauty** topped revenue at $1.23M across 8,647 orders. However, **Watches & Gifts** had the highest average order value at $199 — fewer customers spending significantly more per purchase.

### 3. ⚠️ Late Deliveries Kill Customer Satisfaction
This is the project's most powerful finding:
- **On-time deliveries** average a **4.31 review score**
- **Late deliveries** average only **2.59 review score**
- **49.5% of late orders receive a 1-star review** vs only 6.6% for on-time orders
- Late delivery is the **#1 driver of negative reviews** on the platform

### 4. 📍 São Paulo Dominates — But North is Untapped
SP accounts for **41.98% of all orders** and $5M+ in revenue. SP + RJ + MG together = **66.5% of the entire business**. Northern states like Paraíba ($192 AOV) and Alagoas ($185 AOV) have low volume but high spend per order — a clear expansion opportunity.

### 5. 💳 Credit Card Dominates Payments
**75.31% of orders** use credit card, generating $12.1M in revenue. Brazilian customers average **3.5 installments** per credit card purchase — optimizing installment options on high-AOV categories could significantly increase conversion.

### 6. 🕓 Monday is Peak Shopping Day
Monday (16.27%) and Tuesday (16.07%) are the busiest days. Peak hour is **4PM (6.71%)**. Marketing campaigns and push notifications sent **Monday at 9–10AM** would maximize reach.

---

## 📊 Dashboards

### Tableau Dashboard
> <img width="1456" height="848" alt="Screenshot 2026-05-01 at 3 35 56 PM" src="https://github.com/user-attachments/assets/788028f9-c942-4d33-ab26-762cef26c8c0" />
 · Seller Performance · Payment Methods · Late Delivery Analysis
<img width="1422" height="867" alt="Screenshot 2026-05-01 at 3 35 11 PM" src="https://github.com/user-attachments/assets/0adde2c4-9cfe-47d2-851c-9c5de60bc1c8" />

🔗 **[View Live Tableau Dashboard](#)** ← *(add your Tableau Public link here)*

### Interactive Brazil State Map
> Built with D3.js — hover over any state to see orders, revenue, and avg order value

🔗[Orders_by_Brazilian](file:///Users/sunny/Downloads/brazil_map.html)

---<img width="1433" height="868" alt="Screenshot 2026-05-01 at 3 34 06 PM" src="https://github.com/user-attachments/assets/41169896-6549-499e-a1db-8dfa6766b0f6" />


## 🗂️ Project Structure

```
olist-ecommerce-analysis/
│
├── README.md                          ← You are here
│
├── sql/
│   └── analysis.sql                   ← All 9 Oracle SQL queries with comments
│
├── insights/
│   └── insights_memo.pdf              ← 1-page analyst recommendations memo
│
├── brazil_map.html                    ← Interactive D3.js Brazil state map
│
└── data/                              ← Query result CSVs (exported from Oracle)
    ├── query1_top_categories.csv
    ├── query2_monthly_revenue.csv
    ├── query3_states.csv
    ├── query4_late_deliveries.csv
    ├── query5_delivery_reviews.csv
    ├── query6_avg_order_value.csv
    ├── query7_top_sellers.csv
    ├── query8_payment_methods.csv
    └── query9_peak_days_hours.csv
```

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **Oracle SQL 19c** | Data extraction, joins, aggregations, window functions |
| **Oracle SQL Developer** | Query development and CSV export |
| **Tableau Public** | Interactive dashboards and visualizations |
| **D3.js** | Custom interactive Brazil choropleth map |
| **Docker** | Oracle database containerization |
| **GitHub** | Version control and project hosting |

---

## 📁 Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle

| Table | Rows | Description |
|-------|------|-------------|
| orders | 99,441 | Order status and timestamps |
| order_items | 112,650 | Products, prices, freight per order |
| customers | 99,441 | Customer location data |
| products | 32,951 | Product details and categories |
| payments | 103,886 | Payment type and value |
| reviews | 99,224 | Customer review scores |
| sellers | 3,095 | Seller location data |
| category_translation | 71 | Portuguese → English category names |

---

## 💼 Business Recommendations

Based on the analysis, here are 3 actionable recommendations:

### Recommendation 1 — Fix Delivery to Protect Revenue
Late deliveries are generating **49.5% one-star reviews** and putting ~$812K in repeat revenue at risk. Priority fix: Furniture Mattress (15.7 avg days late) and Bed Bath Table (920 late orders). Invest in logistics partnerships in high-latency regions.

### Recommendation 2 — Expand Marketing to Northern States
States like Bahia, Ceará, and Pernambuco are large population centers with only 1–3% order share. Northern customers already spend more per order ($185–$192 AOV). Targeted marketing investment here could unlock significant new revenue.

### Recommendation 3 — Optimize Installment Options for High-AOV Categories
75% of customers pay by credit card averaging 3.5 installments. Offering 6x and 12x installment options on Computers ($1,099 AOV) and Watches ($199 AOV) categories could significantly reduce purchase friction and increase conversion.

---

## 👤 Author

**Sunny**
Data Analyst | Oracle SQL · Tableau · Data Storytelling
[Linkedln](https://www.linkedin.com/public-profile/settings?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_self_edit_contact-info%3BSBILCRaSSLWuoOxO2SIe3Q%3D%3D) 🔗 [[GitHub](https://github.com/repos?q=owner%3A%40me) | 📧 tarundabas55@gmail.com

---

## 📄 License

This project uses publicly available data from Kaggle under the CC BY-NC-SA 4.0 license.
