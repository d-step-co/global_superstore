{{ config(
  materialized = 'incremental',
  unique_key = 'customer_key'
) }}

SELECT DISTINCT
    o.customer_id     as customer_key
  , o.customer_name
  , o.segment         as customer_segment
FROM
    {{ ref('tmp_orders') }} o
WHERE
    NOT EXISTS (SELECT c.customer_key 
                FROM globalsuperstore.data_storage.customer c 
                WHERE c.customer_key = o.customer_id
                )