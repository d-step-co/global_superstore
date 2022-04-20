{{ config(
  materialized = 'view',
  schema = 'data_mart'
) }}

SELECT
    month
  , sales_amount
  , sales_usd
  , profit_usd
  , margin_percent
FROM
    (
    SELECT
        DATE_TRUNC(date(o.order_date), month)                       as month_num
      , FORMAT_DATE("%b %Y", DATE_TRUNC(date(o.order_date), month)) as month
      , COUNT(DISTINCT o.order_id)                                  as sales_amount
      , ROUND(SUM(o.order_sales_usd), 2)                            as sales_usd
      , ROUND(SUM(o.order_profit_usd), 2)                           as profit_usd
      , ROUND(SAFE_DIVIDE(SUM(o.order_profit_usd), SUM(o.order_sales_usd))* 100, 2) as margin_percent
    FROM 
        {{ ref('order') }} o
    WHERE
        EXTRACT(YEAR FROM o.order_date) = 2015
    GROUP BY
        DATE_TRUNC(date(o.order_date), month)
      , FORMAT_DATE("%b %Y", DATE_TRUNC(date(o.order_date), month))
    )
ORDER BY
    month_num