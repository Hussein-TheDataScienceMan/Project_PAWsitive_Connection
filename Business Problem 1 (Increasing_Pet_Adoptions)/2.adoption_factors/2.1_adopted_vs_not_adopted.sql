WITH totals AS (
    SELECT
        s.species_name,
        COUNT(*) AS total_of_species
    FROM
        pets p
        LEFT JOIN species s ON p.species_id = s.species_id
    GROUP BY
        s.species_name
)
SELECT
    s.species_name,
    COUNT(*) AS count_per_species,
    COUNT(CASE WHEN p.adopted_status = 'Adopted' THEN 1 END) AS adopted_count,
    COUNT(CASE WHEN p.adopted_status = 'Not Adopted' THEN 1 END) AS not_adopted_count,
    ROUND(COUNT(CASE WHEN p.adopted_status = 'Adopted' THEN 1 END)*100.00/t.total_of_species,2) AS adopted_percentage,
    ROUND(COUNT(CASE WHEN p.adopted_status = 'Not Adopted' THEN 1 END)*100.00/t.total_of_species,2) AS not_adopted_percentage
FROM pets p
LEFT JOIN species s ON p.species_id = s.species_id
JOIN totals t ON s.species_name = t.species_name
GROUP BY s.species_name, t.total_of_species
ORDER BY adopted_percentage ASC


--- now we know most unadopted species 