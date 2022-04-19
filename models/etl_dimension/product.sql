{{ config(
  materialized = 'incremental',
  unique_key = 'product_key'
) }}

SELECT DISTINCT
    product_id      as product_key
  , product_name
  , category        as product_category_name
  , sub_category    as product_sub_category_name
FROM
    {{ source('data_source', 'tmp_orders') }}