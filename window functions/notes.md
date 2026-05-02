## Window Functions

Window functions perform calculations across a set of 
rows related to the current row.

Unlike GROUP BY, they don't collapse rows.
Every row keeps its identity + gets a calculated value.

Basic syntax:
function() OVER (PARTITION BY col ORDER BY col)

PARTITION BY = divide rows into groups (like GROUP BY but rows stay)
ORDER BY     = order within each partition


## ROW_NUMBER
Assigns a unique number to each row within a partition.
No ties — every row gets a different number.

SELECT name, rating,
ROW_NUMBER() OVER (PARTITION BY rating ORDER BY name)
FROM film;


## RANK
Ranks rows within a partition.
Ties get the same rank but next rank has a gap.
Example: 1, 1, 3 (skips 2)

SELECT name, rental_rate,
RANK() OVER (PARTITION BY rating ORDER BY rental_rate DESC)
FROM film;


## DENSE_RANK
Same as RANK but no gaps.
Example: 1, 1, 2 (no skip)

Use DENSE_RANK when gaps in ranking feel wrong.


## LAG
Gets the value from the previous row.
Useful for comparing current row with previous row.

SELECT customer_id, amount,
LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date)
FROM payment;

-- shows what the customer paid last time


## LEAD
Gets the value from the next row.
Opposite of LAG.

SELECT customer_id, amount,
LEAD(amount) OVER (PARTITION BY customer_id ORDER BY payment_date)
FROM payment;

-- shows what the customer will pay next time


## FIRST_VALUE
Returns the first value in the partition.

SELECT name, rental_rate,
FIRST_VALUE(rental_rate) OVER (PARTITION BY rating ORDER BY rental_rate)
FROM film;

-- shows cheapest rental rate in each rating category


## LAST_VALUE
Returns the last value in the partition.
Needs ROWS BETWEEN fix to work correctly:

OVER (PARTITION BY rating ORDER BY rental_rate
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)

Without this it only looks at current row as the last.


## When to use what

ROW_NUMBER  → pagination, pick top N per group
RANK        → leaderboards where ties matter
DENSE_RANK  → leaderboards without gaps
LAG/LEAD    → compare with previous/next row
FIRST/LAST  → find min/max within a group per row