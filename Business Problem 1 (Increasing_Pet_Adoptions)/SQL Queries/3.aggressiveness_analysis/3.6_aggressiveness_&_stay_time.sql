SELECT
    pspr.pet_id,
    species_name,
    stay_period_months,
    avg_stay_period_months,
    stay_period_from_avg,
    p.adopted_status,
    aggressiveness
FROM
    pet_stay_period_rate pspr
    LEFT JOIN pets p ON pspr.pet_id = p.pet_id