
  
    

create or replace transient table VUBA_VUBA_DB.vuba_schema.int_vuba__orders_with_customer_shop
    
    
    
    as (

with orders as (
    select * from VUBA_VUBA_DB.vuba_schema.stg_vuba__orders
),

order_totals as (
    select * from VUBA_VUBA_DB.vuba_schema.int_vuba__order_totals
),

shops as (
    select * from VUBA_VUBA_DB.vuba_schema.stg_vuba__shops
),

orders_with_shop as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.shop_id,
        s.shop_name,
        s.shop_city,
        coalesce(ot.calculated_total_amount, 0) as calculated_total_amount,
        coalesce(ot.total_items_count, 0) as total_items_count
    from orders o
    left join order_totals ot on o.order_id = ot.order_id
    left join shops s on o.shop_id = s.shop_id
)

select * from orders_with_shop
    )
;


  