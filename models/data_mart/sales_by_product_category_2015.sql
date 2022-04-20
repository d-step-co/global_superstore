{{ config(
  materialized = 'view',
  schema = 'data_mart'
) }}

SELECT
    p.product_category_name             as category
  , p.product_sub_category_name         as sub_category
  , SUM(o.order_quantity)               as quantity
  , ROUND(SUM(o.order_sales_usd), 2)    as sales_usd
FROM
    {{ ref('order') }} o
LEFT JOIN
    {{ ref('product') }} p
    ON o.order_product_key = p.product_key
WHERE
    EXTRACT(YEAR FROM o.order_date) = 2015
GROUP BY
    p.product_category_name
  , p.product_sub_category_name