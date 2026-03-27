/* @bruin
name: raw_data.stg_bank_churn
type: bq.sql
connection: gcp
columns:
  - name: customer_id
    tests:
      - not_null
      - unique
  - name: credit_score
    tests:
      - positive
  - name: age
    tests:
      - positive
@bruin */

CREATE OR REPLACE EXTERNAL TABLE `raw_data.stg_bank_churn`
OPTIONS (
  format = 'CSV',
  uris = ['gs://bank-churn-data-anastasija-stadnyk/raw/bank_churn.csv'],
  skip_leading_rows = 1
);