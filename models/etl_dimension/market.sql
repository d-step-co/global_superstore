{{ config(
  materialized = 'incremental',
  unique_key = 'market_key'
) }}

SELECT DISTINCT
    CONCAT(UPPER(LEFT(market, 2)),'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(market)), r"[^0-9]+", ""), 4)) as market_key    
  , market as market_name
FROM
    {{ source('data_source', 'tmp_orders') }}