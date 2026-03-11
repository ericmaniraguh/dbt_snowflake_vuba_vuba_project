-- 1️⃣ Staging Models (stg_)

-- Purpose: Clean, normalize, and standardize raw tables from Snowflake.
-- Use case: If your customers, orders, shops tables are messy, rename columns, fix data types, or calculate new flags.
-- Example: stg_vuba__customers.sql

with source as (
    select * from VUBA_VUBA_DB.VUBA_SCHEMA.CUSTOMERS
),

cleaned as (
    select
        customer_id,
        INITCAP(first_name) as first_name,
        INITCAP(last_name) as last_name,
        LOWER(email) as email,
        phone,
        created_at
    from source
)

select * from cleaned

-- Benefit: All transformations in one place; downstream models rely on clean, consistent tables.