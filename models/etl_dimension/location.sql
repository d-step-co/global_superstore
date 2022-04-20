{{ config(
  materialized = 'incremental',
  unique_key = 'location_key'
) }}

SELECT DISTINCT
    CONCAT(LEFT(o.state, 1), LEFT(o.city, 1) ,'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(CONCAT(o.city, o.state))), r"[^0-9]+", ""), 8))   as location_key
  , CONCAT(UPPER(LEFT(o.country, 2)),'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(o.country)), r"[^0-9]+", ""), 6))                          as location_country_key
  , o.state       as location_state_name
  , o.city        as location_city_name
FROM
    {{ ref('tmp_orders') }} o
WHERE
    NOT EXISTS (SELECT l.location_key 
                FROM globalsuperstore.data_storage.location l
                WHERE l.location_key = CONCAT(LEFT(o.state, 1), LEFT(o.city, 1) ,'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(CONCAT(o.city, o.state))), r"[^0-9]+", ""), 8))
                )