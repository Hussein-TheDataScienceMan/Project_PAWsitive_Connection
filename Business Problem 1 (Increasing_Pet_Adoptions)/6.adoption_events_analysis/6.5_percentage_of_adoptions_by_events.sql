SELECT
    adoption_id,
    adoption_date,
    adoption_event_id,
    CASE
        WHEN adoption_event_id IS NULL THEN 'Without Adoption Event'
        ELSE 'With Adoption Event'
    END as adoption_event_status
from
    adoptions