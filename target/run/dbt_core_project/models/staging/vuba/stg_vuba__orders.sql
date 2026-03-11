
  create or replace   view VUBA_VUBA_DB.vuba_schema.stg_vuba__orders
  
  
  
  
  as (
    with source as (
    select * from VUBA_VUBA_DB.VUBA_SCHEMA.ORDERS
)

select * from source
  );

