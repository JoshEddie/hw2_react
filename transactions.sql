BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3345410585', 1.0625780262803375, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 0
	WHERE account_no = '10000022'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3345410585', 2.1500778604257875, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000022'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '8662461357', 3, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 12
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '8047411557', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '8584865688', 4, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 16
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '6765008273', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '7042567691', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '9861220821', 2, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 8
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '2761157187', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '6754187221', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '6787731933', 2, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 8
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '2115099913', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '2033170575', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '7847557250', 4, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 16
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 19.962456219503654, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 19
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 1.5287467043521992, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 1.0219832774973154, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 1.1750195775059316, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 3.9630604523534623, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 3
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 2.1336402503535714, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 1.8959285498532783, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 2.811875381552162, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 4.4354674347155525, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 1.1849458924056744, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 1.3119086959036381, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 1.5388095480525121, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 2.8603985543924404, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 1.6875218944502777, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 1.3180197553440312, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 2.4425566763378246, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + -3432
	WHERE account_no = '10000004'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - -3432
	WHERE account_no = '1234630'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1234630', '10000004', TIMESTAMP 'NOW()', --3432);

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('4612673298', '4375748673', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 4000
	WHERE account_no = '10000004'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 4000
	WHERE account_no = '1234630'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1234630', '10000004', TIMESTAMP 'NOW()', -4000);

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + -3996
	WHERE account_no = '10000004'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - -3996
	WHERE account_no = '1234630'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1234630', '10000004', TIMESTAMP 'NOW()', --3996);

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('4612673298', 1.8406061038657147, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 4000
	WHERE account_no = '10000004'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 4000
	WHERE account_no = '1234630'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1234630', '10000004', TIMESTAMP 'NOW()', -4000);

COMMIT;

END;

BEGIN;

INSERT INTO customer
	VALUES ('ssn', 'accountNo', 'firstName', 'lastName', dob);

INSERT INTO phone
	VALUES('phone_number', 'ssn', 'phoneModel');

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('1258777461', '1658925585', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('1258777461', '6759245606', 4, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 16
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('1258777461', '2316502935', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('1258777461', '5706145728', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('1258777461', 19.777413504806894, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 19
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('1258777461', 7.437218491019134, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 7
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('1258777461', 1.286604127129205, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('1258777461', 33.12116471739581, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 33
	WHERE account_no = '10000004'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO phone_account VALUES
	(nextval('phone_account_no_sequence'), 'Talker', 'false', '1234 Test Ln', 'Testing', 'TX', '12345')
RETURNING account_no;

INSERT INTO bank_account VALUES
	(nextval('bank_account_no_sequence'), 50978);

INSERT INTO customer VALUES
	('444444444', currval('phone_account_no_sequence'), 'Josh', 'Eddie', '11/04/2013');

INSERT INTO phone VALUES
	('3590991351', '444444444', 'iPhone 15 Pro');

INSERT INTO payment_method VALUES
	(currval('bank_account_no_sequence'), currval('phone_account_no_sequence'));

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES (currval('bank_account_no_sequence'), currval('phone_account_no_sequence'), NOW(), -3500);

COMMIT;

END;

BEGIN;

INSERT INTO customer
	VALUES ('ssn', 'accountNo', 'firstName', 'lastName', dob);

INSERT INTO phone
	VALUES('phone_number', 'ssn', 'phoneModel');

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('3590991351', '3789176635', 5, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 5
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('6085263301', '6726173024', 7, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 7
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.902452641098523, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 1.0515860771486913, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 0
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 12.67671003547872, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 11
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 2.7132533061799045, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 2.1278736450603675, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 9.108459726426975, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 8
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 1.3883986068655192, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 2.050242557057503, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 1.0885613849557283, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 0
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 475.5242125469376, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 427
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 4.9269881624734655, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 1.1160812669465747, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('6085263301', 1.4824506931594756, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('6085263301', '3559613782', 3, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 3
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('6085263301', '1531135217', 13, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 13
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('6085263301', '4045475807', 4, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 4
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('6085263301', '8527130985', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('6085263301', '8187378446', 1, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('6085263301', '7697982653', 2, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 494
	WHERE account_no = '10000101'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 494
	WHERE account_no = '1235891'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235891', '10000101', TIMESTAMP 'NOW()', -494);

COMMIT;

END;

BEGIN;

INSERT INTO call (call_from, call_to, call_length_mins, call_date)
	VALUES ('3590991351', '3984805155', 2, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 8
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

UPDATE phone_account
	SET balance_cents = balance_cents + 4000
	WHERE account_no = '10000101'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

UPDATE bank_account
	SET balance_cents = balance_cents - 4000
	WHERE account_no = '1235891'
	RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
	VALUES ('1235891', '10000101', TIMESTAMP 'NOW()', -4000);

COMMIT;

END;

BEGIN;

UPDATE customer
	SET first_name = 'Josh',
	last_name = 'Eddie',
	WHERE ssn = '444444444';

UPDATE phone
	SET model = 'iPhone 15 Pro Max'
	WHERE user_ssn = '444444444';

COMMIT;

END;

BEGIN;

UPDATE customer
	SET first_name = 'Brandy',
	last_name = 'Eddie',
	WHERE ssn = '888888888';

UPDATE phone
	SET model = 'Galaxy S23+'
	WHERE user_ssn = '888888888';

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.5947075622116424, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.1227566283330908, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 2.9242169473263875, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.0948395046406558, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 42.24197103094247, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 42
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.1580638641421206, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 2.187610198612635, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 5.331353466254809, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 5
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.0252373881822119, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 3.425675299856628, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 3
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 8.66214166274763, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 8
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.8894283476926568, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 2.2666615599852094, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.1051738047636792, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 7.783447854881529, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 7
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 3.47043477839583, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 3
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.2488395904218756, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.3144490142756953, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.8237686598466876, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 3.6236870360948092, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 3
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.0338278178285252, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 2.478731045145744, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 2
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.2718954014449995, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.358820648538559, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 33.25378824589853, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 33
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.3425427124365379, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.5693267890305909, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.094240554429641, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.5249636574632746, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.8797430690926402, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.8199828755794827, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.5372830199517602, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.83888826254768, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 3.893952664771489, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 3
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.8344947010197876, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.912527296170468, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 1.7584090017183343, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 1
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

BEGIN;

INSERT INTO data (phone_number, mb_used, data_date)
	VALUES ('3590991351', 7.0071604086083035, NOW());

UPDATE phone_account
	SET balance_cents = balance_cents - 7
	WHERE account_no = '10000101'
	RETURNING balance_cents;

COMMIT;

END;

