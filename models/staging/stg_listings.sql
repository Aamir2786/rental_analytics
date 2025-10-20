with source as (
    select * from {{ source('rental_raw_data', 'listings') }}
),

renamed as (
    select
        id as listing_id,
        trim(name) as listing_name,

        host_id,
        host_name,
        host_since,
        host_location,

        -- Convert JSON string to Variant array data
        try_parse_json(host_verifications) as host_verifications,
        neighborhood,
        property_type,
        room_type,
        accommodates,
        bathrooms_text,
        bedrooms::integer as bedrooms,
        beds,
        -- Convert JSON string to Variant array data
        try_parse_json(amenities) as amenities,
        -- Clean the price column, removing '$' symbol and casting to an integer type
        replace(price, '$', '')::integer as price_at_the_start,
        
        number_of_reviews,
        first_review::date as first_review_date,
        last_review::date as last_review_date,
        review_scores_rating::integer as review_scores_rating
    from source
)

select * from renamed