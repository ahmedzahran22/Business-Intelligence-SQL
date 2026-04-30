-- Total Revenue
SELECT SUM(amount) AS total_revenue
FROM payment;

-- Revenue by Category
SELECT c.name AS category, SUM(p.amount) AS revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY revenue DESC;

-- Revenue by Film
SELECT f.title, SUM(p.amount) AS revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY revenue DESC;

-- Monthly Revenue
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS revenue
FROM payment
GROUP BY month
ORDER BY month;

-- Month over Month Growth
SELECT month,
       revenue,
       LAG(revenue) OVER (ORDER BY month) AS last_month,
       (revenue - LAG(revenue) OVER (ORDER BY month)) /
       LAG(revenue) OVER (ORDER BY month) AS growth
FROM (
    SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
           SUM(amount) AS revenue
    FROM payment
    GROUP BY month
) t;

-- Daily Revenue
SELECT DATE(payment_date) AS day,
       SUM(amount) AS revenue
FROM payment
GROUP BY day;

-- Top 10 Customers by Total Spending
SELECT customer_id,
       SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Customer Segmentation by Spending
SELECT customer_id,
       SUM(amount) AS total_spent,
       CASE
           WHEN SUM(amount) > 150 THEN 'High Value'
           WHEN SUM(amount) BETWEEN 50 AND 150 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS segment
FROM payment
GROUP BY customer_id;

-- Number of Transactions per Customer
SELECT customer_id,
       COUNT(*) AS transactions
FROM payment
GROUP BY customer_id;

-- Revenue by Store
SELECT s.store_id, SUM(p.amount) AS revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- Staff Performance
SELECT staff_id,
       COUNT(*) AS transactions,
       SUM(amount) AS revenue
FROM payment
GROUP BY staff_id;

-- Revenue by Country
SELECT co.country,
       SUM(p.amount) AS revenue
FROM payment p
JOIN customer cu ON p.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country
ORDER BY revenue DESC;

-- Revenue by City
SELECT ci.city,
       SUM(p.amount) AS revenue
FROM payment p
JOIN customer cu ON p.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
GROUP BY ci.city;

-- Most Rented Movies
SELECT f.title,
       COUNT(*) AS rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title;

-- Average Revenue per Film + Rentals Count
SELECT f.title,
       AVG(p.amount) AS avg_revenue,
       COUNT(r.rental_id) AS rentals
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rentals DESC;

-- Average Revenue per Film
SELECT f.title,
       AVG(p.amount) AS avg_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title;

-- Movie Revenue Ranking
SELECT title,
       revenue,
       RANK() OVER (ORDER BY revenue DESC) AS rank_num
FROM (
    SELECT f.title,
           SUM(p.amount) AS revenue
    FROM payment p
    JOIN rental r ON p.rental_id = r.rental_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    GROUP BY f.title
) t;

-- Top Category per Month
SELECT *
FROM (
    SELECT DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
           c.name AS category,
           SUM(p.amount) AS revenue,
           RANK() OVER (
               PARTITION BY DATE_FORMAT(p.payment_date, '%Y-%m')
               ORDER BY SUM(p.amount) DESC
           ) AS rnk
    FROM payment p
    JOIN rental r ON p.rental_id = r.rental_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY month, c.name
) t
WHERE rnk = 1;


