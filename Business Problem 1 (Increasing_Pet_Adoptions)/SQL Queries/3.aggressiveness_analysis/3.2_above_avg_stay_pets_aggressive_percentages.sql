/* 
 Query: Calculate distribution of aggressiveness levels for pets with above-average stay periods
 Purpose: This query provides counts and percentages for each aggressiveness level (Low, Medium, High) 
 by species, focusing on pets whose stay period is above average.
 */
WITH species_totals_above_avg AS (
    -- Calculate the total count of pets for each species with above-average stay periods
    SELECT
        pspr.species_name,
        COUNT(*) AS total_of_species
    FROM
        pet_stay_period_rate pspr
    WHERE
        pspr.stay_period_from_avg = 'Above Avg'
    GROUP BY
        pspr.species_name
)
SELECT
    pspr.species_name,
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
    pet_stay_period_rate pspr
    LEFT JOIN pets p ON pspr.pet_id = p.pet_id
    LEFT JOIN species_totals_above_avg t ON pspr.species_name = t.species_name
WHERE
    pspr.stay_period_from_avg = 'Above Avg'
GROUP BY
    pspr.species_name,
    t.total_of_species;