/* 
 IN THE RESULTS HERE: THIRD FAV PET FOR SENIORS IS EXOTIC, DOESN'T SEEM REALISTIC, BUT I WILL LEAVE IT
 TO DEMONSTRATE DATA INTEGRITY.
 */

-- Query: Determine the top pet preferences by age group
-- Purpose: This query ranks pet preferences for each age category, showing the top three preferences per group.

WITH age_group AS (
    -- Categorize customers into age groups and associate their pet preferences
    SELECT 
        customer_id,
        date_of_birth,
        DATE_PART('year', AGE('2023-12-31', date_of_birth)),
        CASE
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) BETWEEN 17 AND 30 THEN 'Young Adult'
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) BETWEEN 31 AND 55 THEN 'Middle-Age Adult'
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) >= 56 THEN 'Senior'
            ELSE 'Other'
        END AS age_category,
        pet_preferences
    FROM 
        customers
),
total_customers AS (
    -- Get the total number of customers for reference (not actively used in this query but included for potential scaling)
    SELECT 
        COUNT(*) AS total
    FROM 
        customers
),
ranked_preferences AS (
    -- Rank pet preferences within each age category
    SELECT 
        age_category,
        COUNT(pet_preferences) AS preference_count,
        pet_preferences,
        DENSE_RANK() OVER (
            PARTITION BY age_category
            ORDER BY COUNT(pet_preferences) DESC
        ) AS rank
    FROM 
        age_group
    WHERE 
        pet_preferences IS NOT NULL
        AND pet_preferences <> 'No Preference'
    GROUP BY 
        age_category,
        pet_preferences
)

-- Select the top three preferences per age category
SELECT 
    age_category,
    pet_preferences,
    rank,
    preference_count
FROM 
    ranked_preferences
WHERE 
    rank IN (1, 2, 3);
