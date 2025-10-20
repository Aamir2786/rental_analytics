with source as (
    select * from {{ source('rental_raw_data', 'calendar') }}
),

renamed as (
    select
        listing_id,
        date,
        -- Convert t / f to a boolean
        try_to_boolean(available) as is_available,
        reservation_id,
        price::integer as price,
        minimum_nights,
        maximum_nights
    from source
)

select * from   renamed