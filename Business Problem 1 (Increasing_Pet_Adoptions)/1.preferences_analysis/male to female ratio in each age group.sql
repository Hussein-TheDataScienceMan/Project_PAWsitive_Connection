
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


