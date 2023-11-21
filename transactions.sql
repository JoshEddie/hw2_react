BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('2498923020', '3250672231', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000015'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('2498923020', '3206862367', 4, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 8
	WHERE account_no = '10000015'
	RETURNING balance_cents;

COMMIT;

END;

