with source as (
    select * from {{ source('vuba_system', 'orders') }}
)

select * from source