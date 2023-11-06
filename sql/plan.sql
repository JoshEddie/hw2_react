CREATE TABLE IF NOT EXISTS plan (
    plan_name VARCHAR PRIMARY KEY,
      REAL,
    data_price REAL,
    pre_paid BOOLEAN
);

INSERT into plan VALUES
('Internet Lover', 0.3, 0.01, false),
('Talker', 0.1, 0.03, false),
('Want it All', 0.2, 0.02, false),
('Pre-Paid', 0.4, 0.04, true);