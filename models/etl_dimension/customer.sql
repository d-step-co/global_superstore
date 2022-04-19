{{ config(
  materialized = 'incremental',
  unique_key = 'customer_key'
) }}

SELECT DISTINCT
    customer_id     as customer_key
  , customer_name
  , segment         as customer_segment
FROM
    {{ source('data_source', 'tmp_orders') }}