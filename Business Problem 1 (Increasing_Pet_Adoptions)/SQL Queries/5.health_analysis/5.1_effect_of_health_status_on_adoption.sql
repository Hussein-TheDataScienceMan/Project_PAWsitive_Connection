/* 
 Query: Analyze effect of health status on adoption rates by species
 Purpose: This query examines the latest health status of each pet to analyze its correlation with adoption status. 
 It provides counts of adopted and not adopted pets for each health status by species.
 */
WITH latest_health_checkups AS (
    -- Identify the most recent health status for each pet based on the latest checkup date
    SELECT
        hr.pet_id,
        hr.health_status,
        hr.checkup_date,
        ROW_NUMBER() OVER (
            PARTITION BY hr.pet_id
            ORDER BY
                hr.checkup_date DESC
        ) AS rn
    FROM
        health_records hr
)
SELECT
    s.species_name,
    lhc.health_status,
    p.adopted_status,
    COUNT(*) AS pet_count
FROM
    latest_health_checkups lhc
    LEFT JOIN pets p ON lhc.pet_id = p.pet_id
    LEFT JOIN species s ON p.species_id = s.species_id
WHERE
    lhc.rn = 1 -- Select only the latest health check for each pet
GROUP BY
    s.species_name,
    lhc.health_status,
    p.adopted_status
ORDER BY
    s.species_name,
    lhc.health_status,
    p.adopted_status;