-- Query: Determine the most popular pet preferences by gender
-- Purpose: This query ranks pet preferences for each gender based on count, providing insight into which types of pets are most favored by each gender.

SELECT 
    gender,
    pet_preferences,
    COUNT(pet_preferences) AS preference_count,
    DENSE_RANK() OVER (
        PARTITION BY gender 
        ORDER BY COUNT(pet_preferences) DESC
    ) AS rank
FROM 
    customers
WHERE 
    pet_preferences IS NOT NULL 
    AND pet_preferences <> 'No Preference'
GROUP BY 
    gender, 
    pet_preferences;
