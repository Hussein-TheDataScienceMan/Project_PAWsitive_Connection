/* 
 Query: Calculate the male-to-female ratio in each age group
 Purpose: This query categorizes customers into age groups and counts the number of males and females in each group.
 */
WITH age_group AS (
    -- Categorize customers by age group
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
        END AS age_category
    FROM
        customers
) -- Count the number of males and females in each age category
SELECT
    ag.age_category,
    c.gender,
    COUNT(*) AS gender_count
FROM
    age_group ag
    JOIN customers c ON ag.customer_id = c.customer_id
GROUP BY
    ag.age_category,
    c.gender;