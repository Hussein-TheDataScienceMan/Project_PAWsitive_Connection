-- pets adopted on the events
SELECT
    s.species_name,
    a.adoption_date,
    ae.event_name,
    ae.event_date,
    ae.city
FROM
    adoptions a
    LEFT JOIN pets p ON a.pet_id = p.pet_id
    LEFT JOIN species s ON p.species_id = s.species_id
    LEFT JOIN adoption_events ae ON a.adoption_event_id = ae.adoption_event_id
WHERE
    event_name IS NOT NULL