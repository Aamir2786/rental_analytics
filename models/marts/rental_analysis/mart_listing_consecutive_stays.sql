with consecutive_stays as (
    select * from {{ ref('int_listing_consecutive_stay_duration') }}
)

select
    listing_id,
    group_start_date as start_of_consecutive_stay,
    dateadd(day, 
        least(consecutive_nights_based_on_availability, maximum_nights_allowed) - 1, 
        group_start_date
    ) as end_of_consecutive_stay,
    least(consecutive_nights_based_on_availability, maximum_nights_allowed) as max_night_stay_possible
from
    consecutive_stays