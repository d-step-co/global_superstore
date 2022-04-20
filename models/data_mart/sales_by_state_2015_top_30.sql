{{ config(
  materialized = 'view',
  schema = 'data_mart'
) }}

SELECT
    l.location_state_name               as state
  , r.region_name                       as region  
  , SUM(o.order_quantity)               as quantity
  , ROUND(SUM(o.order_sales_usd), 2)    as sales_usd
FROM
    {{ source('data_storage', 'order') }} o
LEFT JOIN
    {{ source('data_storage', 'location') }} l
    ON o.order_location_key = l.location_key
LEFT JOIN
    {{ source('data_storage', 'country') }} c
    ON l.location_country_key = c.country_key
LEFT JOIN
    {{ source('data_storage', 'region') }} r
    ON o.order_region_key = r.region_key
WHERE
    EXTRACT(YEAR FROM o.order_date) = 2015
GROUP BY
    l.location_state_name
  , r.region_name
ORDER BY 
    ROUND(SUM(o.order_sales_usd), 2) DESC
LIMIT 30