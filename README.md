# Customer Churn & Retention Analytics

## Project Overview

This project analyzes customer churn patterns for a telecommunications business using Python, SQL, Power BI, and statistical analysis.

The objective is to identify customer segments associated with higher churn, quantify monthly revenue at risk, conduct statistical hypothesis testing, and generate actionable retention recommendations.

---

## Tools & Technologies

- **Python** (Data cleaning, visualization, statistical testing)
- **Pandas** & **NumPy** (Data manipulation and numerical operations)
- **Matplotlib** & **Seaborn** (Statistical data visualization)
- **SciPy** (Statistical hypothesis testing)
- **SQL** & **PostgreSQL** (Database metrics and risk query segmentation)
- **Jupyter Notebook** (Interactive analysis execution)
- **Power BI** (Executive dashboard specification)

---

## Dataset

**Kaggle Dataset:** [Telco Customer Churn Dataset](https://www.kaggle.com/blastchar/telco-customer-churn)

- **Source File:** `WA_Fn-UseC_-Telco-Customer-Churn.csv`
- **Scope:** 7,043 customer records and 21 columns covering demographics, subscribed services, account information, charges, and churn status.
- **Local Dataset Placement:** Download `WA_Fn-UseC_-Telco-Customer-Churn.csv` and place it inside the `data/` directory:
  ```
  customer-churn-analytics/
  └── data/
      └── WA_Fn-UseC_-Telco-Customer-Churn.csv
  ```

---

## Analysis Performed

### 1. Data Cleaning
- **Missing Value Handling:** Identified 11 blank space strings in `TotalCharges` (corresponding to new customers with `tenure = 0`). Coerced to numeric `NaN` via `pd.to_numeric(..., errors="coerce")` without deleting records without documentation.
- **Data Type Conversion:** Converted `TotalCharges` object strings to float and mapped binary `Churn` (`Yes`/`No`) into a numeric target `ChurnFlag` (`1`/`0`).
- **Duplicate Verification:** Confirmed `0` duplicate records.
- **Customer ID Validation:** Confirmed `7,043` unique customer IDs matching total row count.

### 2. Exploratory Data Analysis
- **Overall Churn Rate:** Out of 7,043 customers, **1,869 churned** (**26.54% churn rate**, **73.46% retention rate**).
- **Churn by Contract Type:** Month-to-month contracts churn at **42.71%**, compared to **11.27%** for 1-year and **2.83%** for 2-year contracts.
- **Churn by Customer Tenure:** Early tenure customers (**0–6 months**) churn at **47.44%**, steadily decreasing to **9.25%** for customers with **49–72 months** tenure.
- **Churn by Internet Service:** Fiber optic subscribers experience **41.89% churn**, vs **18.96% for DSL** and **7.41% for No Internet**.
- **Churn by Payment Method:** Electronic check users exhibit the highest churn at **45.29%**, compared to ~15.2%–16.7% for automatic payment methods.
- **Monthly Charges Distribution:** Churned customers have significantly higher median monthly charges ($79.65 vs $64.43 for retained).

### 3. Statistical Analysis
- **Welch's t-test (Monthly Charges vs Churn Status):**
  - $T$-statistic: **18.4075**
  - $P$-value: **$8.59 \times 10^{-73}$** ($p < 0.05$)
  - *Result:* Overwhelming statistical evidence that mean monthly charges differ significantly between churned and retained customers.
- **Chi-Square Test of Independence (Contract Type vs Churn):**
  - $\chi^2$ Statistic: **1,184.60**
  - Degrees of Freedom: **2**
  - $P$-value: **$5.86 \times 10^{-258}$** ($p < 0.05$)
  - *Result:* Statistically significant association between contract type and churn status.

### 4. SQL Analysis
- Defined table schema and queries in [`sql/churn_analysis.sql`](file:///c:/Users/sn062/OneDrive/Desktop/customer-churn-analytics/sql/churn_analysis.sql).
- **Monthly Revenue at Risk:** Calculated **$139,130.85** in monthly recurring revenue tied to churned customers.
- **High-Risk Active Customer Segment:** Identified **633 active customers** with Month-to-month contracts and tenure $\le 6$ months for targeted retention campaigns.

---

## Key Insights

1. **Contract Length is the Strongest Churn Buffer:** Customers on Month-to-month contracts churn at **42.71%**, whereas annual contracts drastically reduce churn (**11.27%** for 1-Year, **2.83%** for 2-Year).
2. **First 90 Days are Critical:** Early tenure (0–6 months) accounts for **47.44% churn**, demonstrating that onboarding friction directly drives attrition.
3. **Fiber Optic Pricing & Support Friction:** Fiber optic customers experience high churn (**41.89%**), which is amplified when Tech Support is absent (**41.64% churn** vs **15.17%** with support).
4. **Manual Payment Method Risk:** Customers paying via Electronic Check churn at **45.29%**, contrasting sharply with automated bank transfer/credit card payment methods (~15.2%–16.7%).

---

## Business Recommendations

1. **Contract Migration Campaign:** Offer a targeted $5–$10/month bill discount or speed upgrade to Month-to-month subscribers who switch to a 1-Year or 2-Year contract.
2. **Early Tenure Onboarding Program:** Establish proactive check-ins and customer success outreach during the first 90 days to decrease early attrition in the 0–6 month window.
3. **Tech Support Bundling:** Include free Tech Support for the first 6 months on high-tier Fiber Optic plans to minimize customer dissatisfaction.
4. **Auto-Pay Enrollment Incentive:** Provide a one-time $10 bill credit for Electronic Check users who enroll in automated bank transfer or credit card payments.

---

## Project Structure

```
customer-churn-analytics/
├── data/
│   ├── WA_Fn-UseC_-Telco-Customer-Churn.csv    # Raw dataset (7,043 rows, 21 columns)
│   └── customer_churn_cleaned.csv            # Cleaned analytical dataset
├── notebooks/
│   └── customer_churn_analysis.ipynb          # Executed Jupyter Notebook (Steps 4–24)
├── sql/
│   └── churn_analysis.sql                     # SQL schema & analytics queries
├── dashboard/
│   └── README.md                              # Power BI Dashboard layout & metrics
├── images/                                    # EDA charts and visual plots
├── .gitignore
├── requirements.txt                           # Project dependencies
└── README.md                                  # Main project documentation
```
