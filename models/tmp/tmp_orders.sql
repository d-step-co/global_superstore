{{ config(
  materialized = 'table',
  schema = 'data_source'
) }}

SELECT
    o.row_id
  , o.order_id
  , o.order_date
  , o.ship_date
  , o.ship_mode
  , o.customer_id
  , o.customer_name
  , o.segment
  , o.postal_code
  , o.city
  , o.state
  , o.country
  , o.region
  , o.market
  , o.product_id
  , o.category
  , o.sub_category
  , o.product_name
  , o.sales
  , o.quantity
  , o.discount
  , o.profit
  , o.shipping_cost
  , o.order_priority
  , p.person
  , CASE r.returned
      WHEN 'Yes' THEN true
      ELSE false END as returned
FROM
    {{ source('data_source', 'orders') }} o
LEFT JOIN
    {{ source('data_source', 'peoples') }} p
    ON o.region = p.region
LEFT JOIN
    {{ source('data_source', 'returns') }} r
    ON o.order_id = r.order_id
WHERE CAST(o.row_id as integer) > (SELECT MAX(CAST(row_id as integer)) FROM {{ source('data_storage', 'order') }})

