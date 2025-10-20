with source as (
    select * from {{ source('rental_raw_data', 'amenities_changelog') }}
),

renamed as (
    select
        listing_id,
        change_at,
        -- Convert JSON string to Variant array data
        try_parse_json(amenities) as amenities
    from source
)

select * from   renamed