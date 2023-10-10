
-- Task 5
-- Write a query joining the order_history and cust_order.
-- Join both tables using the order_id property.
-- Use a WHERE clause in your query to make it return a manageable amount of data.
SELECT *
FROM cust_order
JOIN order_history
ON order_history.order_id = cust_order.order_id
WHERE cust_order.order_id = 4412