/* 
 Query: Determine the most popular pet preference by city
 Purpose: This query ranks pet preferences for each city, showing only the top preference per city,
 along with the percentage of customers who prefer this type. 
 */ 
WITH ranked_preferences AS (
    SELECT
        city,
        COUNT(pet_preferences) AS preference_count,
        pet_preferences,
        DENSE_RANK() OVER (
            PARTITION BY city
            ORDER BY
                COUNT(pet_preferences) DESC
        ) AS rank
    FROM
        customers
    WHERE
        pet_preferences IS NOT NULL
    GROUP BY
        city,
        pet_preferences
),
city_totals AS (
    SELECT
        city,
        COUNT(pet_preferences) AS total_count
    FROM
        customers
    GROUP BY
        city
)
SELECT
    ct.city,
    rp.pet_preferences,
    rp.preference_count,
    ROUND(
        (rp.preference_count * 100.0 / ct.total_count),
        2
    ) AS percentage,
    rp.rank
FROM
    ranked_preferences rp
    JOIN city_totals ct ON rp.city = ct.city
WHERE
    rp.rank = 1 -- Show only the top preference per city
ORDER BY
    rp.pet_preferences,
    percentage DESC;