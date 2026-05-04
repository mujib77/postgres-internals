-- AGE(timestamp, timestamp) - Returns the interval between two timestamps
SELECT AGE('2024-06-01', '1990-01-01') AS age_interval;

-- AT TIME ZONE - Converts a timestamp to a different time zone
SELECT TIMESTAMP '2024-03-21 10:00:00' AT TIME ZONE 'UTC';

-- CURRENT_DATE - Returns the current date
SELECT
  name,
  date_of_birth,
  CURRENT_DATE as today,
  (CURRENT_DATE - date_of_birth) / 365 AS age
FROM
  employees
ORDER BY
  name;

-- CURRENT_TIMESTAMP - Returns the current date and time
SELECT CURRENT_TIMESTAMP AS current_time;

-- DATE_TRUNC - Truncates a date to a specified precision
SELECT DATE_TRUNC('hour', TIMESTAMP '2017-03-17 02:09:30');
SELECT DATE_TRUNC('minute', TIMESTAMP '2017-03-17 02:09:30');

-- EXAMPLE: Count rentals by month
SELECT
    DATE_TRUNC('month', rental_date) m,
    COUNT (rental_id)
FROM
    rental
GROUP BY
    m
ORDER BY
    m;

-- EXTRACT - Extracts a specific field from a date or time value
SELECT EXTRACT(YEAR FROM TIMESTAMP '2016-12-31 13:30:15') y;
SELECT EXTRACT(QUARTER FROM TIMESTAMP '2016-12-31 13:30:15') q;

-- NOW() - Returns the current date and time
SET TIMEZONE='Africa/Cairo';
SELECT NOW();