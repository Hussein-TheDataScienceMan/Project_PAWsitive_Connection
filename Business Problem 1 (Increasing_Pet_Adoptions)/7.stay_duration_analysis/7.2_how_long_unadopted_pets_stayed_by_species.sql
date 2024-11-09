/* 
 Query: Calculate min, average, and max stay period per species for unadopted pets
 Purpose: This query calculates the minimum, average, and maximum stay periods for unadopted pets,
 segmented by species and using December 31, 2023, as the reference date.
 */
WITH stay_period AS (
    -- Calculate stay period in months for each unadopted pet, using December 31, 2023 as the reference date
    SELECT
        s.species_name,
        p.arrival_date,
        ROUND(
            EXTRACT(
                YEAR
                FROM
                    AGE('2023-12-31', p.arrival_date)
            ) * 12 + EXTRACT(
                MONTH
                FROM
                    AGE('2023-12-31', p.arrival_date)
            ) + EXTRACT(
                DAY
                FROM
                    AGE('2023-12-31', p.arrival_date)
            ) / 30.44,
            2
        ) AS stay_period_months
    FROM
        pets p
        LEFT JOIN species s ON p.species_id = s.species_id
    WHERE
        p.adopted_status = 'Not Adopted'
)
SELECT
    species_name,
    ROUND(MIN(stay_period_months), 2) AS min_stay_period_months,
    ROUND(AVG(stay_period_months), 2) AS avg_stay_period_months,
    ROUND(MAX(stay_period_months), 2) AS max_stay_period_months
FROM
    stay_period
GROUP BY
    species_name
ORDER BY
    avg_stay_period_months DESC;

/*
 Observations:
 - Only 7 out of 11 species have unadopted pets in the data as of the end of 2023.
 - All snakes, lizards, hamsters, and rabbits have been adopted, likely due to their limited arrivals at the center.
 */