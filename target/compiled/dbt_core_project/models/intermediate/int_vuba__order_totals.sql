with items as (
    select * from VUBA_VUBA_DB.VUBA_SCHEMA.ORDER_ITEMS
),
calculated_totals as (
    select
        order_id,
        sum(quantity * price) as calculated_total_amount,
        count(order_item_id) as total_items_count
    from items
    group by 1
)
select * from calculated_totals