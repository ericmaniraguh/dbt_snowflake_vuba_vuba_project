with orders as (
    select * from {{ ref('int_vuba__orders_with_customer_shop') }}
)
select
    order_id,
    customer_id,
    order_date,
    shop_name,
    shop_city,
    calculated_total_amount as revenue,
    total_items_count
from orders