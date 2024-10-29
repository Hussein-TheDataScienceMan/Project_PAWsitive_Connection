-- cwhat different ages love?
WITH age_group AS (
    SELECT customer_id,
        date_of_birth,
        DATE_PART('year', AGE('2023-12-31', date_of_birth)),
        CASE
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) BETWEEN 17 and 30 THEN 'Young Adult'
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) BETWEEN 31 and 55 THEN 'Middle-Age Adult'
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) >= 56 THEN 'Senior'
            else 'Other'
        end AS age_category,
        pet_preferences
    FROM customers
),
total_customers AS (
    SELECT COUNT(*) AS total
    FROM customers
),
pet_rank AS (
    SELECT age_category,
        count(pet_preferences) AS count_pet,
        DENSE_RANK() OVER(
            PARTITION BY age_category
            ORDER BY count(pet_preferences) DESC
        ) as rank,
        pet_preferences
    FROM age_group
        cross JOIN total_customers tc
    WHERE pet_preferences IS NOT NULL
    GROUP BY age_category,
        pet_preferences
)
SELECT age_category,
    pet_preferences,
    rank
FROM pet_rank
where rank in (1, 2, 3)