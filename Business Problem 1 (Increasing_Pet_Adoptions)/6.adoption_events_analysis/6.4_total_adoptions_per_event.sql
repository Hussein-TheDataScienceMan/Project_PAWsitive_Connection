--------------- total adoptions per event 
SELECT
    ae.event_name,
    COUNT(species_name) as count_of_adoptions,
    event_date,
    ROW_NUMBER() OVER (
        ORDER BY
            COUNT(species_name) DESC
    ) AS rank
FROM
    adoptions a
    LEFT JOIN pets p ON a.pet_id = p.pet_id
    LEFT JOIN species s ON p.species_id = s.species_id
    LEFT JOIN adoption_events ae ON a.adoption_event_id = ae.adoption_event_id
WHERE
    event_name IS NOT NULL
GROUP BY
    ae.event_name,
    event_date
ORDER BY
    count_of_adoptions DESC,
    event_name