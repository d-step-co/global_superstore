{{ config(
  materialized = 'view',
  schema = 'data_mart'
) }}

SELECT
    EXTRACT(YEAR FROM o.order_date)     as year
  , EXTRACT(QUARTER FROM o.order_date)  as quater
  , EXTRACT(MONTH FROM o.order_date)    as month
  , EXTRACT(WEEK FROM o.order_date)     as week
  , o.order_date                        as date
  , o.order_id
  , p.product_name                      as product
  , p.product_category_name             as category
  , p.product_sub_category_name         as sub_category
  , o.order_quantity                    as quantity
  , o.order_sales_usd                   as sales_usd
FROM
    {{ source('data_storage', 'order') }} o
LEFT JOIN
    {{ source('data_storage', 'product') }} p
    ON o.order_product_key = p.product_key