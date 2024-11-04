/* gender preference by city */
WITH gender_city AS (
    SELECT city,
        gender,
        pet_preferences,
        COUNT(pet_preferences) AS count,
        ROW_NUMBER() OVER (
            PARTITION BY city,
            gender
            ORDER BY COUNT(pet_preferences) DESC
        ) AS gender_rank
    FROM customers
    WHERE pet_preferences IS NOT NULL
        AND pet_preferences <> 'No Preference'
    GROUP BY city,
        gender,
        pet_preferences
    ORDER BY city,
        gender,
        count DESC
)
SELECT *
FROM gender_city
WHERE gender_rank = 1