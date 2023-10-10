
-- Task 6
-- Write a query joining the order_history and cust_order.
-- Join both tables using the order_id property.
-- Aggregate the data per customer using a group by on customer_id.
-- Count the amount of returned orders per customer and assign an alias.
-- Only look at data of returned orders.
-- Order the data on the amount of returned orders from most to least.



SELECT cust_order.customer_id, COUNT(order_history.order_id) AS returned_orders
FROM cust_order
JOIN order_history
ON order_history.order_id = cust_order.order_id
WHERE order_history.status_id = 6
GROUP BY cust_order.customer_id
ORDER BY returned_orders DESC; 