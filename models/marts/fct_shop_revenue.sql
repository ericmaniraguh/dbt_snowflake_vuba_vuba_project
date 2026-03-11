-- 3️⃣ Analytics/Mart Models (fct_ or dim_)
-- Purpose: Generate key metrics or dimensions for reporting.
-- Use case: Calculate total revenue per shop, top-selling products, or customer purchase behavior.
-- Example 1: Revenue per Shop (fct_shop_revenue.sql)

-- models/staging/vuba/fct_shop_revenue.sql
{{ config(materialized='table') }}

with orders_with_shop as (
    select * from {{ ref('int_vuba__orders_with_customer_shop') }}
)

select
    shop_name,
    count(order_id) as total_orders,
    sum(calculated_total_amount) as total_revenue
from orders_with_shop
group by 1

-- Example 2: Top Customers (fct_customer_purchases.sql)