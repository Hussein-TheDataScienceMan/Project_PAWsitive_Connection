/* 
 Query: Analyze arrival trends over time
 Purpose: This query calculates arrival counts by month, allowing us to observe any trends or seasonality 
 in pet arrivals over time. It also includes a breakdown by species for additional insights.
 */
SELECT
    DATE_TRUNC('month', p.arrival_date) AS arrival_month,
    -- Group by month
    s.species_name,
    COUNT(p.pet_id) AS monthly_arrival_count
FROM
    pets p
    LEFT JOIN species s ON p.species_id = s.species_id
GROUP BY
    arrival_month,
    s.species_name
ORDER BY
    arrival_month;