/*1a. Display first and last name of all actors from the table actors*/

USE sakila;
SET SQL_SAFE_UPDATES = 0;

SELECT 
    first_name, last_name
FROM
    actor;


/*1b. Display the first and last name of each actor in a single column in upper case letters. 
Name the column Actor Name.*/

ALTER TABLE actor ADD COLUMN Actor_Name VARCHAR(100);

UPDATE actor 
SET 
    Actor_Name = CONCAT(first_name, ' ', Last_name, ' ');

SELECT 
    *
FROM
    actor;


/*2a. You need to find the ID number, first name, and last name of an actor, of whom you 
know only the first name, "Joe." What is one query would you use to obtain this information?*/


SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    first_name = 'Joe';
    
/*2b. Find all actors whose last name contain the letters GEN:*/

SELECT 
    last_name
FROM
    actor
WHERE
    last_name LIKE '%G%'
        AND last_name LIKE '%E%'
        AND last_name LIKE '%N%';

/*2c. Find all actors whose last names contain the letters LI. 
This time, order the rows by last name and first name, in that order:*/

SELECT 
    first_name, last_name
FROM
    actor
WHERE
    last_name LIKE '%L%'
        AND last_name LIKE '%I%';

/*2d. Using IN, display the country_id and country columns of the following countries: 
Afghanistan, Bangladesh, and China:   */     

SELECT 
    *
FROM
    actor
ORDER BY last_name , first_name ASC;

SELECT 
    country_id, country
FROM
    country
WHERE
    country IN ('Afghanistan' , 'Bangladesh', 'China');


/*3a. You want to keep a description of each actor. 
You don't think you will be performing queries on a description, 
so create a column in the table actor named description and use the data 
type BLOB (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).*/

ALTER TABLE actor ADD COLUMN Discription BLOB(100);

SELECT 
    *
FROM
    actor;


/*3b. Very quickly you realize that entering descriptions for each actor is too much effort. 
Delete the description column.*/

ALTER TABLE actor DROP COLUMN Discription;

/*4a. List the last names of actors, as well as how many actors have that last name.*/

SELECT 
    *
FROM
    actor;


SELECT 
    first_name, last_name
FROM
    actor
WHERE
    last_name LIKE 'Williams';
    
/*4b. List last names of actors and the number of actors who have that last name, but 
only for names that are shared by at least two actors*/

SELECT 
    last_name, COUNT(1)
FROM
    actor
GROUP BY last_name
HAVING COUNT(*) >= 2;

/*4c. The actor HARPO WILLIAMS was accidentally entered
 in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.*/
 
UPDATE actor 
SET 
    first_name = 'Harpo'
WHERE
    last_name = 'Williams';
SELECT 
    *
FROM
    actor;

/*4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct 
name after all! In a single query, 
if the first name of the actor is currently HARPO, change it to GROUCHO.*/

UPDATE actor 
SET 
    first_name = 'Groucho'
WHERE
    first_name = 'Harpo'
        AND last_name = 'Williams';
SELECT 
    *
FROM
    actor;


/*5a. You cannot locate the schema of the address table. Which query would you use to re-create it?*/
SHOW CREATE TABLE address;
 


/*6a. Use JOIN to display the first and last names, as well as the address, of each staff member. 
#Use the tables staff and address:

#Checking for a common ID to join on . Both files have address_ID'*/

DESCRIBE staff;
DESCRIBE address;

#join on address_id as its common in both and is a primary key in address

SELECT 
    first_name, last_name, address
FROM
    address a
        JOIN
    staff s ON s.address_id = a.address_id;


/*6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. 
#Use tables staff and payment.*/

DESCRIBE staff;

DESCRIBE payment;

#join on staff_id as its common in both and is a primary key in staff

SELECT 
    s.staff_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS 'Total Payment'
FROM
    staff s
        JOIN
    payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id;



/*6c. List each film and the number of actors who are listed for that film. Use tables 
film_actor and film. Use inner join.*/

DESCRIBE film_actor;

DESCRIBE film;

#join on film_id as its common in both and is a primary key in film

SELECT 
    f.title, COUNT(fa.actor_id) AS 'Number of Actors'
FROM
    film f
        JOIN
    film_actor fa ON f.film_id = fa.film_id
GROUP BY f.title;
    
    
/*6d. How many copies of the film Hunchback Impossible exist in the inventory system?*/

DESCRIBE inventory;
DESCRIBE film;


SELECT count(film_id) as 'Total Copies'
FROM
    inventory
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'Hunchback Impossible');
 
/*6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
List the customers alphabetically by last name:
#join on customer_id as its common in both and is a primary key in customer*/

DESCRIBE payment;
DESCRIBE customer;

SELECT 
    c.first_name, c.last_name, SUM(p.amount) AS 'Total Amount'
FROM
    customer c
        INNER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY c.last_name , c.first_name
ORDER BY c.last_name ASC;

/*7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
films starting with the letters K and Q have also soared in popularity. 
Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.*/

DESCRIBE film;
DESCRIBE language;


SELECT
   title
FROM
   film
WHERE
   title LIKE 'k%'
       OR title LIKE 'Q%'
       AND language_id IN (SELECT
           language_id
       FROM
           language
       WHERE
           name = 'English');

/*7b. Use subqueries to display all actors who appear instaff the film Alone Trip.*/

SELECT
   Actor_Name
FROM
   actor
WHERE
   actor_id IN (SELECT
           actor_id
       FROM
           film_actor
       WHERE
           film_id IN (SELECT
                   film_id
               FROM
                   film
               WHERE
                   title = 'Alone Trip'));
                   
/*7c. You want to run an email marketing campaign in Canada, for which you will need 
#the names and email addresses of all Canadian customers. Use joins to retrieve this information.*/

describe customer; #address_id
describe address; #address_id, city_id
describe city; #city_id, country_id
describe country; #country_id


SELECT 
    cu.email, co.country
FROM
    customer cu
        JOIN
    address a ON cu.address_id = a.address_id
        JOIN
    city c ON c.city_id = a.city_id
        JOIN
    country co ON co.country_id = c.country_id
WHERE
    country = 'Canada';
 

/*7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
#Identify all movies categorized as family films.*/

describe category; #category_id
describe film_category; #category_id, film_id
describe film; #film_id

SELECT 
    f.title, c.name
FROM
    film f
        JOIN film_category fc ON fc.film_id = f.film_id
        JOIN category c ON c.category_id = fc.category_id
where c.name = 'Family';

 
/*7e. Display the most frequently rented movies in descending order.*/
describe rental;#rental_id, inventory_id, customer_id, staff_id
describe film; #Film_id, language_id
describe inventory; #Film_id,inventory_id

SELECT 
    f.title, COUNT(r.rental_id) AS 'Times Rented'
FROM
    film f
        JOIN
    inventory i ON i.film_id = f.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;


/*7f. Write a query to display how much business, in dollars, each store brought in.*/
describe payment; #payment_id, customer_id, staff_id, rental_id
describe staff; #staff_id, store_id
 
SELECT 
    s.store_id, SUM(p.amount) AS 'Total Amount per Store'
FROM
    staff s
        JOIN
    payment p ON s.staff_id = p.staff_id
GROUP BY s.store_id;


/*7g. Write a query to display for each store its store ID, city, and country.*/
describe customer; #address_id, store_id, customer_id
describe address; #address_id, city_id
describe city; #city_id, country_id
describe country; #country_id

SELECT 
    cu.store_id, c.city, co.country
FROM
    customer cu
        JOIN address a ON cu.address_id = a.address_id
        JOIN city c ON c.city_id = a.city_id
        JOIN country co ON co.country_id = c.country_id
;

/*7h. List the top five genres in gross revenue in descending order. */

describe category; #category_id
describe film_category; #category_id, film_id
describe inventory; #Film_id,inventory_id
describe rental;#rental_id, inventory_id, customer_id, staff_id
describe payment; #payment_id, customer_id, staff_id, rental_id


SELECT 
    c.name, SUM(p.amount) AS 'Total Revenue'
FROM
    category c
        JOIN
    film_category fc ON fc.category_id = c.category_id
        JOIN
    inventory i ON i.film_id = fc.film_id
        JOIN
    rental r ON r.inventory_id = i.inventory_id
        JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

 

/*8a. In your new role as an executive, you would like to have an easy way of viewing 
#the Top five genres by gross revenue. Use the solution from the problem above to create a view. 
#If you haven't solved 7h, you can substitute another query to create a view.*/

CREATE VIEW top_five_genres AS
    SELECT 
        c.name, SUM(p.amount) AS 'Total Revenue'
    FROM
        category c
            JOIN
        film_category fc ON fc.category_id = c.category_id
            JOIN
        inventory i ON i.film_id = fc.film_id
            JOIN
        rental r ON r.inventory_id = i.inventory_id
            JOIN
        payment p ON r.rental_id = p.rental_id
    GROUP BY c.name
    ORDER BY SUM(p.amount) DESC
    LIMIT 5;


/*8b. How would you display the view that you created in 8a?*/

SELECT 
    *
FROM
    Top_five_genres;

/*8c. You find that you no longer need the view top_five_genres. Write a query to delete it.*/

DROP VIEW Top_five_genres;