
  create or replace   view VUBA_VUBA_DB.vuba_schema.stg_vuba__shops
  
  
  
  
  as (
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
  );

