with source as (
    select * from {{ source('vuba_system', 'shops') }}
),

renamed as (
    select
        SHOP_ID as shop_id,
        NAME as shop_name,
        LOCATION as shop_city
    from source
)

select * from renamed