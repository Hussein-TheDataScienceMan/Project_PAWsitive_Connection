-- customers age segments



WITH age_group AS (
    SELECT customer_id,
        date_of_birth,
        DATE_PART('year', AGE('2023-12-31', date_of_birth)),
        CASE
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) BETWEEN 17 and 30 THEN 'Young Adult'
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) BETWEEN 31 and 55 THEN 'Middle-Age Adult'
            WHEN DATE_PART('year', AGE('2023-12-31', date_of_birth)) >= 56 THEN 'Senior'
            else 'Other'
        end AS age_category
    FROM customers
),
total_customers AS (
    SELECT COUNT(*) AS total
    FROM customers
)
SELECT age_category,
    count(*),
    round(
        CEIL((COUNT(*) * 100.0 / tc.total) * 100) / 100.0
    ) AS percentage
FROM age_group
    cross JOIN total_customers tc
GROUP BY age_category,
    tc.total