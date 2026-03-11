with items as (
    select * from {{ source('vuba_system', 'order_items') }}
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