/* 
 Query: Count number of pets adopted per species for each event
 Purpose: This query retrieves the number of adoptions for each species during specific adoption events, 
 showing the event name, species, and count.
 */
SELECT
    ae.event_name,
    s.species_name,
    COUNT(s.species_name) AS species_adoption_count
FROM
    adoptions a
    LEFT JOIN pets p ON a.pet_id = p.pet_id
    LEFT JOIN species s ON p.species_id = s.species_id
    LEFT JOIN adoption_events ae ON a.adoption_event_id = ae.adoption_event_id
WHERE
    ae.event_name IS NOT NULL -- Filter to include only adoptions associated with events
GROUP BY
    ae.event_name,
    s.species_name
ORDER BY
    ae.event_name;