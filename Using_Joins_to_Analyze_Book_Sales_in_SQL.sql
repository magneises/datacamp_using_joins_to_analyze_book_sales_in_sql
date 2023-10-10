-- # Using Joins to Analyze Book Sales in SQL

-- In this code along, we will be creating a data insight using joins. We will look at a database from a fictional bookstore. 
-- First we will use some simple queries to get a feel for the structure and meaning of the different tables and columns. 
-- After which we will join two tables together to create insights we could otherwise not get. 
-- First with a basic join, then building on top of the simple join using `group by` and `count`. Let's get started!
-- You can consult the solution for this code along in the file browser (`notebook-solution.ipynb`)


-- ## Task 0. Setup the integration
-- Before we can get started, follow the instructions in this task to connect to the database and verify your connection is working.
-- ### Instructions
-- Open th Databases tab in the left side bar. Click “Connect Database”, select PostgreSQL, and enter:  
/*
- Integration name: `Gravity Books`  
- Port: `5432`  
- Hostname: `workspacedemodb.datacamp.com`  
- Database: `gravity_books`  
- Username: `gravity_employee`  
- Password: `employee1`
*/
-- Then run the query below, it will show you 10 random customers from the Gravity bookstore. 
-- It is good practice to limit the amount of rows in a query when starting to work on a table of unknown size.


-- # Exploring the data set
-- SELECT * FROM customer LIMIT 10;




-- ## Task 1. How are the tables linked in the Gravity Books database?
/*
Instructions
Go to integrations on the left side bar.
Click on the Gravity Books Integration you just created.
Click on Tables if you don't see the list of tables in the database.
We'll be focusing on the customer and order related tables, read through the tables.
Reason about how they could be connected to each other.
Read the column names to from a better picture of how tables are connected.


What do the tables tell us about the database structure?
In this case we can derive from the tables and columns that:

customer has order in cust_order
The status of the orders in cust_order is in order_history
To understand what the status_id in order_history means we need to look at order_status.
More information about what is in an order from cust_order is in order_line.
*/ 



-- ## Task 2. What do the ids in the status tables mean?
/*
Because a (book) store is something we encounter in our day to day life it is relatively straightforward to understand how data in this database for a bookstore is structured. 
However, understanding how data is linked is often not straightforward if you're not familiar with the domain of the data in the database.

Most of us know or can imagine how a bookstore works and what data they need to sell and ship books to customers. But would most of us be able to understand 
how data is connected for the approval process pharmaceutical manufacturing process?

Even in this case not all fields can be understood without actually looking at the data in the tables. Specifically the address_status, order_status tables.

Instructions
Select the full address_status table to understand which id responds to which status.
Do the same for the order_status field.
*/ 


-- SELECT * FROM order_status

/*
Task 3. 
How does the order_history table work?
When reading through the tables and columns we made a hypothesis on how the order_history works, let's verify our hypothesis before we start analyzing the data in this table.

The table name indicates that this table will hold historic information in some way, looking at the columns we can see that each entry get a unique id, history_id, indicating that there is most likely going to be multiple entries per order_id. Additionally the only other columns are status_id and status_date column, indicating this table is storing the date at which an order moved to a specific status.

Instructions
Find an order_id of a random Returned order.
Look up the full order_history of this order_id to
*/


-- Find an order_id of a random Returned order.
/*
 SELECT * FROM order_history WHERE status_id = 6;
*/

-- Look up the full order_history of this order_id
/*
SELECT *
FROM order_history
WHERE order_id = 4412;
*/





/*
Task 4. 
How many errors are returned by users?
A colleague working in the bookstore had the same customer come in twice in a single week to return an order. They thought this was unusual and asked you to investigate. Let us look into the data to see if there is an issue with a significant amount of users returning multiple orders.

Before we start writing more complex queries lets do an initial count to make sure we have data for orders being returned.

Instructions
Write a query to find the amount of returned orders in order_history.
Use the status_id for Returned orders we found in a previous task.
*/
/*
SELECT COUNT(*) 
FROM order_history
WHERE status_id = 6;
*/ 


/*
Task 5. 
How to join the order_history and cust_order tables?
To analyze the number of users returning multiple orders we have to link returned orders to customers. This is done joining the order_history and cust_order tables. Let's start with writing a minimal join for a single order_id to make sure our join works as expected.

Instructions
Write a query joining the order_history and cust_order.
Join both tables using the order_id property.
Use a WHERE clause in your query to make it return a manageable amount of data.
*/

-- Write a query joining the order_history and cust_order.
/*
SELECT *
FROM cust_order
JOIN order_history
ON order_history.order_id = cust_order.order_id
WHERE cust_order.order_id = 4412
*/

/*
Task 6. 
Do a significant number of users return multiple orders?
Now that we successfully joined the order_history and cust_order table we can add the other parts needed to get a clear view of outliers in the data.

Instructions
Write a query joining the order_history and cust_order.
Join both tables using the order_id property.
Aggregate the data per customer using a group by on customer_id.
Count the amount of returned orders per customer and assign an alias.
Only look at data of returned orders.
Order the data on the amount of returned orders from most to least.
*/

/*
SELECT cust_order.customer_id, COUNT(order_history.order_id) AS returned_orders
FROM cust_order
JOIN order_history
ON order_history.order_id = cust_order.order_id
WHERE order_history.status_id = 6
GROUP BY cust_order.customer_id
ORDER BY returned_orders DESC;
*/



/*
Task 7. 
Who are the customers returning more orders than usual?
After showing that there are some users returning more orders than others, we would like to create a list of users to investigate or contact and get to the bottom of why these users return more orders than others.

Instructions
Build on top of the previous query
Filter for users that have returned 2 or more orders using a having clause.
Add additional data for each customer: first_name, last_name and email.
*/


SELECT customer.first_name, customer.last_name, customer.email, cust_order.customer_id, COUNT(order_history.order_id) AS returned_orders
FROM cust_order
JOIN order_history
ON order_history.order_id = cust_order.order_id
LEFT JOIN customer ON customer.customer_id = cust_order.customer_id
WHERE order_history.status_id = 6
GROUP BY cust_order.customer_id, customer.first_name, customer.last_name, customer.email
HAVING COUNT(order_history.order_id) > 1
ORDER BY returned_orders DESC; 














