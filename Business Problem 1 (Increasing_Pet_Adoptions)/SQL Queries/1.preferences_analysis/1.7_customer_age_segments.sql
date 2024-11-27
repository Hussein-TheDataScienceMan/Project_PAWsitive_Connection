/* 
 Query: Calculate customer distribution across age segments
 Purpose: This query segments customers into age categories and calculates the percentage distribution 
 of each age category within the total customer base.
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
),
total_customers AS (
    -- Calculate the total number of customers
    SELECT
        COUNT(*) AS total
    FROM
        customers
) -- Count customers in each age category and calculate percentage of total customer base
SELECT
    ag.age_category,
    COUNT(*) AS age_group_count,
    ROUND(
        (COUNT(*) * 100.0 / tc.total),
        2
    ) AS percentage
FROM
    age_group ag
    CROSS JOIN total_customers tc
GROUP BY
    ag.age_category,
    tc.total;