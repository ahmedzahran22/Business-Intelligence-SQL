# 🎬 Sakila Entertainment: Strategic Business Intelligence Report

## 📌 Project Overview
This project transforms raw transactional data from the **Sakila DVD Rental database** into high-level strategic insights. Using **Advanced SQL (MySQL)**, I analyzed a dataset of **16,000+ transactions** and **1,000 films** to evaluate revenue drivers, customer lifecycle value, and operational consistency across global locations.

---

## 🚀 Executive Summary (Key Insights)

| Metric | Achievement | Insight |
| :--- | :--- | :--- |
| **Total Revenue** | **$67.4K** | Driven by 16,049 successful transactions. |
| **Peak Growth** | **+195% MoM** | Massive surge identified between June and July 2005[cite: 1]. |
| **Top Category** | **Sports** | Highest grossing category at **$4,892** in total sales[cite: 1]. |
| **Market Parity** | **50/50 Split** | Near-perfect revenue balance between Store 1 and Store 2[cite: 1]. |

---

## 🛠️ Technical Deep Dive

### 1️⃣ Advanced Analytics & Window Functions
*   **Trend Analysis:** Leveraged `LAG()` to calculate Month-over-Month growth and identify seasonal spikes[cite: 1].
*   **Performance Ranking:** Implemented `RANK()` to dynamically identify top-grossing films and categories per month[cite: 1].

---

### 2️⃣ Customer Intelligence (CRM)
*   **Value Segmentation:** Built a classification model using `CASE` statements to segment **599 customers** into:[cite: 1]
    *   💎 **High Value:** > $150 spend[cite: 1].
    *   ⭐ **Medium Value:** $50 - $150 spend[cite: 1].
    *   📉 **Low Value:** < $50 spend[cite: 1].

---

### 3️⃣ Operational Efficiency
*   **Geographic Analysis:** Aggregated revenue by country and city, identifying **India** as the top-performing market ($6,034)[cite: 1].
*   **Staff Performance:** Tracked transaction volumes per employee to ensure workload balance[cite: 1].

---

## 🔧 Tools Used
*   **Database Engine:** MySQL (Sakila Sample Database)[cite: 1].
*   **SQL Client:** MySQL Workbench[cite: 1].
*   **Visualization:** Power BI-style Reporting Logic[cite: 1].
