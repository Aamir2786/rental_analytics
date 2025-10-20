with listing_available_days as (
    select
        listing_id,
        calendar_date,
        maximum_nights
    from {{ ref('stg_calendar') }}
    where
        is_available = true
),

consecutive_nights_group as (
    select
        listing_id,
        calendar_date,
        maximum_nights,
        -- successive dates for a listing will result in the same group id
        dateadd(day, -row_number() over (partition by listing_id order by calendar_date), calendar_date) as group_id
    from listing_available_days
)

select
    listing_id,
    group_id,
    min(calendar_date) as group_start_date,
    max(calendar_date) as group_end_date,
    -- calculate the duration of days in the group
    datediff(day, min(calendar_date), max(calendar_date)) + 1 as consecutive_nights_based_on_availability,

    -- upper limit allowed by the owner
    max(maximum_nights) as maximum_nights_allowed
from consecutive_nights_group
group by
    1, 2