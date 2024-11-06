WITH latest_healthy_checkups AS (
    SELECT
        hr.pet_id,
        hr.health_status,
        hr.checkup_date,
        ROW_NUMBER() OVER (PARTITION BY hr.pet_id ORDER BY hr.checkup_date DESC) AS rn
    FROM
        health_records hr
    WHERE
        hr.health_status = 'Healthy'
)

SELECT
    s.species_name,
    p.adopted_status,
    COUNT(lhc.pet_id) AS count_of_healthy
FROM
    pets p
    LEFT JOIN species s ON p.species_id = s.species_id
    RIGHT JOIN latest_healthy_checkups lhc ON p.pet_id = lhc.pet_id AND lhc.rn = 1
GROUP BY
    s.species_name,
    p.adopted_status
ORDER BY
    species_name,
    adopted_status;
