WITH totals AS (
    SELECT
        aasp.species_name,
        COUNT(*) AS total_of_species
    FROM
        abv_avg_stayed_pets aasp
        
    GROUP BY
        aasp.species_name
)
SELECT
    aasp.species_name,
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
    aasp.species_name,
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


FROM abv_avg_stayed_pets aasp
LEFT JOIN pets p ON aasp.pet_id = p.pet_id
LEFT JOIN totals t ON aasp.species_name = t.species_name
GROUP BY
    aasp.species_name,
    t.total_of_species



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
    LEFT JOIN species s ON p.species_id = s.species_ida
    LEFT JOIN totals t ON s.species_name = t.species_nme
GROUP BY
    s.species_name,
    t.total_of_species
ORDER BY
    count_of_medium DESC;