-- Syntax: SELECT columns FROM table
SELECT * 
FROM actor;

-- Can be one line, the semicolon is what ends a command
SELECT * FROM film;

-- Query for specific columns -- SELECT col_1, col_2, col_3, etc. FROM table_name
SELECT title, description, length
FROM film;

-- *Columns will come back in the order specified
SELECT last_name, first_name
FROM actor;

-- Filter Rows - use WHERE clause - always come after the FROM
SELECT *
FROM actor
WHERE first_name = 'Dan';

SELECT first_name, last_name, store_id
FROM customer
WHERE store_id = 2;

-- use wildcards with the LIKE clause - % acts as a multi-character wildcard
-- can be any number of characters (0->infinity) - zero or many - r'[\w\s]*'
SELECT *
FROM actor
WHERE first_name LIKE 'M%';

SELECT *
FROM actor
WHERE last_name LIKE '%r%';

-- Underscore (_) with LIKE clause -- represents 1 and only 1 character
SELECT *
FROM actor
WHERE first_name LIKE '_i_';

SELECT *
FROM actor
WHERE first_name LIKE '_i%';


-- using AND and OR in the WHERE clause
-- OR - only one needs to be true
SELECT *
FROM actor
WHERE first_name LIKE 'N%' OR last_name LIKE 'W%';

-- AND -- all conditions need to be true
SELECT *
FROM actor
WHERE first_name LIKE 'N%' AND last_name LIKE 'W%';


-- Comparison Operators in SQL:
-- Greater Than >    
-- Less Than <
-- Greater Than or Equal To >=  
-- Less Than or Equal To <=
-- Equal =  
-- Not Equal <> or !=

SELECT *
FROM payment;


-- Query all of the payments of more than $7.00
SELECT customer_id, amount
FROM payment
WHERE amount > 7.00;

SELECT customer_id, amount
FROM payment
WHERE amount <= '6.99';


-- Not Equals
SELECT *
FROM customer
WHERE store_id <> 1; -- NOT Equal

SELECT *
FROM customer
WHERE store_id != 2; -- NOT Equal

SELECT *
FROM actor
WHERE first_name NOT LIKE 'P%';


-- Get all payments between $3 and $8 (inclusive)
SELECT *
FROM payment
WHERE amount >= 3 AND amount <= 8;

-- BETWEEN/AND Clause
SELECT *
FROM payment
WHERE amount BETWEEN 3 AND 8;

SELECT *
FROM film
WHERE film_id BETWEEN 10 AND 20;

-- Order the rows of data - ORDER BY
-- default is Ascending order (add DESC for descending)
SELECT *
FROM film
ORDER BY length;

SELECT *
FROM film 
ORDER BY title DESC;

-- ORDER BY comes after the WHERE (if present)
SELECT *
FROM payment
WHERE customer_id = 345
ORDER BY amount;


-- Exercise 1 - Write a query that will return all of the films that have an 'h' in the title and order it 
-- by rental_duration (ASC)
SELECT *
FROM film
WHERE title ILIKE '%h%' -- ILIKE IS the CASE INSENSITIVE LIKE
ORDER BY rental_duration ASC;



-- SQL Aggregations => SUM(), AVG(), COUNT(), MIN(), MAX()
-- take in a column_name as an argument and return a single value


-- SUM - finds the sum of a column
SELECT SUM(amount)
FROM payment;

SELECT SUM(amount)
FROM payment
WHERE amount > 5;


-- AVG - finds the average a column
SELECT AVG(amount)
FROM payment;

-- MIN/MAX - finds the smallest/largest value in a column
-- also alias the column name  - col_name AS alias_name
SELECT MIN(amount) AS lowest_amount_paid, MAX(amount) AS highest_amount_paid
FROM payment;

-- MIN() and MAX() can work on strings as well!
SELECT MIN(first_name), MAX(last_name)
FROM actor;


-- COUNT() - Takes in either the column name OR * for all columns
-- If column_name, will count how many NON-NULL rows, if * will count all rows
SELECT *
FROM staff;

SELECT COUNT(*)
FROM staff; -- RETURNS 2 because there ARE 2 ROWS

SELECT COUNT(picture)
FROM staff; -- RETURNS 1 becaise ONLY one ROW has a picture, the other IS NULL!

-- To count unique values in a column, use the DISTINCT keyword
-- COUNT(DISTINCT col_name)
SELECT COUNT(first_name)
FROM actor; -- 200

SELECT COUNT(DISTINCT first_name)
FROM actor; -- 128


-- Calculate a new column based on other columns
SELECT payment_id, rental_id, payment_id - rental_id AS difference
FROM payment;

-- CONCAT - will concatenate multiple strings together
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM actor;


-- GROUP BY Clause
-- Used with aggregations

SELECT COUNT(*)
FROM payment
WHERE amount = 1.99; 
-- 580

SELECT COUNT(*)
FROM payment
WHERE amount = 2.99;
-- 3233

SELECT *
FROM payment
ORDER BY amount;

SELECT amount, COUNT(*), SUM(amount), AVG(amount)
FROM payment
GROUP BY amount
ORDER BY amount;


-- columns selected from the table must also be in the group by
SELECT amount, customer_id, COUNT(*)
FROM payment
GROUP BY amount; --column "payment.customer_id" must appear in the GROUP BY clause or be used in an aggregate function


SELECT amount, customer_id, COUNT(*)
FROM payment
GROUP BY amount, customer_id
ORDER BY customer_id;


-- Use Aggregation results in the ORDER BY caluse
-- QUERY the payment table to display the customers (by id) who have spent the most (in order)
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

-- Alias the aggregated column and use in the ORDER BY
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC;


-- HAVING Clause -> HAVING is to GROUP BY/Aggregations as WHERE is to SELECT
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 150
ORDER BY total_spent DESC;

SELECT customer_id, COUNT(*)
FROM payment 
GROUP BY customer_id 
HAVING COUNT(*) BETWEEN 20 AND 30;

SELECT customer_id, COUNT(*)
FROM payment 
GROUP BY customer_id 
HAVING COUNT(*) >= 20 AND COUNT(*) <= 30;


-- LIMIT and OFFSET clauses

-- LIMIT - limit the number of rows that are returned

SELECT *
FROM film
LIMIT 10;

-- OFFSET - start your rows after a certain number of rows using offset
SELECT *
FROM actor
OFFSET 10; -- SKIP THE FIRST 10 ROWS

-- Can be used together
SELECT *
FROM actor
OFFSET 10
LIMIT 5;


-- Putting all of the clauses together
-- Of all customer who have made less than 20 payments and have a customer_id > 350, display 
-- those who have spent 11-30th most
SELECT customer_id, COUNT(*), SUM(amount) AS total_spend
FROM payment
WHERE customer_id > 350
GROUP BY customer_id
HAVING COUNT(*) < 20
ORDER BY total_spend DESC
OFFSET 10
LIMIT 20;


-- SYNTAX ORDER: (SELECT and FROM are the only mandatory)

-- SELECT (columns from table)
-- FROM (table_name)
-- WHERE (row filter)
-- GROUP BY (aggregations)
-- HAVING (filter aggregations)
-- ORDER BY (column value ASC or DESC)
-- OFFSET (number of rows to skip)
-- LIMIT (max number of rows to display)

SELECT customer_id, COUNT(*), SUM(amount) AS total_spend FROM payment WHERE customer_id > 350 GROUP BY customer_id HAVING COUNT(*) < 20 ORDER BY total_spend DESC OFFSET 10 LIMIT 10;
