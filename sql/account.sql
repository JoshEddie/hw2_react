CREATE TABLE IF NOT EXISTS account (
    account_holder_ssn CHAR(9) PRIMARY KEY,
    plan_type VARCHAR,
    auto_payment BOOLEAN,
    street_address VARCHAR,
    city VARCHAR,
    st CHAR(2),
    zip_code CHAR(5)
);

INSERT INTO account VALUES
('123456789', 'Internet Lover', true, '1234 street', 'city', 'MS', '12345'),
('987654321', 'Talker', false, '1234 headphone lane', 'music', 'TN', '23456'),
('111111111', 'Want it All', true, '3380 Datebase street', 'Cosc', 'AR', '34567'),
('222222222', 'Internet Lover', true, '3320 Algorithm', 'Cosc', 'WI', '45678'),
('333333333', 'Pre-Paid', false, '3340 Automata', 'Cosc', 'TX', '56789'),
('444444444', 'Talker', true, '2436 Data Structures', 'Cosc', 'SD', '98765'),
('555555555', 'Want it All', true, '2413 Calculus', 'Math', 'TX', '87654'),
('666666666', 'Internet Lover', false, '1437 Intro to programming', 'Cosc', 'TX', '76543'),
('777777777', 'Pre-Paid', true, '2425 Computer Architecture', 'Cosc', 'MI', '65432'),
('888888888', 'Internet Lover', true, '3360 Operating Systems', 'Cosc', 'TX', '54321'),
('999999999', 'Talker', false, '3339 Statistics', 'Math', 'TX', '11111'),
('111222333', 'Want it All', true, '2318 Linear Algebra', 'Math', 'KS', '22222'),
('444555666', 'Internet Lover', false, '2414 Calculus', 'Math', 'TX', '33333'),
('777888999', 'Pre-Paid', true, '1336 Computer Science', 'Cosc', 'TX', '44444'),
('111444777', 'Talker', false, '3336 Discrete Math', 'Math', 'TX', '55555'),
('222555888', 'Internet Lover', true, '4353 Software Design', 'Cosc', 'TX', '66666'),
('333666999', 'Want it All', false, '4351 Software Engineering', 'Cosc', 'HI', '77777');