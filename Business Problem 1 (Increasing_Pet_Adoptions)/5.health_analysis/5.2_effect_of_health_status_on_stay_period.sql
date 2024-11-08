WITH latest_healthy_checkups AS (
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
    species_name,
    lhc.health_status,
    stay_period_from_avg,
    COUNT(*) AS count
FROM
    latest_healthy_checkups lhc
WHERE
    lhc.rn = 1
GROUP BY
    species_name,
    lhc.health_status,
    stay_period_from_avg
ORDER BY
    species_name,
    lhc.health_status,
    stay_period_from_avg