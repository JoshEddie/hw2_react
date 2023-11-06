CREATE TABLE call (
    call_id SERIAL PRIMARY KEY,
    call_from CHAR(10),
    call_to CHAR(10),
    call_length_mins INT,
    call_date DATE
);

CREATE TABLE data (
    data_id SERIAL PRIMARY KEY,
    phone_number CHAR(10),
    mb_used REAL,
    data_date DATE
);

CREATE TABLE phone_model (
    phone_number CHAR(10) PRIMARY KEY,
    model VARCHAR
);

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    payment_date DATE,
    amount REAL,
    account_holder_ssn CHAR(9)
);