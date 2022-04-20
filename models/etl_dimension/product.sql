{{ config(
  materialized = 'incremental',
  unique_key = 'product_key'
) }}

SELECT DISTINCT
    o.product_id      as product_key
  , o.product_name
  , o.category        as product_category_name
  , o.sub_category    as product_sub_category_name
FROM
    {{ source('data_source', 'tmp_orders') }} o
WHERE
    NOT EXISTS (SELECT p.product_key 
                FROM {{ source('data_storage', 'product') }} p
                WHERE p.product_key = o.product_id
                )