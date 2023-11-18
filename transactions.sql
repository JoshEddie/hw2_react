BEGIN;

INSERT INTO payment (payment_date, amount_cents, account_holder_ssn)
	VALUES (DATE '2023-11-16', 1, '262291216');

UPDATE account
	SET balance_cents = balance_cents + 1
	WHERE account_ssn = '262291216'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 1
	WHERE account_ssn = '262291216'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

COMMIT;

END;

