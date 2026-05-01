## Regular View

A view is a saved SQL query you can treat like a table.
Useful when you repeat the same complex query often.

## Materialized Views

Stores the result physically on disk.
Faster to query but data can go stale.
Need to refresh manually.

REFRESH MATERIALIZED VIEW rental_by_category;

Use When: query is slow and data doesn't change every second.