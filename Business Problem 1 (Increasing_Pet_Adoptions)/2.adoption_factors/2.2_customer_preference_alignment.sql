SELECT
    pet_preferences,
    species_name,
    count(*)
FROM
    adoptions a
    LEFT JOIN customers c ON a.customer_id = c.customer_id
    LEFT JOIN pets p ON a.pet_id = p.pet_id
    LEFT JOIN species s ON p.species_id = s.species_id
WHERE
    pet_preferences is not null AND pet_preferences <> 'No Preference'
GROUP BY
    pet_preferences,
    species_name

ORDER BY
    pet_preferences