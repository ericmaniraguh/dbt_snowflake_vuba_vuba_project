with source as (
    select * from VUBA_VUBA_DB.VUBA_SCHEMA.ORDER_ITEMS
),
renamed as (
    select
        ORDER_ITEM_ID as order_item_id,
        ORDER_ID as order_id,
        PRODUCT_ID as product_id,
        QUANTITY as quantity,
        PRICE as price,
        (QUANTITY * PRICE) as item_total_price
    from source
)
select * from renamed