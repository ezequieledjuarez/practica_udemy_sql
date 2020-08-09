SELECT * 
FROM rental;

SELECT *
FROM inventory;

SELECT 
	customer_id,
	rental_date
FROM rental;

-- Could you pull a list of the first name, last name and email of each of customers?

SELECT 
	first_name, 
    last_name, 
    email
FROM customer;

SELECT DISTINCT 
	rating
FROM film;

-- Could you pull the records of our films and see if there any other rental durations?

SELECT DISTINCT 
	rental_duration
FROM film;

SELECT 
	customer_id,
	rental_id,
	amount,
    payment_date
FROM payment
WHERE amount = 0.99;

SELECT 
	customer_id,
	rental_id,
	amount,
    payment_date
FROM payment
WHERE payment_date > '2006-01-01';

-- Could you pull all payments from our first 100 customers (based on customers ID) ?

SELECT *
FROM payment
WHERE customer_id <= 100;

-- You can use where customer_id < 101 or customer_id BETWEEN 1,100

SELECT
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE amount = 0.99
	AND payment_date >'2006-01-01';
    
-- Now i'd love to see just payment over $5 for those same customers, since January 1,2006

SELECT 
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE customer_id < 100
	AND amount >= 5
    AND payment_date > '2006-01-01'
    
SELECT 
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE customer_id = 5
	OR customer_id = 11
    OR customer_id = 29;

-- Could you please write a query to pull all payments from those specific customers, along with payments over $5, from any customer

SELECT
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE amount >=5
	OR customer_id = 42
    OR customer_id = 53
    OR customer_id = 60
    OR customer_id = 73;
    
SELECT
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE amount >=5
	OR customer_id IN (42,53,60,73);
    
-- example with WHERE
-- WHERE name LIKE 'Denise%'  starts with Denise
-- WHERE name LIKE '%fancy%' fancy is anywhere
-- WHERE name LIKE '%Johnson' end with Johnson
-- WHERE name LIKE '_erry' with erry and with excatly 1 character before

SELECT 
	title, 
    description
FROM film
WHERE description LIKE '%Dentist%';	

-- Could you pull a list of films which include a Behind the scenes special features

SELECT 
	title,
    special_features
FROM film
WHERE special_features LIKE '%Behind the Scenes%';

SELECT 
	rating,
    COUNT(film_id)
FROM film
GROUP BY 
	rating;
    
-- Could you please pull a count of titles sliced by rental duration?

SELECT 
    rental_duration,
    COUNT(film_id) AS 'Films_with_this_Rental_Duration'
FROM film
GROUP BY rental_duration;

SELECT
	rating,
    rental_duration,
    replacement_cost,
    COUNT(film_id) AS count_of_films
FROM film
GROUP BY
	rating,
    rental_duration,
    replacement_cost;
    
SELECT
	rating,
COUNT(film_id) AS count_of_films,
MIN(length) AS shortest_film,
MAX(length) AS longest_film,
AVG(length) AS average_length_of_folms,
-- SUM(length) as total_minutes
AVG(rental_duration) AS average_rental_duration
FROM film
GROUP BY
	rating;
    
-- Can you help me pull a count of films, along with the average, min, and max rental rate, grouped by replacemente cost?

SELECT 
	replacement_cost,
COUNT(film_id) as Number_of_films,
MIN(rental_rate) as Cheapest_rental,
MAX(rental_rate) as Most_expensive_rental,
AVG(rental_rate) AS Average_rental
FROM film
GROUP BY
	replacement_cost;

SELECT
	customer_id,
COUNT(rental_id) AS total_rental
FROM rental
GROUP BY
	customer_id
HAVING COUNT(rental_id) >= 30;


-- Could you pull a list of customer_ids with less than 15 rental all-tome?

SELECT 
	customer_id,
    COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY(customer_id)
HAVING COUNT(rental_id) < 15;

SELECT 
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
ORDER BY amount DESC, customer_id DESC;

SELECT 
	customer_id,
    SUM(amount) AS total_payment_amount
FROM payment
GROUP BY 
	customer_id
ORDER BY
    SUM(amount) DESC;
    
-- Could you pull me a list of all film titles along with their lengths anda rental rates and sort them from longest to shortest

SELECT 
	title,
    length,
    rental_rate
FROM film
ORDER BY
	length DESC;

SELECT DISTINCT 
	length,
    CASE
		WHEN length < 60 then 'under 1 hr'
        WHEN length BETWEEN 60 AND 90 THEN '1-1.5 hrs'
        WHEN length > 90 THEN 'over 1.5 hrs'
        ELSE 'uh oh...check logic!'
	END AS length_bucket
FROM film;

-- Could you pull a list of first last names of all customers and label them as either 'Store 1 active', 'Strore 2 active' or "Store 2 inactive'

SELECT 
	first_name, 
    last_name,
    CASE
    WHEN store_id = 1 and active = 1 THEN 'Store 1 active'
    WHEN store_id = 1 and active = 0 THEN 'Store 1 inactive'
    WHEN store_id = 2 and active = 1 THEN 'Store 2 active'
    WHEN store_id = 2 and active = 0 THEN 'Store 2 inactive'
    ELSE 'check logic!'
    END AS store_and_status
FROM customer;

SELECT
	film_id,
    COUNT(CASE WHEN store_id = 1 THEN inventory_id ELSE NULL END)AS store_1_copies,
    COUNT(CASE WHEN store_id = 2 THEN inventory_id ELSE NULL END)AS store_2_copies,
    COUNT(inventory_id) AS total_copies
FROM inventory
GROUP BY
	film_id
ORDER BY
	film_id;

SELECT
	film_id,
    COUNT(CASE WHEN store_id = 1 THEN inventory_id ELSE NULL END)AS store_1_inventory,
    COUNT(CASE WHEN store_id = 2 THEN inventory_id ELSE NULL END)AS store_1_inventory
FROM inventory
GROUP BY
    film_id
ORDER BY film_id;

-- Could you please create a table to count the number of customers broken down by store_id in rows and active status in columns

SELECT
	store_id,
	COUNT(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS active,
    COUNT(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS inactive
FROM customer 
GROUP BY 
    store_id
ORDER BY store_id;

-- 79 Inner Join ej

SELECT * FROM rental
	INNER JOIN	customer
    ON rental.customer_id = customer.customer_id;

SELECT DISTINCT 
rental.rental_id
FROM inventory
	INNER JOIN rental
    ON inventory.inventory_id = rental.inventory_id
LIMIT 5000;

-- Can you pull for me a list of each film we have in inventory?
-- I would like to see the film's title, description, and the store_id value associated with each items, and its inventory_id. Thanks!

SELECT
	inventory_id, 
    store_id, 
    title, 
    description 
FROM inventory
	INNER JOIN  film 
		ON inventory.film_id = film.film_id;
        
-- Looking for a films in which actors appeared

SELECT 
	actor.first_name,
    actor.last_name,
    COUNT(film_actor.film_id) AS number_of_films
FROM actor
	LEFT JOIN film_actor
		ON actor.actor_id = film_actor.actor_id
	GROUP BY
		actor.first_name,
        actor.last_name;
        
SELECT DISTINCT 
	inventory.inventory_id,
    rental.inventory_id
FROM inventory 
	LEFT JOIN rental
		ON inventory.inventory_id = rental.inventory_id
LIMIT 5000;

-- Can you pull a list of all titles, and figure out how many actores are asociated with each title?

SELECT 
	film.title,
    COUNT(film_actor.actor_id) AS number_of_actors
FROM film
LEFT JOIN film_actor
	ON film_actor.film_id = film.film_id
GROUP BY 
	film.film_id;

-- LEFT VS INNER VS RIGHT
    
SELECT
	actor.actor_id,
    actor.first_name AS actor_first,
    actor.last_name AS actor_last,
    actor_award.first_name AS award_first,
    actor_award.last_name AS award_last,
    actor_award.awards
FROM actor
	LEFT JOIN actor_award
		ON actor.actor_id = actor_award.actor_id
	ORDER BY actor_id;

SELECT
	actor.actor_id,
    actor.first_name AS actor_first,
    actor.last_name AS actor_last,
    actor_award.first_name AS award_first,
    actor_award.last_name AS award_last,
    actor_award.awards
FROM actor
	INNER JOIN actor_award
		ON actor.actor_id = actor_award.actor_id
	ORDER BY actor_id;
    
SELECT
	actor.actor_id,
    actor.first_name AS actor_first,
    actor.last_name AS actor_last,
    actor_award.first_name AS award_first,
    actor_award.last_name AS award_last,
    actor_award.awards
FROM actor
	RIGHT JOIN actor_award
		ON actor.actor_id = actor_award.actor_id
	ORDER BY actor_id;
    
-- FULL JOIN

SELECT
	film.film_id,
    film.title,
    category.name
FROM film
	INNER JOIN film_category
		ON film.film_id = film_category.film_id
	INNER JOIN category
		ON film_category.category_id = category.category_id;
        
-- It would be great to have a list of all actor, with each title that they appear in 
-- Could you please pull that for me?

SELECT 
	actor.first_name AS actor_first_name,
    actor.last_name AS actor_last_name,
    film.title AS film_title
FROM actor 
	INNER JOIN film_actor
		ON actor.actor_id = film_actor.actor_id
	INNER JOIN film 
		ON film.film_id = film_actor.film_id
ORDER BY actor.last_name, actor.first_name;

-- Multi conditions joins
SELECT
	film.film_id,
    film.title,
    film.rating,
    category.name
FROM film
	INNER JOIN film_category
		ON film.film_id = film_category.film_id
	INNER JOIN category
		ON film_category.category_id = category.category_id
WHERE category.name = 'horror'
ORDER BY film_id;

SELECT
film.film_id,
    film.title,
    film.rating,
    category.name
FROM film
	INNER JOIN film_category
		ON film.film_id = film_category.film_id
	INNER JOIN category
		ON film_category.category_id = category.category_id
		AND category.name = 'horror'
ORDER BY film_id;


-- Could you pull a list of distinct titles and their descriptions currently available in inventory at store 2?
SELECT DISTINCT 
	film.title,
    film.description
FROM film
    INNER JOIN inventory
		ON inventory.film_id = film.film_id
	AND inventory.store_id = 2;
    
-- UNION
SELECT
	'advisor' as type,
    first_name,
    last_name
FROM advisor
UNION
SELECT 
	'investor' as type,
    first_name,
    last_name
FROM investor;

-- Could you pull one list of all staff and advisor names,
-- and include a column nothing wheter they are a staff member or advisor? Thanks!

SELECT 
	'advisor' AS type,
    first_name,
    last_name
FROM advisor
UNION
SELECT 
	'staff' AS type,
    first_name,
    last_name
FROM staff;
    