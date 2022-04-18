SELECT
  CAST(o.row_id as int) as id
, o.order_id
, o.order_date
, o.city
, o.state
, o.country
, o.region
, ROUND(CAST(REPLACE(SUBSTR(REPLACE(o.sales, ',', '.'), 2), ' ', '') as float64), 2) as sales
, p.person as manager
FROM 
  {{ source('data_source', 'orders') }} o
LEFT JOIN
  {{ source('data_source', 'returns') }} r
  ON o.order_id = r.order_id
LEFT JOIN
  {{ source('data_source', 'peoples') }} p 
  ON o.region = p.region
WHERE
  o.region IN ('Eastern Europe', 'Western Europe')
  AND r.returned = 'Yes'