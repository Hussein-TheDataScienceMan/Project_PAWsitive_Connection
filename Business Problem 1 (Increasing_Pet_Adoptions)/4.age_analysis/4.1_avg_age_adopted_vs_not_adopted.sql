/* Calculating avg age of adopted pets on adoption date vs avg age of non-adopted pets as of 31-12-2023
 I don't think it's usefull but i will just keep it

  i don't think that it's practical to analyze any data related to age here because 
it won't give any realistic results because when to calculate the age of the pets, i don't see it reasonable to have the age of adopted pets calculated on adoption day and not adopted on 31st for the above avg and below avg pets, it's only slightly usefull for the age on adoptioon date and that's it  


 */
SELECT
    s.species_name,
    ROUND(
        AVG(
            CASE
                WHEN p.adopted_status = 'Adopted' THEN DATE_PART('year', AGE(adoption_date, p.year_of_birth)) + DATE_PART('month', AGE(adoption_date, p.year_of_birth)) / 12.0
            END
        ) :: numeric,
        2
    ) AS avg_age_at_adoption,
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