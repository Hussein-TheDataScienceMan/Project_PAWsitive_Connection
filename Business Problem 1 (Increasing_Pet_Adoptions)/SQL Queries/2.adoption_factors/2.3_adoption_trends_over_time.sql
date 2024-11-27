/* 
 Query: Analyze adoption trends over time
 Purpose: This query calculates adoption counts by month, allowing us to observe trends or seasonality 
 in adoption rates over time. It includes a breakdown by species.
 */
SELECT
    DATE_TRUNC('month', a.adoption_date) AS adoption_month,
    -- Group by month
    s.species_name,
    COUNT(a.adoption_id) AS monthly_adoption_count
FROM
    adoptions a
    LEFT JOIN pets p ON a.pet_id = p.pet_id
    LEFT JOIN species s ON p.species_id = s.species_id
GROUP BY
    adoption_month,
    s.species_name
ORDER BY
    adoption_month;