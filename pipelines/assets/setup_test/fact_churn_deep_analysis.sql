/* @bruin
name: raw_data.fact_churn_deep_analysis
type: bq.sql
connection: gcp
materialization:
  type: table
depends_on:
  - raw_data.fact_customer_vs_market
@bruin */

SELECT 
    country,
    gender,
    churn,
    -- Tworzymy grupy wiekowe dla lepszej czytelności
    CASE 
        WHEN age < 30 THEN '18-29'
        WHEN age BETWEEN 30 AND 45 THEN '30-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+' 
    END AS age_group,
    
    -- Sprawdzamy, czy klient zarabia powyżej średniej rynkowej
    CASE 
        WHEN salary_difference > 0 THEN 'Above Market'
        ELSE 'Below Market'
    END AS salary_status,

    COUNT(*) as total_customers,
    SUM(churn) as churned_customers,
    ROUND(SUM(churn) / COUNT(*), 4) as churn_rate_percentage,
    ROUND(AVG(customer_monthly_salary), 2) as avg_salary
FROM `kestrasanbox.raw_data.fact_customer_vs_market`
GROUP BY 1, 2, 3, 4,5
ORDER BY country, churn_rate_percentage DESC