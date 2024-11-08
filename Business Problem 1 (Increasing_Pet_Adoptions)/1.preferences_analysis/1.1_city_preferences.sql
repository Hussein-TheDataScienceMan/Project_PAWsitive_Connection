-- what pets cities love?


WITH pet_rank AS (
    SELECT city,
        COUNT(pet_preferences) AS preference_count,
        pet_preferences,
        DENSE_RANK() OVER (
            PARTITION BY CITY
            ORDER BY COUNT(pet_preferences) DESC
        ) as rank
    FROM customers
    WHERE pet_preferences is not NULL
    GROUP BY city,
        pet_preferences
),
city_totals AS (
    SELECT CITY,
        COUNT(pet_preferences) AS total_count
    FROM customers
    GROUP BY city
)
SELECT ct.city,
    pr.pet_preferences,
    preference_count,
    ROUND(
        (pr.preference_count * 100.0 / ct.total_count),
        2
    ) AS percentage,
    rank
FROM pet_rank pr
    JOIN city_totals ct ON pr.city = ct.city
WHERE rank = 1
ORDER BY pet_preferences,
    percentage DESC