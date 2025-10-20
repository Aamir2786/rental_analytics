-- Since amenities information can be updated by the host,
-- we need to ensure that we use the correct amenities data for our analysis for that particular point-in-time.
-- This model links the correct amenities details for a listing to a particular calendar date.

{%- set amenities_to_check = ['Air conditioning', 'Lockbox', 'First aid kit'] %}

with unique_date_list as (
    select
        listing_id, calendar_date -- both are candidate of primary key, so no need to take distinct
    from
        {{ ref('stg_calendar') }}
),

amenities_log as (
    select
        listing_id,
        change_at,
        amenities
    from
        {{ ref('stg_amenities_changelog') }}
),

amenities_rn as (
    select
        dt.listing_id,
        dt.calendar_date,
        lg.amenities,
        -- Rank the changes for each listing and day based on the latest log change that occurred for the listing on that day or just before.
        row_number() over (partition by dt.listing_id, dt.calendar_date order by lg.change_at desc) as rn
    from unique_date_list dt
    left join amenities_log lg on dt.listing_id = lg.listing_id and dt.calendar_date >= lg.change_at
),

amenities_extracted as (
    select
        listing_id,
        calendar_date,

        {% for amenity in amenities_to_check %}
        array_contains('{{ amenity }}'::VARIANT, amenities) AS has_{{ amenity | lower | replace(' ', '_') }}{% if not loop.last %},{% endif %}
        {% endfor %}
    from
        amenities_rn
    where
        rn = 1 -- we want the most recent amenties record for each day
)

select * from amenities_extracted