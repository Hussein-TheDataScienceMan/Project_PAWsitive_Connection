/* 
 Query: Analyze effect of health status on stay period by species
 Purpose: This query retrieves the latest health status for each pet and examines how it correlates with 
 the stay period (above or below average) for each species.
 */
WITH latest_health_checkups AS (
    -- Identify the most recent health status and stay period classification for each pet
    SELECT
        hr.pet_id,
        pspr.species_name,
        pspr.stay_period_from_avg,
        hr.health_status,
        hr.checkup_date,
        ROW_NUMBER() OVER (
            PARTITION BY hr.pet_id
            ORDER BY
                hr.checkup_date DESC
        ) AS rn
    FROM
        health_records hr
        LEFT JOIN pet_stay_period_rate pspr ON hr.pet_id = pspr.pet_id
)
SELECT
    lhc.species_name,
    lhc.health_status,
    lhc.stay_period_from_avg,
    COUNT(*) AS pet_count
FROM
    latest_health_checkups lhc
WHERE
    lhc.rn = 1 -- Select only the latest health check for each pet
GROUP BY
    lhc.species_name,
    lhc.health_status,
    lhc.stay_period_from_avg
ORDER BY
    lhc.species_name,
    lhc.health_status,
    lhc.stay_period_from_avg;