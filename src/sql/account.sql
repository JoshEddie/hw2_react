CREATE TABLE IF NOT EXISTS account (
    account_holder_ssn CHAR(9) PRIMARY KEY,
    plan_type BOOLEAN,
    auto_payment BOOLEAN,
    street_address VARCHAR,
    city VARCHAR,
    ST CHAR(2),
    zip_code CHAR(5)
);

INSERT INTO account VALUES
('123456789', false, true, '1234 street', 'city', 'MS', '12345'),
('987654321', false, false, '1234 headphone lane', 'music', 'TN', '23456'),
('111111111', false, true, '3380 Datebase street', 'Cosc', 'AR', '34567'),
('222222222', true, true, '3320 Algorithm', 'Cosc', 'WI', '45678'),
('333333333', false, false, '3340 Automata', 'Cosc', 'TX', '56789'),
('444444444', false, true, '2436 Data Structures', 'Cosc', 'SD', '98765'),
('555555555', true, true, '2413 Calculus', 'Math', 'TX', '87654'),
('666666666', false, false, '1437 Intro to programming', 'Cosc', 'TX', '76543'),
('777777777', false, true, '2425 Computer Architecture', 'Cosc', 'MI', '65432'),
('888888888', true, true, '3360 Operating Systems', 'Cosc', 'TX', '54321'),
('999999999', false, false, '3339 Statistics', 'Math', 'TX', '11111'),
('111222333', false, true, '2318 Linear Algebra', 'Math', 'KS', '22222'),
('444555666', true, false, '2414 Calculus', 'Math', 'TX', '33333'),
('777888999', false, true, '1336 Computer Science', 'Cosc', 'TX', '44444'),
('111444777', true, false, '3336 Discrete Math', 'Math', 'TX', '55555'),
('222555888', false, true, '4353 Software Design', 'Cosc', 'TX', '66666'),
('333666999', true, false, '4351 Software Engineering', 'Cosc', 'HI', '77777');