WITH stay_period as (
    -- to calculate how long each pet(Adopted/Not Adopted) stayed in the center
    SELECT p.pet_id,
        species_name,
        arrival_date,
        ROUND(
            EXTRACT(
                YEAR
                FROM AGE(
                        CASE
                            WHEN p.adopted_status = 'Not Adopted' THEN '2023-12-31'::DATE
                            ELSE adoption_date
                        END,
                        arrival_date
                    )
            ) * 12 + EXTRACT(
                MONTH
                FROM AGE(
                        CASE
                            WHEN p.adopted_status = 'Not Adopted' THEN '2023-12-31'::DATE
                            ELSE adoption_date
                        END,
                        arrival_date
                    )
            ) + EXTRACT(
                DAY
                FROM AGE(
                        CASE
                            WHEN p.adopted_status = 'Not Adopted' THEN '2023-12-31'::DATE
                            ELSE adoption_date
                        END,
                        arrival_date
                    )
            ) / 30.44,
            2
        ) AS stay_period_months
    FROM pets p
        left JOIN adoptions a ON p.pet_id = a.pet_id
        LEFT JOIN species s ON p.species_id = s.species_id
),
avg_species AS (
    -- to calculate the average of stay time for all the species
    SELECT species_name,
        ROUND(AVG(stay_period_months), 2) AS avg_stay_period_months
    FROM stay_period
    GROUP BY species_name
)
SELECT pet_id,
    sp.species_name,
    stay_period_months,
    avg_stay_period_months
from avg_species avs
    RIGHT JOIN stay_period sp ON avs.species_name = sp.species_name
WHERE stay_period_months > avg_stay_period_months ---------------
  
  
  
    /*
     -- creating a table from these results
     
     CREATE TABLE abv_avg_stayed_pets AS
     WITH stay_period AS (
     -- Calculate how long each pet (Adopted/Not Adopted) stayed in the center
     SELECT 
     p.pet_id,
     s.species_name,
     p.arrival_date,
     ROUND(
     EXTRACT(YEAR FROM AGE(
     CASE WHEN p.adopted_status = 'Not Adopted' THEN '2023-12-31'::DATE
     ELSE adoption_date
     END, arrival_date)) * 12 
     + EXTRACT(MONTH FROM AGE(
     CASE WHEN p.adopted_status = 'Not Adopted' THEN '2023-12-31'::DATE
     ELSE adoption_date
     END, arrival_date))
     + EXTRACT(DAY FROM AGE(
     CASE WHEN p.adopted_status = 'Not Adopted' THEN '2023-12-31'::DATE
     ELSE adoption_date
     END, arrival_date)) / 30.44, 
     2) AS stay_period_months
     FROM pets p
     LEFT JOIN adoptions a ON p.pet_id = a.pet_id
     LEFT JOIN species s ON p.species_id = s.species_id
     ),
     avg_species AS (
     -- Calculate the average stay time for each species
     SELECT 
     species_name,
     ROUND(AVG(stay_period_months), 2) AS avg_stay_period_months
     FROM stay_period
     GROUP BY species_name
     )
     SELECT 
     sp.pet_id,
     sp.species_name,
     sp.stay_period_months,
     avs.avg_stay_period_months
     FROM avg_species avs
     RIGHT JOIN stay_period sp ON avs.species_name = sp.species_name
     WHERE sp.stay_period_months > avs.avg_stay_period_months;
     
     
     */