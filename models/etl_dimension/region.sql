{{ config(
  materialized = 'incremental',
  unique_key = 'region_key'
) }}

SELECT DISTINCT
    CONCAT(LEFT(region, 1), UPPER(SUBSTR(region, 4, 1)) ,'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(region)), r"[^0-9]+", ""), 4)) as region_key
  , CONCAT(LEFT(market, 1), UPPER(SUBSTR(market, 2, 1)) ,'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(market)), r"[^0-9]+", ""), 4)) as region_market_key
  , region as region_name
  , person as region_manager_name
FROM
    {{ source('data_source', 'tmp_orders') }}