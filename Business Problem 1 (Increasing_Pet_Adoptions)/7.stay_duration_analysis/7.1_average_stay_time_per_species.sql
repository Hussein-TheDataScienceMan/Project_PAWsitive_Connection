/* 
 Query: Calculate average, minimum, and maximum stay period per species for adopted pets
 Purpose: This query computes the minimum, average, and maximum stay periods for adopted pets by species. 
 It includes the stay period in both days and months and ranks species by the longest average stay.
 */
WITH stay_period AS (
    -- Calculate stay period in months for each adopted pet
    SELECT
        a.adoption_id,
        s.species_name,
        p.arrival_date,
        a.adoption_date,
        ROUND(
            EXTRACT(
                YEAR
                FROM
                    AGE(a.adoption_date, p.arrival_date)
            ) * 12 + EXTRACT(
                MONTH
                FROM
                    AGE(a.adoption_date, p.arrival_date)
            ) + EXTRACT(
                DAY
                FROM
                    AGE(a.adoption_date, p.arrival_date)
            ) / 30.44,
            2
        ) AS stay_period_months
    FROM
        pets p
        RIGHT JOIN adoptions a ON p.pet_id = a.pet_id
        LEFT JOIN species s ON p.species_id = s.species_id
)
SELECT
    species_name,
    -- Minimum stay period in both days and months
    ROUND(MIN(stay_period_months) * 30.44, 0) AS min_stay_period_days,
    ROUND(MIN(stay_period_months), 2) AS min_stay_period_months,
    -- Average stay period in months
    ROUND(AVG(stay_period_months), 2) AS avg_stay_period_months,
    -- Maximum stay period in both months and years
    ROUND(MAX(stay_period_months), 2) AS max_stay_period_months,
    ROUND(MAX(stay_period_months) / 12, 2) AS max_stay_period_years,
    -- Rank species based on average stay period from longest to shortest
    DENSE_RANK() OVER (
        ORDER BY
            ROUND(AVG(stay_period_months), 2) DESC
    ) AS rank_longest_to_shortest
FROM
    stay_period
GROUP BY
    species_name
ORDER BY
    rank_longest_to_shortest;