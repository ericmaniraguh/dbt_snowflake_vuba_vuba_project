
  create or replace   view VUBA_VUBA_DB.vuba_schema.dim_customers
  
  
  
  
  as (
    with customers as (
    select * from VUBA_VUBA_DB.vuba_schema.stg_vuba__customers
),
orders as (
    select * from VUBA_VUBA_DB.vuba_schema.stg_vuba__orders
),
customer_metrics as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        count(order_id) as lifetime_orders
    from orders
    group by 1
)
select
    c.*,
    m.first_order_date,
    m.last_order_date,
    coalesce(m.lifetime_orders, 0) as lifetime_orders
from customers c
left join customer_metrics m on c.customer_id = m.customer_id
  );

