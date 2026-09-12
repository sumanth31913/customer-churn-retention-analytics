-- ============================================================
-- Customer Churn & Retention Analytics - SQL Queries
-- Database: customer_churn_db
-- Table: customers
-- ============================================================

-- ------------------------------------------------------------
-- STEP 25: Table Creation Schema
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(20),
    senior_citizen INT,
    partner VARCHAR(10),
    dependents VARCHAR(10),
    tenure INT,
    phone_service VARCHAR(30),
    multiple_lines VARCHAR(30),
    internet_service VARCHAR(30),
    online_security VARCHAR(30),
    online_backup VARCHAR(30),
    device_protection VARCHAR(30),
    tech_support VARCHAR(30),
    streaming_tv VARCHAR(30),
    streaming_movies VARCHAR(30),
    contract VARCHAR(30),
    paperless_billing VARCHAR(10),
    payment_method VARCHAR(50),
    monthly_charges NUMERIC(10,2),
    total_charges NUMERIC(10,2),
    churn VARCHAR(10)
);

-- ------------------------------------------------------------
-- STEP 26: Core KPI Analysis Queries
-- ------------------------------------------------------------

-- 1. Overall Key Performance Indicators (KPIs)
SELECT
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN churn = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN churn = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS churn_rate
FROM customers;


-- 2. Churn Analysis by Contract Type
SELECT
    contract,
    COUNT(*) AS customers,
    SUM(
        CASE
            WHEN churn = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN churn = 'Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY contract
ORDER BY churn_rate DESC;


-- 3. Monthly Revenue at Risk
SELECT
    ROUND(
        SUM(monthly_charges),
        2
    ) AS monthly_revenue_at_risk
FROM customers
WHERE churn = 'Yes';


-- ------------------------------------------------------------
-- STEP 27: Customer Segmentation & Risk Mitigation
-- ------------------------------------------------------------

-- High-Risk Existing Customer Segment
-- Criteria: Active customers (churn = 'No'), tenure <= 6 months, Month-to-month contract
SELECT
    customer_id,
    tenure,
    contract,
    monthly_charges,
    payment_method,
    tech_support
FROM customers
WHERE churn = 'No'
  AND tenure <= 6
  AND contract = 'Month-to-month'
ORDER BY monthly_charges DESC;
