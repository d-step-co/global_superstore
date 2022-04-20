{{ config(
  materialized = 'view',
  schema = 'data_mart'
) }}

SELECT
    r.region_manager_name               as manager  
  , COUNT(DISTINCT o.order_id)          as quantity
  , ROUND(SUM(o.order_sales_usd), 2)    as sales_usd
FROM
    {{ source('data_storage', 'order') }} o
LEFT JOIN
    {{ source('data_storage', 'region') }} r
    ON o.order_region_key = r.region_key
WHERE
    EXTRACT(YEAR FROM o.order_date) = 2015
    AND r.region_manager_name IS NOT NULL    
GROUP BY
    r.region_manager_name