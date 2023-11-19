WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000022'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000022' AND phone.number = '2479722398'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000022'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000022' AND phone.number = '2479722398'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000022' AND phone.number = '3345410585'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000022' AND phone.number = '3345410585'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000022'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000022'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000022'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000022' AND phone.number = '2479722398'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000022' AND phone.number = '3345410585'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000022' AND phone.number = '3345410585'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000022'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000022'
ORDER BY Date DESC;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT number, first_name, last_name, account_no FROM customer
JOIN phone ON customer.ssn = phone.user_ssn
WHERE UPPER(first_name) LIKE UPPER('a%');

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

SELECT phone_account.account_no, first_name, last_name, street_address, city, st, zip_code, plan_type, balance_cents FROM phone_account
JOIN customer ON customer.account_no = phone_account.account_no
WHERE phone_account.account_no = '10000004';

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '9264556596'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT phone_account.account_no AS pan, bank_account.account_no AS ban
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pan, ban;
SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

SELECT phone_account.account_no AS pan, bank_account.account_no AS ban
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pan, ban;
SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '4612673298'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT first_name, last_name, birthday, ssn, model
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	WHERE number = '0'
	GROUP BY first_name, last_name, birthday, ssn, model;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice
FROM plan
WHERE plan_name = 'Talker';

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000004'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000004' AND phone.number = '1258777461'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice
FROM plan
WHERE plan_name = 'Talker';

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000004'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000004'
ORDER BY Date DESC;

SELECT * FROM phone_account ORDER BY account_no
LIMIT 4000;

SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice
FROM plan
WHERE plan_name = 'Internet Lover';

SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice
FROM plan
WHERE plan_name = 'Talker';

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000101'
	GROUP BY pbd, bbd;

SELECT phone_account.account_no, first_name, last_name, street_address, city, st, zip_code, plan_type, balance_cents FROM phone_account
JOIN customer ON customer.account_no = phone_account.account_no
WHERE phone_account.account_no = '10000101';

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000101'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT first_name, last_name, birthday, ssn, model
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	WHERE number = '0'
	GROUP BY first_name, last_name, birthday, ssn, model;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000101'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000101'
ORDER BY Date DESC;

SELECT phone_account.account_no AS pan, bank_account.account_no AS ban
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000101'
	GROUP BY pan, ban;
SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000101'
ORDER BY Date DESC;

SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice
FROM plan
WHERE plan_name = 'Talker';

SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice
FROM plan
WHERE plan_name = 'Talker';

SELECT phone_account.account_no, first_name, last_name, street_address, city, st, zip_code, plan_type, balance_cents FROM phone_account
JOIN customer ON customer.account_no = phone_account.account_no
WHERE phone_account.account_no = '10000101';

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice
FROM plan
WHERE plan_name = 'Talker';

SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice
FROM plan
WHERE plan_name = 'Talker';

SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice
FROM plan
WHERE plan_name = 'Talker';

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000101'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000101'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
FROM call
JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY call_from, call_to, minutes, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000101'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000101'
ORDER BY Date DESC;

SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice
FROM plan
WHERE plan_name = 'Talker';

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT first_name, last_name, birthday, ssn, model
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	WHERE number = '3590991351'
	GROUP BY first_name, last_name, birthday, ssn, model;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT first_name, last_name, birthday, ssn, model
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	WHERE number = '6085263301'
	GROUP BY first_name, last_name, birthday, ssn, model;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '6085263301'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
	FROM phone_account
	JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
	JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
	WHERE phone_account.account_no = '10000101'
	GROUP BY pbd, bbd;

SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE phone_account_no = '10000101'
ORDER BY Date DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

WITH calls AS (
	SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
	FROM customer
	JOIN phone ON customer.ssn = phone.user_ssn
	LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
	WHERE account_no = '10000101'
	GROUP BY number, first_name, last_name
),
dataUsed AS (
	SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
	FROM data
	GROUP BY phone_number
)
SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
FROM calls
LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
JOIN phone_model ON calls.number = phone_model.phone_number;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
FROM data
JOIN phone ON phone.number = data.phone_number
JOIN customer ON customer.ssn = phone.user_ssn
WHERE customer.account_no = '10000101' AND phone.number = '3590991351'
GROUP BY phone_number, mb_used, Date, Time
ORDER BY date DESC, time DESC;

