{{ config(
  materialized = 'view',
  schema = 'data_mart'
) }}

WITH tab as (
SELECT
    DATE_TRUNC(date(o.order_date), month) as month
  , COUNT(DISTINCT order_id)              as sales_amount
  , ROUND(SUM(o.order_sales_usd), 2)      as sales_usd
FROM 
    {{ ref('order') }} o
WHERE
    o.order_date BETWEEN '2014-12-01' AND '2015-12-31'
GROUP BY
    DATE_TRUNC(date(o.order_date), month)
),

final as (
SELECT 
    t.month
  , t.sales_amount
  , t.sales_usd
  , ROUND(t.sales_amount - LAG(t.sales_amount) OVER(ORDER BY t.month), 2) as change_sales_amount
  , ROUND(t.sales_usd - LAG(t.sales_usd) OVER(ORDER BY t.month), 2)       as change_sales_usd
FROM tab t
)

SELECT
    FORMAT_DATE("%b %Y", f.month)  as month
  , f.sales_amount
  , f.sales_usd
  , f.change_sales_amount
  , f.change_sales_usd
FROM
    final f
WHERE
    EXTRACT(YEAR FROM f.month) = 2015
ORDER BY
    f.month