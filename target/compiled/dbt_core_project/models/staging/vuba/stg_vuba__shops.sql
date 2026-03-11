with source as (
    select * from VUBA_VUBA_DB.VUBA_SCHEMA.SHOPS
),

renamed as (
    select
        SHOP_ID as shop_id,
        NAME as shop_name,
        LOCATION as shop_city
    from source
)

select * from renamed