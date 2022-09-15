-- 1 Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, ci.city, co.country
FROM sakila.store s 
JOIN sakila.address a USING(address_id)
JOIN sakila.city ci USING(city_id)
JOIN sakila.country co USING(country_id);


-- 2 Write a query to display how much business, in dollars, each store brought in.
select * from sakila.PAYMENT;
select * from sakila.STAFF;

SELECT s.store_id, sum(p.amount) as 'revenue (USD)'
FROM sakila.payment p
Join sakila.staff s using(staff_id)
join sakila.rental r using(rental_id)
group by s.store_id; 

-- 3 Which film categories are longest?
select * from sakila.film;
select * from sakila.category;

SELECT c.name, AVG(f.length) as 'avg_runtime'
FROM sakila.film f 
JOIN sakila.film_category fc USING(film_id)
JOIN sakila.category c USING(category_id)
GROUP BY c.name
ORDER BY AVG(f.length) DESC;

-- 4 Display the most frequently rented movies in descending order.
SELECT * from sakila.film;
SELECT * from sakila.rental;
SELECT * from sakila.payment;
select * from sakila.category;

SELECT f.title, COUNT(r.rental_id) as 'rental_frequency'
FROM sakila.film f
JOIN sakila.inventory i USING(film_id)
JOIN sakila.rental r USING (inventory_id)
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;

-- 5 List the top five genres in gross revenue in descending order.
use sakila;
select c.name as 'Film', sum(p.amount) as 'Gross Revenue'
	from category as c
	join film_category as fc on fc.category_id = c.category_id
	join inventory as i on i.film_id = fc.film_id
	join rental as r on r.inventory_id = i.inventory_id
	join payment as p on p.rental_id = r.rental_id
	group by c.name
	order by sum(p.amount) desc
	limit 5;

-- 6 Is "Academy Dinosaur" available for rent from Store 1?
select film.film_id, film.title, store.store_id, inventory.inventory_id
from sakila.inventory 
join sakila.store using (store_id) 
join sakila.film using (film_id)
where film.title = 'Academy Dinosaur' and store.store_id = 1;


-- 7 Get all pairs of actors that worked together.
SELECT fa1.film_id, CONCAT(a1.first_name, ' ', a1.last_name), CONCAT(a2.first_name, ' ', a2.last_name)
FROM sakila.actor a1
INNER JOIN film_actor fa1 USING(actor_id)
INNER JOIN film_actor fa2 ON (fa1.film_id = fa2.film_id)
AND (fa1.actor_id != fa2.actor_id)
INNER JOIN actor a2 ON a2.actor_id = fa2.actor_id;



-- 8 *Get all pairs of customers that have rented the same film more than 3 times.*
-- 9 *For each film, list actor that has acted in more films.*