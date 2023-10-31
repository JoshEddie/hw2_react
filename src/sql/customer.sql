CREATE TABLE IF NOT EXISTS customer (
    first_name VARCHAR,
    last_name VARCHAR,
    ssn CHAR(9) PRIMARY KEY,
    DOB CHAR(12),
    account_holder_ssn CHAR(9)
);