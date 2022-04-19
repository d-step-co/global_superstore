CREATE SCHEMA data_source;
CREATE SCHEMA data_storage;
CREATE SCHEMA data_mart;

--------------------------------------------------------

CREATE TABLE globalsuperstore.data_source.orders (
  row_id          STRING
, order_id        STRING
, order_date      STRING
, ship_date       STRING
, ship_mode       STRING
, customer_id     STRING
, customer_name   STRING
, segment         STRING
, postal_code     STRING
, city            STRING
, state           STRING
, country         STRING
, region          STRING
, market          STRING
, product_id      STRING
, category        STRING
, sub_category    STRING
, product_name    STRING
, sales           STRING
, quantity        STRING
, discount        STRING
, profit          STRING
, shipping_cost   STRING
, order_priority  STRING
);

CREATE TABLE globalsuperstore.data_source.peoples
(
  person          STRING
, region          STRING
);

CREATE TABLE globalsuperstore.data_source.returns
(
  returned        STRING
, order_id        STRING
, region          STRING
);

--------------------------------------------------------

CREATE TABLE globalsuperstore.data_storage.order (
  order_key                 INTEGER    NOT NULL
, order_id                  STRING  
, order_date                DATE  
, order_is_return           BOOLEAN 
, order_customer_key        STRING    NOT NULL
, order_location_key        STRING    NOT NULL
, order_region_key          STRING    NOT NULL
, order_product_key         STRING    NOT NULL
, order_priority            STRING
, order_ship_mode           STRING
, order_ship_date           DATE
, order_ship_postal_code    INTEGER
, order_quantity            INTEGER 
, order_discount            FLOAT 
, order_sales_usd           FLOAT 
, order_shipping_cost_usd   FLOAT 
, order_profit_usd          FLOAT 
);

CREATE TABLE globalsuperstore.data_storage.customer (
  customer_key              STRING    NOT NULL
, customer_name             STRING
, customer_segment          STRING
);

CREATE TABLE globalsuperstore.data_storage.product (
  product_key               STRING    NOT NULL
, product_name              STRING
, product_category_name     STRING
, product_sub_category_name STRING
);

CREATE TABLE globalsuperstore.data_storage.country (
  country_key               STRING    NOT NULL
, country_market_key        STRING    NOT NULL
, country_name              STRING
);

CREATE TABLE globalsuperstore.data_storage.location (
  location_key              STRING    NOT NULL
, location_country_key      STRING    NOT NULL
, location_state_name       STRING
, location_city_name        STRING
);

CREATE TABLE globalsuperstore.data_storage.region (
  region_key                STRING    NOT NULL
, region_market_key         STRING    NOT NULL
, region_name               STRING
, region_manager_name       STRING
);

CREATE TABLE globalsuperstore.data_storage.market (
  market_key                STRING    NOT NULL
, market_name               STRING
);