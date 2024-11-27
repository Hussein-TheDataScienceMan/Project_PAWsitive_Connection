/* 
 Query: Identify pets with above-average stay periods by species
 Purpose: This query calculates the stay period of each pet and compares it to the species-specific average,
 identifying pets whose stay period exceeds the average for their species.
 */
WITH stay_period AS (
    -- Calculate stay period in months for each pet (whether Adopted or Not Adopted)
    SELECT
        p.pet_id,
        s.species_name,
        p.arrival_date,
        ROUND(
            EXTRACT(
                YEAR
                FROM
                    AGE(
                        CASE
                            WHEN p.adopted_status = 'Not Adopted' THEN '2023-12-31' :: DATE
                            ELSE a.adoption_date
                        END,
                        p.arrival_date
                    )
            ) * 12 + EXTRACT(
                MONTH
                FROM
                    AGE(
                        CASE
                            WHEN p.adopted_status = 'Not Adopted' THEN '2023-12-31' :: DATE
                            ELSE a.adoption_date
                        END,
                        p.arrival_date
                    )
            ) + EXTRACT(
                DAY
                FROM
                    AGE(
                        CASE
                            WHEN p.adopted_status = 'Not Adopted' THEN '2023-12-31' :: DATE
                            ELSE a.adoption_date
                        END,
                        p.arrival_date
                    )
            ) / 30.44,
            2
        ) AS stay_period_months
    FROM
        pets p
        LEFT JOIN adoptions a ON p.pet_id = a.pet_id
        LEFT JOIN species s ON p.species_id = s.species_id
),
avg_species AS (
    -- Calculate the average stay period per species
    SELECT
        species_name,
        ROUND(AVG(stay_period_months), 2) AS avg_stay_period_months
    FROM
        stay_period
    GROUP BY
        species_name
) -- Retrieve pets whose stay period is above the species average
SELECT
    sp.pet_id,
    sp.species_name,
    sp.stay_period_months,
    avs.avg_stay_period_months,
    CASE
        WHEN sp.species_name IS NOT NULL THEN 'Stayed Above Average'
        ELSE ''
    END AS stay_state__from_avg
FROM
    avg_species avs
    RIGHT JOIN stay_period sp ON avs.species_name = sp.species_name
WHERE
    sp.stay_period_months > avs.avg_stay_period_months;

/*
 Note for Future Documentation:
 - A table was created for pets with above-average and below-average stay periods, 
 which were later merged to streamline analysis. 
 - This approach may be highlighted in the README to showcase practical handling of 
 segmented data for further insights.
 */