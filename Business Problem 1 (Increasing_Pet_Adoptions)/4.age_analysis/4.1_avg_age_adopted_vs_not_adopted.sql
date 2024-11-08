/* 
 Query: Calculate average age of adopted vs. non-adopted pets by species
 Purpose: This query calculates the average age at which pets were adopted compared to the current age of non-adopted pets as of December 31, 2023.
 Note: Since the reference date differs between adopted (adoption date) and non-adopted pets (2023-12-31), interpreting comparisons between these groups may be less meaningful.
 */
SELECT
    s.species_name,
    -- Average age of pets at the time of adoption
    ROUND(
        AVG(
            CASE
                WHEN p.adopted_status = 'Adopted' THEN DATE_PART('year', AGE(adoption_date, p.year_of_birth)) + DATE_PART('month', AGE(adoption_date, p.year_of_birth)) / 12.0
            END
        ) :: numeric,
        2
    ) AS avg_age_at_adoption,
    -- Average age of non-adopted pets as of December 31, 2023
    ROUND(
        AVG(
            CASE
                WHEN p.adopted_status = 'Not Adopted' THEN DATE_PART('year', AGE('2023-12-31', p.year_of_birth)) + DATE_PART('month', AGE('2023-12-31', p.year_of_birth)) / 12.0
            END
        ) :: numeric,
        2
    ) AS avg_age_at_collection
FROM
    pets p
    LEFT JOIN species s ON p.species_id = s.species_id
    LEFT JOIN adoptions a ON p.pet_id = a.pet_id
GROUP BY
    s.species_name
ORDER BY
    s.species_name;