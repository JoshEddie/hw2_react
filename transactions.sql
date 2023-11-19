BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 355
	WHERE account_no = '10000022'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 355
	WHERE account_no = '1234864'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1234864', '10000022', TIMESTAMP 'NOW()', -355);

COMMIT;

END;

