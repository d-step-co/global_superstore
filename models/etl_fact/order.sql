{{ config(
  materialized = 'incremental',
  unique_key = 'order_key'
) }}

SELECT
    CAST(row_id as integer)                         as order_key
  , order_id                                        as order_id
  , PARSE_DATE('%d.%m.%Y', order_date)              as order_date
  , returned                                        as order_is_return
  , customer_id                                     as order_customer_key
  , CONCAT(LEFT(state, 1), LEFT(city, 1) ,'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(CONCAT(city, state))), r"[^0-9]+", ""), 8))   as order_location_key
  , CONCAT(LEFT(region, 1), UPPER(SUBSTR(region, 4, 1)) ,'-', LEFT(REGEXP_REPLACE(TO_HEX(MD5(region)), r"[^0-9]+", ""), 4)) as order_region_key
  , product_id                                      as order_product_key
  , order_priority                                  as order_priority  
  , ship_mode                                       as order_ship_mode
  , PARSE_DATE('%d.%m.%Y', ship_date)               as order_ship_date
  , CAST(postal_code as integer)                    as order_ship_postal_code
  , CAST(quantity as integer)                       as order_quantity
  , CAST(REPLACE(discount, ',', '.') as float64)    as order_discount
  , ROUND(CAST(REPLACE(REPLACE(REPLACE(sales, ',', '.'), '$', ''), ' ', '') as float64), 2)         as order_sales_usd
  , ROUND(CAST(REPLACE(REPLACE(REPLACE(shipping_cost, ',', '.'), '$', ''), ' ', '') as float64), 2) as order_shipping_cost_usd
  , ROUND(CAST(REPLACE(REPLACE(REPLACE(profit, ',', '.'), '$', ''), ' ', '') as float64), 2)        as order_profit_usd
FROM
    {{ source('data_source', 'tmp_orders') }}
{% if is_incremental() %}
WHERE
    CAST(row_id as integer) > (SELECT MAX(order_key) FROM {{ this }})
{% endif %}