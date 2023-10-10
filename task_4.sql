
-- Task 4
--Write a query to find the amount of returned orders in order_history.
SELECT COUNT(*) 
FROM order_history
WHERE status_id = 6;