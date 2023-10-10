
-- Task 6
-- Build on top of the previous query
-- Filter for users that have returned 2 or more orders using a having clause.
-- Add additional data for each customer: first_name, last_name and email.


SELECT customer.first_name, customer.last_name, customer.email, cust_order.customer_id, COUNT(order_history.order_id) AS returned_orders
FROM cust_order
JOIN order_history
ON order_history.order_id = cust_order.order_id
LEFT JOIN customer ON customer.customer_id = cust_order.customer_id
WHERE order_history.status_id = 6
GROUP BY cust_order.customer_id, customer.first_name, customer.last_name, customer.email
HAVING COUNT(order_history.order_id) > 1
ORDER BY returned_orders DESC; 
