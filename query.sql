SELECT model, COUNT(*) AS model_count
	FROM phone
	GROUP BY model
	ORDER BY model_count DESC;

SELECT city, st AS state, COUNT(*)
	FROM phone_account
	JOIN customer ON customer.account_no = phone_account.account_no
	GROUP BY city, state
	ORDER BY COUNT(*) DESC;

SELECT plan_type, COUNT(*) AS plan_count
	FROM phone_account
	GROUP BY plan_type
	ORDER BY plan_count DESC;

WITH revenue AS (
	SELECT plan_type, SUM(amount_cents * -1 / 100.00) AS total_revenue
	FROM payment
	JOIN phone_account ON payment.phone_account_no = phone_account.account_no
	GROUP BY plan_type
),
customer_count AS (
	SELECT plan_type, count(*) AS line_count
	FROM customer
	JOIN phone_account ON customer.account_no = phone_account.account_no
	GROUP BY plan_type
)
SELECT revenue.plan_type, revenue.total_revenue::MONEY, SUM(revenue.total_revenue / line_count)::MONEY AS avg_per_customer
	FROM revenue
	JOIN customer_count ON revenue.plan_type = customer_count.plan_type
	GROUP BY revenue.plan_type, revenue.total_revenue
	ORDER BY total_revenue DESC;

SELECT
	MAX(amount / 100.00)::MONEY AS highest_spend,
	MIN(amount / 100.00)::MONEY AS lowest_spend,
	AVG(amount / 100.00)::MONEY AS average_spend
FROM (
	SELECT phone_account_no AS account_no, EXTRACT(MONTH FROM payment_date) AS month, EXTRACT(YEAR FROM payment_date) AS year, SUM(amount_cents * -1) as amount
	FROM payment
	GROUP BY account_no, month, year
	ORDER BY amount DESC
) AS month_totals;

WITH revenue AS (
	SELECT plan_type, SUM(amount_cents * -1 / 100.00) AS total_revenue
	FROM payment
	JOIN phone_account ON payment.phone_account_no = phone_account.account_no
	GROUP BY plan_type
),
customer_count AS (
	SELECT plan_type, count(*) AS line_count
	FROM customer
	JOIN phone_account ON customer.account_no = phone_account.account_no
	GROUP BY plan_type
)
SELECT revenue.plan_type, revenue.total_revenue::MONEY, SUM(revenue.total_revenue / line_count)::MONEY AS avg_per_customer
	FROM revenue
	JOIN customer_count ON revenue.plan_type = customer_count.plan_type
	GROUP BY revenue.plan_type, revenue.total_revenue
	ORDER BY total_revenue DESC;

SELECT plan_type, COUNT(*) AS plan_count
	FROM phone_account
	GROUP BY plan_type
	ORDER BY plan_count DESC;

SELECT model, COUNT(*) AS model_count
	FROM phone
	GROUP BY model
	ORDER BY model_count DESC;

SELECT city, st AS state, COUNT(*)
	FROM phone_account
	JOIN customer ON customer.account_no = phone_account.account_no
	GROUP BY city, state
	ORDER BY COUNT(*) DESC;

SELECT model, COUNT(*) AS model_count
	FROM phone
	GROUP BY model
	ORDER BY model_count DESC;

SELECT
	MAX(amount / 100.00)::MONEY AS highest_spend,
	MIN(amount / 100.00)::MONEY AS lowest_spend,
	AVG(amount / 100.00)::MONEY AS average_spend
FROM (
	SELECT phone_account_no AS account_no, EXTRACT(MONTH FROM payment_date) AS month, EXTRACT(YEAR FROM payment_date) AS year, SUM(amount_cents * -1) as amount
	FROM payment
	GROUP BY account_no, month, year
	ORDER BY amount DESC
) AS month_totals;

WITH revenue AS (
	SELECT plan_type, SUM(amount_cents * -1 / 100.00) AS total_revenue
	FROM payment
	JOIN phone_account ON payment.phone_account_no = phone_account.account_no
	GROUP BY plan_type
),
customer_count AS (
	SELECT plan_type, count(*) AS line_count
	FROM customer
	JOIN phone_account ON customer.account_no = phone_account.account_no
	GROUP BY plan_type
)
SELECT revenue.plan_type, revenue.total_revenue::MONEY, SUM(revenue.total_revenue / line_count)::MONEY AS avg_per_customer
	FROM revenue
	JOIN customer_count ON revenue.plan_type = customer_count.plan_type
	GROUP BY revenue.plan_type, revenue.total_revenue
	ORDER BY total_revenue DESC;

SELECT plan_type, COUNT(*) AS plan_count
	FROM phone_account
	GROUP BY plan_type
	ORDER BY plan_count DESC;

SELECT model, COUNT(*) AS model_count
	FROM phone
	GROUP BY model
	ORDER BY model_count DESC;

SELECT city, st AS state, COUNT(*)
	FROM phone_account
	JOIN customer ON customer.account_no = phone_account.account_no
	GROUP BY city, state
	ORDER BY COUNT(*) DESC;

SELECT
	MAX(amount / 100.00)::MONEY AS highest_spend,
	MIN(amount / 100.00)::MONEY AS lowest_spend,
	AVG(amount / 100.00)::MONEY AS average_spend
FROM (
	SELECT phone_account_no AS account_no, EXTRACT(MONTH FROM payment_date) AS month, EXTRACT(YEAR FROM payment_date) AS year, SUM(amount_cents * -1) as amount
	FROM payment
	GROUP BY account_no, month, year
	ORDER BY amount DESC
) AS month_totals;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT
	MAX(amount / 100.00)::MONEY AS highest_spend,
	MIN(amount / 100.00)::MONEY AS lowest_spend,
	AVG(amount / 100.00)::MONEY AS average_spend
FROM (
	SELECT phone_account_no AS account_no, EXTRACT(MONTH FROM payment_date) AS month, EXTRACT(YEAR FROM payment_date) AS year, SUM(amount_cents * -1) as amount
	FROM payment
	GROUP BY account_no, month, year
	ORDER BY amount DESC
) AS month_totals;

WITH revenue AS (
	SELECT plan_type, SUM(amount_cents * -1 / 100.00) AS total_revenue
	FROM payment
	JOIN phone_account ON payment.phone_account_no = phone_account.account_no
	GROUP BY plan_type
),
customer_count AS (
	SELECT plan_type, count(*) AS line_count
	FROM customer
	JOIN phone_account ON customer.account_no = phone_account.account_no
	GROUP BY plan_type
)
SELECT revenue.plan_type, revenue.total_revenue::MONEY, SUM(revenue.total_revenue / line_count)::MONEY AS avg_per_customer
	FROM revenue
	JOIN customer_count ON revenue.plan_type = customer_count.plan_type
	GROUP BY revenue.plan_type, revenue.total_revenue
	ORDER BY total_revenue DESC;

SELECT plan_type, COUNT(*) AS plan_count
	FROM phone_account
	GROUP BY plan_type
	ORDER BY plan_count DESC;

SELECT model, COUNT(*) AS model_count
	FROM phone
	GROUP BY model
	ORDER BY model_count DESC;

SELECT city, st AS state, COUNT(*)
	FROM phone_account
	JOIN customer ON customer.account_no = phone_account.account_no
	GROUP BY city, state
	ORDER BY COUNT(*) DESC;

SELECT
	MAX(amount / 100.00)::MONEY AS highest_spend,
	MIN(amount / 100.00)::MONEY AS lowest_spend,
	AVG(amount / 100.00)::MONEY AS average_spend
FROM (
	SELECT phone_account_no AS account_no, EXTRACT(MONTH FROM payment_date) AS month, EXTRACT(YEAR FROM payment_date) AS year, SUM(amount_cents * -1) as amount
	FROM payment
	GROUP BY account_no, month, year
	ORDER BY amount DESC
) AS month_totals;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT
	MAX(amount / 100.00)::MONEY AS highest_spend,
	MIN(amount / 100.00)::MONEY AS lowest_spend,
	AVG(amount / 100.00)::MONEY AS average_spend
FROM (
	SELECT phone_account_no AS account_no, EXTRACT(MONTH FROM payment_date) AS month, EXTRACT(YEAR FROM payment_date) AS year, SUM(amount_cents * -1) as amount
	FROM payment
	GROUP BY account_no, month, year
	ORDER BY amount DESC
) AS month_totals;

WITH revenue AS (
	SELECT plan_type, SUM(amount_cents * -1 / 100.00) AS total_revenue
	FROM payment
	JOIN phone_account ON payment.phone_account_no = phone_account.account_no
	GROUP BY plan_type
),
customer_count AS (
	SELECT plan_type, count(*) AS line_count
	FROM customer
	JOIN phone_account ON customer.account_no = phone_account.account_no
	GROUP BY plan_type
)
SELECT revenue.plan_type, revenue.total_revenue::MONEY, SUM(revenue.total_revenue / line_count)::MONEY AS avg_per_customer
	FROM revenue
	JOIN customer_count ON revenue.plan_type = customer_count.plan_type
	GROUP BY revenue.plan_type, revenue.total_revenue
	ORDER BY total_revenue DESC;

SELECT plan_type, COUNT(*) AS plan_count
	FROM phone_account
	GROUP BY plan_type
	ORDER BY plan_count DESC;

SELECT model, COUNT(*) AS model_count
	FROM phone
	GROUP BY model
	ORDER BY model_count DESC;

SELECT city, st AS state, COUNT(*)
	FROM phone_account
	JOIN customer ON customer.account_no = phone_account.account_no
	GROUP BY city, state
	ORDER BY COUNT(*) DESC;

WITH revenue AS (
	SELECT plan_type, SUM(amount_cents * -1 / 100.00) AS total_revenue
	FROM payment
	JOIN phone_account ON payment.phone_account_no = phone_account.account_no
	GROUP BY plan_type
),
customer_count AS (
	SELECT plan_type, count(*) AS line_count
	FROM customer
	JOIN phone_account ON customer.account_no = phone_account.account_no
	GROUP BY plan_type
)
SELECT revenue.plan_type, revenue.total_revenue::MONEY, SUM(revenue.total_revenue / line_count)::MONEY AS avg_per_customer
	FROM revenue
	JOIN customer_count ON revenue.plan_type = customer_count.plan_type
	GROUP BY revenue.plan_type, revenue.total_revenue
	ORDER BY total_revenue DESC;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT number, first_name, last_name, account_no FROM customer
JOIN phone ON customer.ssn = phone.user_ssn
WHERE UPPER(first_name) LIKE UPPER('c%');

SELECT number, first_name, last_name, account_no FROM customer
JOIN phone ON customer.ssn = phone.user_ssn
WHERE UPPER(first_name) LIKE UPPER('cf%');

SELECT number, first_name, last_name, account_no FROM customer
JOIN phone ON customer.ssn = phone.user_ssn
WHERE UPPER(first_name) LIKE UPPER('g%');

SELECT number, first_name, last_name, account_no FROM customer
JOIN phone ON customer.ssn = phone.user_ssn
WHERE UPPER(first_name) LIKE UPPER('gf%');

SELECT number, first_name, last_name, account_no FROM customer
JOIN phone ON customer.ssn = phone.user_ssn
WHERE UPPER(first_name) LIKE UPPER('j%');

SELECT number, first_name, last_name, account_no FROM customer
JOIN phone ON customer.ssn = phone.user_ssn
WHERE UPPER(first_name) LIKE UPPER('jo%');

SELECT number, first_name, last_name, account_no FROM customer
JOIN phone ON customer.ssn = phone.user_ssn
WHERE UPPER(first_name) LIKE UPPER('jos%');

SELECT number, first_name, last_name, account_no FROM customer
JOIN phone ON customer.ssn = phone.user_ssn
WHERE UPPER(first_name) LIKE UPPER('c%');

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000015'
	GROUP BY pbd, bbd;

SELECT phone_account.account_no, first_name, last_name, street_address, city, st, zip_code, plan_type, balance_cents FROM phone_account
JOIN customer ON customer.account_no = phone_account.account_no
WHERE phone_account.account_no = '10000015';

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000015'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, model, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000015'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
	FROM call
	JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE phone.number = '2498923020'
	GROUP BY call_from, call_to, minutes, Date, Time
	ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
	FROM call
	JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE phone.number = '2498923020'
	GROUP BY call_from, call_to, minutes, Date, Time
	ORDER BY date DESC, time DESC;

WITH calls AS (
	SELECT number, model, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000015'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
	FROM call
	JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE phone.number = '2498923020'
	GROUP BY call_from, call_to, minutes, Date, Time
	ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
	FROM call
	JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE phone.number = '2498923020'
	GROUP BY call_from, call_to, minutes, Date, Time
	ORDER BY date DESC, time DESC;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT
	MAX(amount / 100.00)::MONEY AS highest_spend,
	MIN(amount / 100.00)::MONEY AS lowest_spend,
	AVG(amount / 100.00)::MONEY AS average_spend
FROM (
	SELECT phone_account_no AS account_no, EXTRACT(MONTH FROM payment_date) AS month, EXTRACT(YEAR FROM payment_date) AS year, SUM(amount_cents * -1) as amount
	FROM payment
	GROUP BY account_no, month, year
	ORDER BY amount DESC
) AS month_totals;

WITH revenue AS (
	SELECT plan_type, SUM(amount_cents * -1 / 100.00) AS total_revenue
	FROM payment
	JOIN phone_account ON payment.phone_account_no = phone_account.account_no
	GROUP BY plan_type
),
customer_count AS (
	SELECT plan_type, count(*) AS line_count
	FROM customer
	JOIN phone_account ON customer.account_no = phone_account.account_no
	GROUP BY plan_type
)
SELECT revenue.plan_type, revenue.total_revenue::MONEY, SUM(revenue.total_revenue / line_count)::MONEY AS avg_per_customer
	FROM revenue
	JOIN customer_count ON revenue.plan_type = customer_count.plan_type
	GROUP BY revenue.plan_type, revenue.total_revenue
	ORDER BY total_revenue DESC;

SELECT plan_type, COUNT(*) AS plan_count
	FROM phone_account
	GROUP BY plan_type
	ORDER BY plan_count DESC;

SELECT model, COUNT(*) AS model_count
	FROM phone
	GROUP BY model
	ORDER BY model_count DESC;

SELECT city, st AS state, COUNT(*)
	FROM phone_account
	JOIN customer ON customer.account_no = phone_account.account_no
	GROUP BY city, state
	ORDER BY COUNT(*) DESC;

SELECT
	MAX(amount / 100.00)::MONEY AS highest_spend,
	MIN(amount / 100.00)::MONEY AS lowest_spend,
	AVG(amount / 100.00)::MONEY AS average_spend
FROM (
	SELECT phone_account_no AS account_no, EXTRACT(MONTH FROM payment_date) AS month, EXTRACT(YEAR FROM payment_date) AS year, SUM(amount_cents * -1) as amount
	FROM payment
	GROUP BY account_no, month, year
	ORDER BY amount DESC
) AS month_totals;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT * FROM phone ORDER BY number
LIMIT 4000;

SELECT * FROM data ORDER BY data_date DESC
LIMIT 4000;

SELECT * FROM payment_method
LIMIT 4000;

SELECT
	MAX(amount / 100.00)::MONEY AS highest_spend,
	MIN(amount / 100.00)::MONEY AS lowest_spend,
	AVG(amount / 100.00)::MONEY AS average_spend
FROM (
	SELECT phone_account_no AS account_no, EXTRACT(MONTH FROM payment_date) AS month, EXTRACT(YEAR FROM payment_date) AS year, SUM(amount_cents * -1) as amount
	FROM payment
	GROUP BY account_no, month, year
	ORDER BY amount DESC
) AS month_totals;

WITH revenue AS (
	SELECT plan_type, SUM(amount_cents * -1 / 100.00) AS total_revenue
	FROM payment
	JOIN phone_account ON payment.phone_account_no = phone_account.account_no
	GROUP BY plan_type
),
customer_count AS (
	SELECT plan_type, count(*) AS line_count
	FROM customer
	JOIN phone_account ON customer.account_no = phone_account.account_no
	GROUP BY plan_type
)
SELECT revenue.plan_type, revenue.total_revenue::MONEY, SUM(revenue.total_revenue / line_count)::MONEY AS avg_per_customer
	FROM revenue
	JOIN customer_count ON revenue.plan_type = customer_count.plan_type
	GROUP BY revenue.plan_type, revenue.total_revenue
	ORDER BY total_revenue DESC;

SELECT plan_type, COUNT(*) AS plan_count
	FROM phone_account
	GROUP BY plan_type
	ORDER BY plan_count DESC;

SELECT model, COUNT(*) AS model_count
	FROM phone
	GROUP BY model
	ORDER BY model_count DESC;

SELECT city, st AS state, COUNT(*)
	FROM phone_account
	JOIN customer ON customer.account_no = phone_account.account_no
	GROUP BY city, state
	ORDER BY COUNT(*) DESC;

