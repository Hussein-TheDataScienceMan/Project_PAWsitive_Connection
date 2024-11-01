SELECT 
    gender,
    pet_preferences,
    COUNT(pet_preferences) as count,
    DENSE_RANK() OVER (PARTITION BY gender ORDER BY COUNT(pet_preferences) DESC ) 

FROM customers
WHERE pet_preferences IS NOT NULL AND pet_preferences <> 'No Preference'
GROUP BY gender, pet_preferences


-----------------------------
/* gender by city */
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


----------------------------
/* male to female ratio in each age group */

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
)
SELECT ag.age_category,
    gender,
    COUNT(ag.pet_preferences) AS count
FROM age_group ag
    JOIN customers c on ag.customer_id = c.customer_id
GROUP by ag.age_category,
    gender




-------------
/* gender by age group */
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
        gender,
        pet_preferences
    FROM customers
), ranked_preferences AS (
SELECT ag.age_category,
    ag.gender,
    ag.pet_preferences,
    COUNT(ag.pet_preferences) AS count,
    ROW_NUMBER() OVER (
        PARTITION BY ag.age_category,
        ag.gender
        ORDER BY COUNT(ag.pet_preferences) DESC
    ) AS preference_rank
FROM age_group ag
WHERE ag.pet_preferences is not NULL
    AND ag.pet_preferences <> 'No Preference'
GROUP by ag.age_category,
    ag.gender,
    ag.pet_preferences
)

SELECT 
    age_category,
    gender,
    pet_preferences,
    count,
    preference_rank
FROM ranked_preferences
WHERE preference_rank   IN (1,2)