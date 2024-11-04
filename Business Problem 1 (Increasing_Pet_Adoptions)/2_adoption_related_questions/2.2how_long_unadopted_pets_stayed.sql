-- average stay time for all unadopted pets

WITH stay_period as (
    SELECT 
        species_name,
        arrival_date,
        CASE
            WHEN adopted_status = 'Not Adopted' THEN '2023-12-31'
            ELSE NULL
        END AS data_end_date,
        adopted_status,
        ROUND(
            EXTRACT(
                YEAR
                FROM AGE('2023-12-31', arrival_date)
            ) * 12 + EXTRACT(
                MONTH
                FROM AGE('2023-12-31', arrival_date)
            ) + EXTRACT(
                DAY
                FROM AGE('2023-12-31', arrival_date)
            ) / 30.44,
            2
        ) AS stay_period_months
    FROM pets p
         
        LEFT JOIN species s ON p.species_id = s.species_id
)

SELECT ROUND(AVG(stay_period_months), 2)
FROM stay_period
WHERE adopted_status = 'Not Adopted'



-----------------------
--min, average, max  stay time for unadopted pets till the end of 2023

WITH stay_period as (
    SELECT 
        species_name,
        arrival_date,
        CASE
            WHEN adopted_status = 'Not Adopted' THEN '2023-12-31'
            ELSE NULL
        END AS data_end_date,
        adopted_status,
        ROUND(
            EXTRACT(
                YEAR
                FROM AGE('2023-12-31', arrival_date)
            ) * 12 + EXTRACT(
                MONTH
                FROM AGE('2023-12-31', arrival_date)
            ) + EXTRACT(
                DAY
                FROM AGE('2023-12-31', arrival_date)
            ) / 30.44,
            2
        ) AS stay_period_months
    FROM pets p
         
        LEFT JOIN species s ON p.species_id = s.species_id
)
SELECT 
    species_name,
    ROUND(MIN(stay_period_months), 2) AS min_stay_period_months,
    ROUND(AVG(stay_period_months), 2) AS avg_stay_period_months,
    ROUND(MAX(stay_period_months), 2) AS max_stay_period_months
    
FROM stay_period
WHERE adopted_status = 'Not Adopted'
GROUP BY species_name
ORDER BY avg_stay_period_months DESC


/*
we can see that we only have 7 species out of 11

all (snakes, lizards, hamsters, rabbits) are adopted, 
given that they are not arriving to the center very often

*/