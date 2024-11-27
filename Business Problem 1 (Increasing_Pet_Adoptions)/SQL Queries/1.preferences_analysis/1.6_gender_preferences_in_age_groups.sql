/* 
 Query: Determine the top two pet preferences by gender within each age group
 Purpose: This query ranks pet preferences by gender within each age group, showing the top two preferences for each group.
 */
WITH age_group AS (
    -- Categorize customers into age groups and associate each with gender and pet preferences
    SELECT
        customer_id,
        date_of_birth,
        DATE_PART('year', AGE('2023-12-31', date_of_birth)),
        CASE
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) BETWEEN 17
            AND 30 THEN 'Young Adult'
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) BETWEEN 31
            AND 55 THEN 'Middle-Age Adult'
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) >= 56 THEN 'Senior'
            ELSE 'Other'
        END AS age_category,
        gender,
        pet_preferences
    FROM
        customers
),
ranked_preferences AS (
    -- Rank pet preferences within each age category and gender
    SELECT
        ag.age_category,
        ag.gender,
        ag.pet_preferences,
        COUNT(ag.pet_preferences) AS preference_count,
        ROW_NUMBER() OVER (
            PARTITION BY ag.age_category,
            ag.gender
            ORDER BY
                COUNT(ag.pet_preferences) DESC
        ) AS preference_rank
    FROM
        age_group ag
    WHERE
        ag.pet_preferences IS NOT NULL
        AND ag.pet_preferences <> 'No Preference'
    GROUP BY
        ag.age_category,
        ag.gender,
        ag.pet_preferences
) -- Retrieve the top two preferences for each gender within each age category
SELECT
    age_category,
    gender,
    pet_preferences,
    preference_count,
    preference_rank
FROM
    ranked_preferences
WHERE
    preference_rank IN (1, 2);