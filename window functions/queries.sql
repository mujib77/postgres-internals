-- DENSE_RANK()
SELECT
	product_id,
	product_name,
	price,
	DENSE_RANK () OVER (
		ORDER BY price DESC
	) price_rank
FROM
	products;

-- DENSE_RANK() with PARTITION BY
SELECT
	product_id,
	product_name,
	group_id,
	price,
	DENSE_RANK () OVER (
		PARTITION BY group_id
		ORDER BY price DESC
	) price_rank
FROM
	products;


-- FIRST_VALUE()
SELECT
    product_id,
    product_name,
    group_id,
    price,
    FIRST_VALUE(product_name)
    OVER(
        ORDER BY price
    ) lowest_price
FROM
    products;

-- FIRST_VALUE() with PARTITION BY
SELECT
    product_id,
    product_name,
	group_id,
    price,
    FIRST_VALUE(product_name)
    OVER(
	PARTITION BY group_id
        ORDER BY price
        RANGE BETWEEN
            UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING
    ) lowest_price
FROM
    products;    

-- LAG()
SELECT
  year,
  amount,
  LAG(amount, 1) OVER (
    ORDER BY
      year
  ) previous_year_sales
FROM
  sales
WHERE group_id = 1;

-- LAG() with PARTITION BY
SELECT
  year,
  amount,
  group_id,
  LAG(amount, 1) OVER (
    PARTITION BY group_id
    ORDER BY
      year
  ) previous_year_sales
FROM
  sales;

-- LAST_VALUE() with PARTITION BY
SELECT
    product_id,
    product_name,
    group_id,
    price,
    LAST_VALUE(product_name)
    OVER(
	PARTITION BY group_id
        ORDER BY price
        RANGE BETWEEN
            UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING
    ) highest_price
FROM
    products;

-- LEAD() with PARTITION BY
SELECT
	year,
	amount,
	group_id,
	LEAD(amount,1) OVER (
		PARTITION BY group_id
		ORDER BY year
	) next_year_sales
FROM
	sales;

-- RANK()
SELECT
	product_id,
	product_name,
	price,
	RANK () OVER (
		ORDER BY price DESC
	) price_rank
FROM
	products;

--ROW_NUMBER()
SELECT
    product_id,
    product_name,
    price,
    ROW_NUMBER () OVER (
        ORDER BY price DESC
    ) price_rank    