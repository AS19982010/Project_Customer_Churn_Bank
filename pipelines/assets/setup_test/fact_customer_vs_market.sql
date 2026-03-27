/* @bruin
name: raw_data.fact_customer_vs_market
type: bq.sql
connection: gcp
materialization:
  type: table
  cluster_by: ["country", "gender"]
depends_on:
  - raw_data.stg_bank_churn
  - raw_data.market_benchmarks
columns:
  - name: customer_id
    checks:
      - name: not_null
      - name: unique
@bruin */

SELECT 
    c.customer_id,
    c.country,
    c.gender,
    c.age,
    c.estimated_salary / 12 as customer_monthly_salary,
    m.avg_monthly_salary_eur as country_avg_salary,
    (c.estimated_salary / 12) - m.avg_monthly_salary_eur as salary_difference,
    CASE 
        WHEN (c.estimated_salary / 12) > m.avg_monthly_salary_eur THEN 'Above Market'
        ELSE 'Below Market'
    END AS salary_status,
    c.churn
FROM `kestrasanbox.raw_data.stg_bank_churn` c
JOIN `kestrasanbox.raw_data.market_benchmarks` m 
  ON c.country = m.country