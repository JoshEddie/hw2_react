BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 500
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 500
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', -500);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 551
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 551
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', -551);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + -1051
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - -1051
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', --1051);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + -2562
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - -2562
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', --2562);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + -6326
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - -6326
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', --6326);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 8888
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 8888
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', -8888);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 512
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 512
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', -512);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + -512
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - -512
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', --512);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 512
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 512
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', -512);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 800000
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 800000
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', -800000);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + -800000
	WHERE account_no = '10000053'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - -800000
	WHERE account_no = '1235267'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235267', '10000053', TIMESTAMP 'NOW()', --800000);

COMMIT;

END;

