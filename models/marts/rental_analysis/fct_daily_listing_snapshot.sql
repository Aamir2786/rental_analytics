with calendar as (
    select * from {{ ref('stg_calendar') }}
),

daily_amenities as (
    select * from {{ ref('int_daily_amenities_extracted') }}
)

select
    cal.listing_id,
    cal.calendar_date,
    cal.price,
    cal.is_available,
    cal.minimum_nights,
    cal.maximum_nights,
    
    coalesce(am.has_air_conditioning, false) as has_air_conditioning,
    coalesce(am.has_lockbox, false) as has_lockbox,
    coalesce(am.has_first_aid_kit, false) as has_first_aid_kit,

    -- revenue is generated on days the listing is not available
    case
        when not cal.is_available then cal.price
        else 0
    end as revenue

from calendar cal
left join daily_amenities am on cal.listing_id = am.listing_id and cal.calendar_date = am.calendar_date