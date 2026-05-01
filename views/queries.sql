-- Create View
CREATE VIEW contact AS
SELECT
  first_name,
  last_name,
  email
FROM
  customer;

-- Query the View
SELECT * FROM contact;

-- Create a view based on another view
CREATE VIEW customer_usa
AS
SELECT
  *
FROM
  customer_info
WHERE
  country = 'United States';

-- Query the new view
SELECT * FROM customer_usa;

-- Materialized View    
CREATE MATERIALIZED VIEW rental_by_category
AS
 SELECT c.name AS category,
    sum(p.amount) AS total_sales
   FROM (((((payment p
     JOIN rental r ON ((p.rental_id = r.rental_id)))
     JOIN inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN film f ON ((i.film_id = f.film_id)))
     JOIN film_category fc ON ((f.film_id = fc.film_id)))
     JOIN category c ON ((fc.category_id = c.category_id)))
  GROUP BY c.name
  ORDER BY sum(p.amount) DESC
WITH NO DATA;

-- Refresh the materialized view
REFRESH MATERIALIZED VIEW rental_by_category;