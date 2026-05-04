## Date/Time Functions

PostgreSQL has powerful date/time functions for working
with timestamps, intervals, and time zones.

Most important ones for analytics and real world apps.


## CURRENT_DATE / CURRENT_TIMESTAMP / NOW()

CURRENT_DATE      → returns today's date (no time)
CURRENT_TIMESTAMP → returns date + time + timezone
NOW()             → same as CURRENT_TIMESTAMP

SELECT CURRENT_DATE;
-- 2024-05-02

SELECT NOW();
-- 2024-05-02 10:32:00+05:30

Use NOW() when you need exact moment of time.
Use CURRENT_DATE when you only care about the date.


## EXTRACT

Pulls out a specific part from a date/timestamp.

EXTRACT(part FROM date)

Parts: year, month, day, hour, minute, second, dow, week

SELECT EXTRACT(year FROM payment_date) FROM payment;
SELECT EXTRACT(month FROM payment_date) FROM payment;
SELECT EXTRACT(dow FROM payment_date) FROM payment;
-- dow = day of week (0=Sunday, 6=Saturday)

Use when you need just one piece of a date.


## DATE_TRUNC

Truncates a timestamp to a specified level.
Chops off everything below that level and resets to zero.

DATE_TRUNC('level', timestamp)

SELECT DATE_TRUNC('month', payment_date) FROM payment;
-- 2024-03-15 14:32:00 → 2024-03-01 00:00:00

Levels: year, month, week, day, hour, minute, second

-- payments grouped by month
SELECT DATE_TRUNC('month', payment_date), COUNT(*)
FROM payment
GROUP BY DATE_TRUNC('month', payment_date)
ORDER BY 1;

Most used date function in analytics.
Think of it as "round down to nearest month/day/hour".


## DATE_PART

Same as EXTRACT, just different syntax.

DATE_PART('month', payment_date)
= EXTRACT(month FROM payment_date)

Both return the same result.
EXTRACT is the SQL standard, DATE_PART is Postgres specific.
Use whichever feels readable.


## AGE

Calculates difference between two dates in human readable form.

AGE(timestamp1, timestamp2)
AGE(timestamp)  → difference from NOW()

SELECT AGE(NOW(), payment_date) FROM payment;
-- 1 year 3 months 12 days

SELECT AGE('2024-01-01') FROM payment;
-- time since Jan 1 2024

Use when you want human readable time difference.


## AT TIME ZONE

Converts a timestamp to a different timezone.

SELECT NOW() AT TIME ZONE 'UTC';
SELECT NOW() AT TIME ZONE 'America/New_York';
SELECT NOW() AT TIME ZONE 'Asia/Kolkata';

Important for apps with users across different timezones.
Always store timestamps in UTC, convert on display.


## Intervals

Intervals represent a duration of time.
Use for adding/subtracting time from dates.

SELECT NOW() + INTERVAL '7 days';
SELECT NOW() - INTERVAL '1 month';
SELECT NOW() + INTERVAL '2 hours 30 minutes';

-- payments in last 7 days
SELECT * FROM payment
WHERE payment_date > NOW() - INTERVAL '7 days';

-- payments in last 30 days
SELECT * FROM payment
WHERE payment_date > NOW() - INTERVAL '30 days';


## Real World Patterns

-- messages per day (Discord bot will use this)
SELECT DATE_TRUNC('day', created_at), COUNT(*)
FROM messages
GROUP BY 1
ORDER BY 1;

-- most active hour of day
SELECT EXTRACT(hour FROM created_at), COUNT(*)
FROM messages
GROUP BY 1
ORDER BY 2 DESC;

-- records from this month only
SELECT * FROM payment
WHERE DATE_TRUNC('month', payment_date) 
    = DATE_TRUNC('month', NOW());