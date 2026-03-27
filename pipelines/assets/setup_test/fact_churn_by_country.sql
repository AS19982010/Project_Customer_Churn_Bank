/* @bruin
name: raw_data.fact_churn_by_country
type: bq.sql
connection: gcp
materialization:
  type: table
depends_on:
  - raw_data.fact_customer_vs_market
@bruin */

SELECT 
    country,
    COUNT(*) as total_customers,
    SUM(churn) as churned_customers,
    ROUND(AVG(customer_monthly_salary), 2) as avg_customer_salary,
    ROUND(AVG(country_avg_salary), 2) as market_avg_salary,
    -- Liczymy: (suma tych co odeszli / wszyscy w kraju) * 100
    ROUND(SUM(churn) * 100.0 / COUNT(*), 2) as churn_rate_percentage
FROM `kestrasanbox.raw_data.fact_customer_vs_market`
GROUP BY country
ORDER BY churn_rate_percentage DESC