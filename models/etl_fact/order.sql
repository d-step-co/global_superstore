{{ config(
  materialized='incremental',
  unique_key='order_key'
) }}

SELECT
    CAST(row_id as integer)                         as order_key
  , LOWER(order_id)                                 as order_id
  , PARSE_DATE('%d.%m.%Y', order_date)              as order_date
  , returned                                        as order_is_return
  , LOWER(customer_id)                              as order_customer_key
  , LOWER(TO_HEX(MD5(CONCAT(city,state))))          as order_location_key
  , LOWER(product_id)                               as order_product_key
  , ship_mode                                       as order_ship_mode
  , PARSE_DATE('%d.%m.%Y', ship_date)               as order_ship_date
  , CAST(quantity as integer)                       as order_quantity
  , CAST(REPLACE(discount, ',', '.') as float64)    as order_discount
  , ROUND(CAST(REPLACE(REPLACE(REPLACE(sales, ',', '.'), '$', ''), ' ', '') as float64), 2)         as order_sales_usd
  , ROUND(CAST(REPLACE(REPLACE(REPLACE(shipping_cost, ',', '.'), '$', ''), ' ', '') as float64), 2) as order_shipping_cost_usd
  , ROUND(CAST(REPLACE(REPLACE(REPLACE(profit, ',', '.'), '$', ''), ' ', '') as float64), 2)        as order_profit_usd
  , order_priority                  as order_detail_priority
FROM
    {{ source('data_source', 'tmp_orders') }}
{% if is_incremental() %}
WHERE
    CAST(row_id as integer) > (SELECT MAX(order_key) FROM {{ this }})
{% endif %}