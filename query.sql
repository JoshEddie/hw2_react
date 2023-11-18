SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment
FROM payment
WHERE account_holder_ssn = '262291216'
ORDER BY Date DESC;

SELECT * FROM account ORDER BY account_ssn
LIMIT 4000;

