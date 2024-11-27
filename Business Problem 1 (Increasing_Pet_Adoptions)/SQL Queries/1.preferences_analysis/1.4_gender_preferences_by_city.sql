/* 
 Query: Determine the most popular pet preference by gender within each city
 Purpose: This query ranks pet preferences for each gender in each city, showing only the top preference by count.
 */
WITH ranked_gender_preferences AS (
    SELECT
        city,
        gender,
        pet_preferences,
        COUNT(pet_preferences) AS preference_count,
        ROW_NUMBER() OVER (
            PARTITION BY city,
            gender
            ORDER BY
                COUNT(pet_preferences) DESC
        ) AS gender_rank
    FROM
        customers
    WHERE
        pet_preferences IS NOT NULL
        AND pet_preferences <> 'No Preference'
    GROUP BY
        city,
        gender,
        pet_preferences
    ORDER BY
        city,
        gender,
        preference_count DESC
)
SELECT
    *
FROM
    ranked_gender_preferences
WHERE
    gender_rank = 1;

-- Retrieve only the top preference for each city-gender group