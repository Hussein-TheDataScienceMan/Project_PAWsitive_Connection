WITH totals AS (
    SELECT
        basp.species_name,
        COUNT(*) AS total_of_species
    FROM
        blw_avg_stayed_pets basp
        
    GROUP BY
        basp.species_name
)
SELECT
    basp.species_name,
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
    basp.species_name,
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


FROM blw_avg_stayed_pets basp
LEFT JOIN pets p ON basp.pet_id = p.pet_id
LEFT JOIN totals t ON basp.species_name = t.species_name
GROUP BY
    basp.species_name,
    t.total_of_species


