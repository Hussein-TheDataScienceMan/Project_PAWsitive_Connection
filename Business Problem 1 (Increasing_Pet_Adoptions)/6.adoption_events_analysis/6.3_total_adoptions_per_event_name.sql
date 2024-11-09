/* 
 Query: Count total number of adoptions per event
 Purpose: This query retrieves the total count of pets adopted during each adoption event, grouped by event name.
 */
SELECT
    ae.event_name,
    COUNT(s.species_name) AS total_adoptions
FROM
    adoptions a
    LEFT JOIN pets p ON a.pet_id = p.pet_id
    LEFT JOIN species s ON p.species_id = s.species_id
    LEFT JOIN adoption_events ae ON a.adoption_event_id = ae.adoption_event_id
WHERE
    ae.event_name IS NOT NULL -- Filter to include only adoptions associated with events
GROUP BY
    ae.event_name
ORDER BY
    ae.event_name;