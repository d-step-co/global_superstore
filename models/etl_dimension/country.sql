{{ config(
  materialized = 'incremental',
  unique_key = 'country_key'
) }}

SELECT DISTINCT
    CONCAT(UPPER(LEFT(country, 2)),'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(country)), r"[^0-9]+", ""), 6))  as country_key
  , CONCAT(UPPER(LEFT(market, 2)),'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(market)), r"[^0-9]+", ""), 4))    as country_market_key
  , country as country_name
FROM
    {{ source('data_source', 'tmp_orders') }}