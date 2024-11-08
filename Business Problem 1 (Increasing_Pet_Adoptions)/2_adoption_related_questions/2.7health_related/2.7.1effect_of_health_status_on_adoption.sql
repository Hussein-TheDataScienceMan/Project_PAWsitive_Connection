WITH latest_healthy_checkups AS (
    SELECT
        hr.pet_id,
        hr.health_status,
        hr.checkup_date,
        ROW_NUMBER() OVER (PARTITION BY hr.pet_id ORDER BY hr.checkup_date DESC) AS rn
    FROM
        health_records hr
)
SELECT
    s.species_name,
    lhc.health_status,
    p.adopted_status,
    COUNT(*) AS count
FROM
    latest_healthy_checkups lhc
    LEFT JOIN pets p ON lhc.pet_id = p.pet_id
    LEFT JOIN species s ON p.species_id = s.species_id
WHERE
    lhc.rn = 1
GROUP BY
    s.species_name,
    lhc.health_status,
    p.adopted_status
ORDER BY
    s.species_name,lhc.health_status, p.adopted_status
