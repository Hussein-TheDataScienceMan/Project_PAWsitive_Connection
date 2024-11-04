/* 
 IN THE RESULTS HERE: THIRD FAV PET FOR SENIORS IS EXOTIC, DOESN'T SEEM REALISTIC, BUT I WILL LEAVE IT
 TO DEMONSTRATE DATA INTEGRITY.
 */
-- what different ages love?
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
        count(pet_preferences) AS preference_count,
        DENSE_RANK() OVER(
            PARTITION BY age_category
            ORDER BY count(pet_preferences) DESC
        ) as rank,
        pet_preferences
    FROM age_group
        cross JOIN total_customers tc
    WHERE pet_preferences IS NOT NULL
        AND pet_preferences <> 'No Preference'
    GROUP BY age_category,
        pet_preferences
)
SELECT age_category,
    pet_preferences,
    rank,
    preference_count
FROM pet_rank
where rank in (1, 2, 3)