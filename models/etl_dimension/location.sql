{{ config(
  materialized = 'incremental',
  unique_key = 'location_key'
) }}

SELECT DISTINCT
    CONCAT(LEFT(state, 1), LEFT(city, 1) ,'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(CONCAT(city, state))), r"[^0-9]+", ""), 8))   as location_key
  , CONCAT(UPPER(LEFT(country, 2)),'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(country)), r"[^0-9]+", ""), 6))                      as location_country_key
  , state       as location_state_name
  , city        as location_city_name
FROM
    {{ source('data_source', 'tmp_orders') }}