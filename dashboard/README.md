# Power BI Executive Dashboard - Customer Churn & Retention Analytics

File: `dashboard/customer_churn_dashboard.pbix`  
Data Source: `../data/customer_churn_cleaned.csv`

---

## 📊 Dashboard Architecture & Layout

This executive dashboard is designed to provide C-suite stakeholders and retention managers with real-time actionable insights into customer churn drivers and high-risk revenue cohorts.

---

## 🎯 Executive KPI Cards (Top Banner)

| KPI Metric | Value | DAX Calculation / Description |
| :--- | :---: | :--- |
| **Total Customers** | `7,043` | `DISTINCTCOUNT(customers[customerID])` |
| **Churned Customers** | `1,869` | `CALCULATE(COUNT(customers[customerID]), customers[Churn] = "Yes")` |
| **Churn Rate** | `26.54%` | `DIVIDE([Churned Customers], [Total Customers])` |
| **Retention Rate** | `73.46%` | `1 - [Churn Rate]` |
| **Monthly Revenue at Risk** | `$139,130.85` | `CALCULATE(SUM(customers[MonthlyCharges]), customers[Churn] = "Yes")` |

---

## 📉 Visual Breakdown Tiles

### 1. Churn Rate by Contract Type (Clustered Bar Chart)
- **X-Axis:** `Contract` (`Month-to-month`, `One year`, `Two year`)
- **Y-Axis:** `Churn Rate (%)`
- **Insight:** Month-to-month customers exhibit a **42.71% churn rate**, compared to **11.27%** for 1-year and **2.83%** for 2-year contracts.

### 2. Tenure Cohort Retention Risk (Column Chart)
- **X-Axis:** `TenureGroup` (`0-6 Months`, `7-12 Months`, `13-24 Months`, `25-48 Months`, `49-72 Months`)
- **Y-Axis:** `Churn Rate (%)`
- **Insight:** Early tenure customers (0–6 months) churn at **47.44%**, highlighting a crucial onboarding retention window.

### 3. Internet Service & Tech Support Matrix (Grouped Bar Chart)
- **Legend:** `TechSupport` (`No`, `Yes`, `No internet service`)
- **Values:** `Churn Rate (%)` grouped by `InternetService` (`Fiber optic`, `DSL`)
- **Insight:** Fiber optic customers without tech support suffer the highest churn rate (~49.3%).

### 4. Revenue & Monthly Charges Distribution (Boxplot / Scatter)
- **X-Axis:** `Churn`
- **Y-Axis:** `MonthlyCharges`
- **Insight:** Churned customers have significantly higher median monthly charges ($79.65 vs $64.43 for retained).

---

## 🎯 Targeted Action Table (High-Risk Segment Slicer)

Filter panel configured for **proactive retention targeting**:
- **Filters:** `Churn = No`, `Tenure <= 6 Months`, `Contract = Month-to-month`
- **Identified Population:** `633 active high-risk customers`
- **Actionable Output:** Priority outreach list sorted by `MonthlyCharges DESC` for targeted contract-upgrade incentives.
