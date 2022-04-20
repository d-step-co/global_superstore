{{ config(
  materialized = 'incremental',
  unique_key = 'market_key'
) }}

SELECT DISTINCT
    CONCAT(UPPER(LEFT(o.market, 2)),'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(o.market)), r"[^0-9]+", ""), 4)) as market_key    
  , o.market as market_name
FROM
    {{ ref('tmp_orders') }} o
WHERE
    NOT EXISTS (SELECT m.market_key 
                FROM globalsuperstore.data_storage.market m
                WHERE m.market_key = CONCAT(UPPER(LEFT(o.market, 2)),'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(o.market)), r"[^0-9]+", ""), 4))
                )