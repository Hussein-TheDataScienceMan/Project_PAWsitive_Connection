/* 
 Query: Calculate and rank total adoptions per event
 Purpose: This query retrieves the total count of pets adopted during each event and ranks events by adoption count.
 */
SELECT
    ae.event_name,
    COUNT(s.species_name) AS count_of_adoptions,
    ae.event_date,
    -- Rank events based on the number of adoptions, in descending order
    ROW_NUMBER() OVER (
        ORDER BY
            COUNT(s.species_name) DESC
    ) AS event_rank
FROM
    adoptions a
    LEFT JOIN pets p ON a.pet_id = p.pet_id
    LEFT JOIN species s ON p.species_id = s.species_id
    LEFT JOIN adoption_events ae ON a.adoption_event_id = ae.adoption_event_id
WHERE
    ae.event_name IS NOT NULL -- Filter to include only adoptions associated with events
GROUP BY
    ae.event_name,
    ae.event_date
ORDER BY
    count_of_adoptions DESC,
    ae.event_name;