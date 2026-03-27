/* @bruin
name: raw_data.market_benchmarks
type: bq.sql
connection: gcp
materialization:
  type: table
@bruin */

SELECT 'Germany' as country, 3.1 as unemployment_rate, 4100 as avg_monthly_salary_eur UNION ALL
SELECT 'France', 7.3, 3300 UNION ALL
SELECT 'Spain', 12.9, 2250