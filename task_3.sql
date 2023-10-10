
-- Task 3
-- Select an order_id from order_history with a status_id corresponding to `Returned`
/*
SELECT * 
FROM order_history 
WHERE status_id = 6;
*/

-- Select all data in order_history with the order_id you found with the query above.
SELECT *
FROM order_history
WHERE order_id = 4412;