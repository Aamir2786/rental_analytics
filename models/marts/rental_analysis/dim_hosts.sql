with listing as (
    select * from {{ ref('stg_listings') }}
)

select
    host_id,
    max(host_name) as host_name,
    min(host_since) as host_since,
    max(host_location) as host_location,
    max(host_verifications) as host_verifications
    
from listing
where host_id is not null
group by 1
