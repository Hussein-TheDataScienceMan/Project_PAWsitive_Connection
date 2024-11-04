SELECT 
    gender,
    pet_preferences,
    COUNT(pet_preferences) as count,
    DENSE_RANK() OVER (PARTITION BY gender ORDER BY COUNT(pet_preferences) DESC ) 

FROM customers
WHERE pet_preferences IS NOT NULL AND pet_preferences <> 'No Preference'
GROUP BY gender, pet_preferences
