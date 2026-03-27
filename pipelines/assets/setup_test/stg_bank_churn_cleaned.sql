/* @bruin
name: raw_data.stg_bank_churn_cleaned
type: bq.sql
connection: gcp
materialization:
  type: table
columns:
  - name: customer_id
    tests:
      - not_null
      - unique
@bruin */

SELECT DISTINCT
    -- Mapujemy kolumny na małe litery (dobra praktyka)
    CAST(customer_id AS INT64) as customer_id,
    credit_score,
    country,
    gender,
    age,
    tenure,
    balance,
    products_number,
    credit_card,
    active_member,
    estimated_salary,
    -- Zamieniamy churn na boolean, żeby łatwiej się analizowało
    CAST(churn AS BOOL) as has_churned
FROM `kestrasanbox.raw_data.stg_bank_churn`
WHERE customer_id IS NOT NULL 
  AND age > 0