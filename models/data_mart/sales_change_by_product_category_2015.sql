{{ config(
  materialized = 'view',
  schema = 'data_mart'
) }}

SELECT
    category
  , sub_category
  , SUM(quantity_2015) - SUM(quantity_2014)             as year_change_quantity
  , ROUND(SUM(sales_usd_2015) - SUM(sales_usd_2014), 2) as year_change_sales_usd
FROM
    (
    SELECT
        p.product_category_name             as category
      , p.product_sub_category_name         as sub_category
      , SUM(o.order_quantity)               as quantity_2014
      , ROUND(SUM(o.order_sales_usd), 2)    as sales_usd_2014
      , null                                as quantity_2015
      , null                                as sales_usd_2015
    FROM
        {{ ref('order') }} o
    LEFT JOIN
        {{ ref('product') }} p
        ON o.order_product_key = p.product_key
    WHERE
        EXTRACT(YEAR FROM o.order_date) = 2014
    GROUP BY
        p.product_category_name
      , p.product_sub_category_name

    UNION ALL

    SELECT
        p.product_category_name             as category
      , p.product_sub_category_name         as sub_category
      , null                                as quantity_2014
      , null                                as sales_usd_2014
      , SUM(o.order_quantity)               as quantity_2015
      , ROUND(SUM(o.order_sales_usd), 2)    as sales_usd_2015
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
    )
GROUP BY
    category
  , sub_category