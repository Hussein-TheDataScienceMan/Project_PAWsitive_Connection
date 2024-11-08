/* 
 Query: Calculate distribution of aggressiveness levels for adopted pets by species
 Purpose: This query provides counts and percentages for each aggressiveness level (Low, Medium, High) 
 among adopted pets, segmented by species.
 */
WITH species_totals_adopted AS (
    -- Calculate the total count of adopted pets for each species
    SELECT
        s.species_name,
        COUNT(*) AS total_of_species
    FROM
        pets p
        LEFT JOIN species s ON p.species_id = s.species_id
    WHERE
        p.adopted_status = 'Adopted'
    GROUP BY
        s.species_name
)
SELECT
    s.species_name,
    -- Counts for each aggressiveness level
    COUNT(
        CASE
            WHEN p.aggressiveness = 'Low' THEN 1
        END
    ) AS count_of_low,
    COUNT(
        CASE
            WHEN p.aggressiveness = 'Medium' THEN 1
        END
    ) AS count_of_medium,
    COUNT(
        CASE
            WHEN p.aggressiveness = 'High' THEN 1
        END
    ) AS count_of_high,
    -- Percentages for each aggressiveness level
    ROUND(
        COUNT(
            CASE
                WHEN p.aggressiveness = 'Low' THEN 1
            END
        ) * 100.0 / t.total_of_species,
        2
    ) AS percent_of_low,
    ROUND(
        COUNT(
            CASE
                WHEN p.aggressiveness = 'Medium' THEN 1
            END
        ) * 100.0 / t.total_of_species,
        2
    ) AS percent_of_medium,
    ROUND(
        COUNT(
            CASE
                WHEN p.aggressiveness = 'High' THEN 1
            END
        ) * 100.0 / t.total_of_species,
        2
    ) AS percent_of_high,
    -- Total count for reference
    t.total_of_species
FROM
    pets p
    LEFT JOIN species s ON p.species_id = s.species_id
    LEFT JOIN species_totals_adopted t ON s.species_name = t.species_name
WHERE
    p.adopted_status = 'Adopted'
GROUP BY
    s.species_name,
    t.total_of_species
ORDER BY
    count_of_medium DESC;

-- Sort by Medium aggressiveness level for analysis focus