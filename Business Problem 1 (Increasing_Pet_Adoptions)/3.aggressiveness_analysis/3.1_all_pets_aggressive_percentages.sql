/* 
 Query: Calculate distribution of aggressiveness levels by species
 Purpose: This query provides counts and percentages for each aggressiveness level (Low, Medium, High) by species, 
 helping to understand the behavior profile of pets within each species.
 */
WITH species_totals AS (
    -- Calculate the total count of pets for each species
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
    LEFT JOIN species_totals t ON s.species_name = t.species_name
GROUP BY
    s.species_name,
    t.total_of_species
ORDER BY
    count_of_medium DESC;

-- Sort by Medium aggressiveness level for analysis focus