{{ config(
  materialized = 'incremental',
  unique_key = 'region_key'
) }}

SELECT DISTINCT
    CONCAT(LEFT(o.region, 1), UPPER(SUBSTR(o.region, 4, 1)) ,'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(o.region)), r"[^0-9]+", ""), 4)) as region_key
  , CONCAT(LEFT(o.market, 1), UPPER(SUBSTR(o.market, 2, 1)) ,'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(o.market)), r"[^0-9]+", ""), 4)) as region_market_key
  , o.region as region_name
  , o.person as region_manager_name
FROM
    {{ source('data_source', 'tmp_orders') }} o
WHERE
    NOT EXISTS (SELECT r.region_key 
                FROM {{ source('data_storage', 'region') }} r
                WHERE r.region_key = CONCAT(LEFT(o.region, 1), UPPER(SUBSTR(o.region, 4, 1)) ,'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(o.region)), r"[^0-9]+", ""), 4))
                )