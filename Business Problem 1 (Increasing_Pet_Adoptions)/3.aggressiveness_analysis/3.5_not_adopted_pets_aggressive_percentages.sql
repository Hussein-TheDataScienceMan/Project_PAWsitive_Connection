WITH totals AS (
    SELECT
        s.species_name,
        COUNT(*) AS total_of_species
    FROM
        pets p
        LEFT JOIN species s ON p.species_id = s.species_id
    WHERE p.adopted_status = 'Not Adopted'
    GROUP BY
        s.species_name
)
SELECT
    s.species_name,
    -- Counts for each aggressiveness level
    COUNT(
        CASE
            WHEN aggressiveness = 'Low' THEN 1
        END
    ) AS count_of_low,
    COUNT(
        CASE
            WHEN aggressiveness = 'Medium' THEN 1
        END
    ) AS count_of_medium,
    COUNT(
        CASE
            WHEN aggressiveness = 'High' THEN 1
        END
    ) AS count_of_high,
    -- Percentages for each aggressiveness level
    s.species_name,
    ROUND(
        COUNT(
            CASE
                WHEN aggressiveness = 'Low' THEN 1
            END
        ) * 100.0 / t.total_of_species,
        2
    ) AS percent_of_low,
    ROUND(
        COUNT(
            CASE
                WHEN aggressiveness = 'Medium' THEN 1
            END
        ) * 100.0 / t.total_of_species,
        2
    ) AS percent_of_medium,
    ROUND(
        COUNT(
            CASE
                WHEN aggressiveness = 'High' THEN 1
            END
        ) * 100.0 / t.total_of_species,
        2
    ) AS percent_of_high,
    -- Total count for reference
    t.total_of_species
FROM
    pets p
    LEFT JOIN species s ON p.species_id = s.species_id
    LEFT JOIN totals t ON s.species_name = t.species_name
WHERE p.adopted_status = 'Not Adopted'
GROUP BY
    s.species_name,
    t.total_of_species
    
ORDER BY
    count_of_medium DESC;