{{ config(
  materialized = 'incremental',
  unique_key = 'country_key'
) }}

SELECT DISTINCT
    CONCAT(UPPER(LEFT(o.country, 2)),'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(o.country)), r"[^0-9]+", ""), 6))  as country_key
  , CONCAT(UPPER(LEFT(o.market, 2)),'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(o.market)), r"[^0-9]+", ""), 4))    as country_market_key
  , o.country as country_name
FROM
    {{ source('data_source', 'tmp_orders') }} o
WHERE
    NOT EXISTS (SELECT c.country_key 
                FROM {{ source('data_storage', 'country') }} c 
                WHERE c.country_key = CONCAT(UPPER(LEFT(o.country, 2)),'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(o.country)), r"[^0-9]+", ""), 6))
                )