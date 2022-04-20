{{ config(
  materialized = 'view',
  schema = 'data_mart'
) }}

SELECT
    state
  , SUM(total) as sales_amount
  , ROUND(SAFE_DIVIDE(SUM(returned), SUM(total)), 2) as return_rate
FROM
    (SELECT 
        l.location_state_name                   as state
      , COUNT(DISTINCT o.order_id)              as total
      , COUNT(DISTINCT
                CASE o.order_is_return
                WHEN true THEN o.order_id
                ELSE null END)              as returned
    FROM 
        {{ ref('order') }} o
    LEFT JOIN
        {{ ref('location') }} l
        ON o.order_location_key = l.location_key
    WHERE
        EXTRACT(YEAR FROM o.order_date) = 2015
    GROUP BY
        l.location_state_name
    )
GROUP BY
    state