with reviews as (
    select * from {{ ref('stg_generated_reviews') }}
)

select
    review_id,
    listing_id,
    review_date,
    review_score
from reviews