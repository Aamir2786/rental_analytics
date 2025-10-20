with listing as (
    select * from {{ ref('stg_listings') }}
)

select
    listing_id,
    listing_name,
    host_id, -- foreign key to dim_hosts
    neighborhood,
    property_type,
    room_type,
    accommodates,
    bathrooms_text,
    bedrooms,
    beds,
    price_at_the_start
    
from listing