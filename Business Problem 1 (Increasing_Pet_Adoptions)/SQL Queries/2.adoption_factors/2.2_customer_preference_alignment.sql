/* 
 Query: Analyze alignment between customer preferences and adopted pet species
 Purpose: This query shows how often customer pet preferences align with the species of the pets they adopt.
 */
 
SELECT
    c.pet_preferences,
    s.species_name,
    COUNT(*) AS preference_match_count
FROM
    adoptions a
    LEFT JOIN customers c ON a.customer_id = c.customer_id
    LEFT JOIN pets p ON a.pet_id = p.pet_id
    LEFT JOIN species s ON p.species_id = s.species_id
WHERE
    c.pet_preferences IS NOT NULL
    AND c.pet_preferences <> 'No Preference'
GROUP BY
    c.pet_preferences,
    s.species_name
ORDER BY
    c.pet_preferences;