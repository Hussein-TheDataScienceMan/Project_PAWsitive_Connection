-- avg, min, max staying period per species (adopted)

WITH stay_period as (
    SELECT adoption_id,
        species_name,
        arrival_date,
        adoption_date,
        ROUND(
            EXTRACT(
                YEAR
                from AGE(adoption_date, arrival_date)
            ) * 12 + EXTRACT (
                MONTH
                FROM AGE(adoption_date, arrival_date)
            ) + EXTRACT (
                DAY
                FROM AGE(adoption_date, arrival_date)
            ) / 30.44,
            2
        ) AS stay_period_months
    FROM pets p
        RIGHT JOIN adoptions a ON p.pet_id = a.pet_id
        LEFT JOIN species s ON p.species_id = s.species_id
)
SELECT species_name,
    ROUND(MIN(stay_period_months)*30.44, 0) AS min_stay_period_days,
    ROUND(MIN(stay_period_months), 2) AS min_stay_period_months,
    ROUND(AVG(stay_period_months), 2) AS avg_stay_period_months,
    ROUND(MAX(stay_period_months), 2) AS max_stay_period_months,
    ROUND(MAX(stay_period_months)/12, 2) AS mxa_stay_period_years,
    DENSE_RANK() OVER (
        ORDER BY ROUND(AVG(stay_period_months), 2) DESC
    ) AS rank
FROM stay_period
GROUP BY species_name
ORDER BY rank;

