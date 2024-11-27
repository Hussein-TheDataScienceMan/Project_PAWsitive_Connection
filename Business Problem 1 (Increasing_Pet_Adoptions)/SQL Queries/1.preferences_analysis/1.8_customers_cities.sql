SELECT
    city,
    COUNT(customer_id) AS number_of_customers
FROM
    customers
GROUP BY
    city
ORDER BY
    number_of_customers DESC