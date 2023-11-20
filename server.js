const list = require('./src/lists.js');

const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3002;

var fs = require("fs");
var transactionSQL = fs.createWriteStream("transactions.sql");
var querySQL = fs.createWriteStream("query.sql");
transactionSQL = fs.createWriteStream("transactions.sql", {flags:'a'});
querySQL = fs.createWriteStream("query.sql", {flags:'a'});

const creds = require('./creds.json');
const { queries } = require('@testing-library/react');
const pool = new Pool(creds);

app.use(express.json())
app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Access-Control-Allow-Headers');
  next();
});

function generateNumber(max) { //Used to generate random phone numbers and ssn
    
    let retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
        try {
            let number = Math.round(Math.random() * (9 - 1) + 1).toString();
            for(let i = 1; i < max; i++) {
                number += Math.round(Math.random() * 9).toString()
            }
            return number;
        } catch (err) {
            retryCount++;
        }
    }

}

function randomName() {
    return list.names[Math.round(Math.random() * list.names.length)]
}

function randomStreetName() {
    let retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
        try {
            let address = (generateNumber(Math.round(Math.random() * (5 - 3) + 3)) 
                        + " " + list.street_names[Math.round(Math.random() * list.street_names.length)]
                        + " " + list.street_suffix[Math.round(Math.random() * list.street_suffix.length)]);
            return address;
        } catch (err) {
            retryCount++;
        }
    }

}

function randomBirthday() {

    let retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
        try {
            let birthday = (Math.round(Math.random() * (2005 - 1963 + 1) + 1963).toString()
                        + '-' + Math.round(Math.random() * (12 - 1) + 1).toString().padStart(2, '0')
                        + '-' + Math.round(Math.random() * (28 - 1) + 1).toString().padStart(2, '0'));
            return birthday;
        } catch (err) {
            retryCount++;
        }
    }

}

async function payment(paymentAmmount, phone_account_no, bank_account_no, dateTime, writeToFile, response) {

    let negPaymentAmmount = Number(paymentAmmount) * -1;

    try {

        await pool.query(`

            BEGIN;

            UPDATE phone_account
                SET balance_cents = balance_cents + ${paymentAmmount}
                WHERE account_no = '${phone_account_no}'
                RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

            UPDATE bank_account
                SET balance_cents = balance_cents + ${negPaymentAmmount}
                WHERE account_no = '${bank_account_no}'
                RETURNING (balance_cents / 100.00)::MONEY as balancedollar;

            INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
                VALUES ('${bank_account_no}', '${phone_account_no}', TIMESTAMP '${dateTime}', ${negPaymentAmmount});

            COMMIT;

            END;

        `)
        .then(function (result) {

            if(writeToFile) {
                transactionSQL.write(`BEGIN;\n\n`);
                transactionSQL.write(`UPDATE phone_account\n`);
                transactionSQL.write(`\tSET balance_cents = balance_cents + ${paymentAmmount}\n`);
                transactionSQL.write(`\tWHERE account_no = '${phone_account_no}'\n`);
                transactionSQL.write(`\tRETURNING (balance_cents / 100.00)::MONEY as balancedollar;\n\n`);
                transactionSQL.write(`UPDATE bank_account\n`);
                transactionSQL.write(`\tSET balance_cents = balance_cents - ${paymentAmmount}\n`);
                transactionSQL.write(`\tWHERE account_no = '${bank_account_no}'\n`);
                transactionSQL.write(`\tRETURNING (balance_cents / 100.00)::MONEY as balancedollar;\n\n`);
                transactionSQL.write(`INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)\n`);
                transactionSQL.write(`\tVALUES ('${bank_account_no}', '${phone_account_no}', TIMESTAMP '${dateTime}', -${paymentAmmount});\n\n`);
                transactionSQL.write(`COMMIT;\n\n`);
                transactionSQL.write(`END;\n\n`);
            }

            console.log("Balance result: " + [result[1].rows[0].balancedollar, result[2].rows[0].balancedollar])
            if(response != '') {
                response.send([result[1].rows[0].balancedollar, result[2].rows[0].balancedollar]);
            }
            return ([result[1].rows[0].balancedollar, result[2].rows[0].balancedollar])

        });

    } catch (err) {

        await pool.query(`ROLLBACK;`);
        console.log("Payment Failed " + err);

    }

}

app.get('/', async (req, res) => {
    
    res.send(`
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Server</title>
        </head>
        <body>
            <div>
                <h3>Server Running on http://localhost:${port}, please start React App.</h3>
            </div>
        </body>
        </html>
    `);
    
});

app.get('/api/droptables', async (req, res) => {

    try {
        await pool.query(`DROP TABLE IF EXISTS payment_method`);
        await pool.query(`DROP TABLE IF EXISTS payment`);
        await pool.query(`DROP TABLE IF EXISTS bank_account`);
        await pool.query(`DROP TABLE IF EXISTS call`);
        await pool.query(`DROP TABLE IF EXISTS data`);
        await pool.query(`DROP TABLE IF EXISTS phone`);
        await pool.query(`DROP TABLE IF EXISTS customer`);
        await pool.query(`DROP TABLE IF EXISTS phone_account`);
        await pool.query(`DROP TABLE IF EXISTS plan`);
        await pool.query(`DROP SEQUENCE IF EXISTS phone_account_no_sequence`);
        await pool.query(`DROP SEQUENCE IF EXISTS bank_account_no_sequence`);
        res.send("tables dropped")
    }
    catch (err) {
        console.log(err)
        res.send('error')
        return;
    }
    return;
})

app.get('/api/intializeDatabase', async (req, res) => {

    //Create Tables if they don't exist

    console.log("Intializing tables")

    try {
        await pool.query(`DROP TABLE IF EXISTS payment_method`);
        await pool.query(`DROP TABLE IF EXISTS payment`);
        await pool.query(`DROP TABLE IF EXISTS bank_account`);
        await pool.query(`DROP TABLE IF EXISTS call`);
        await pool.query(`DROP TABLE IF EXISTS data`);
        await pool.query(`DROP TABLE IF EXISTS phone`);
        await pool.query(`DROP TABLE IF EXISTS customer`);
        await pool.query(`DROP TABLE IF EXISTS phone_account`);
        await pool.query(`DROP TABLE IF EXISTS plan`);
        await pool.query(`DROP SEQUENCE IF EXISTS phone_account_no_sequence`);
        await pool.query(`DROP SEQUENCE IF EXISTS bank_account_no_sequence`);
        }
    catch (err) {
        return;
    }

    try {

        await pool.query(`
            CREATE TABLE IF NOT EXISTS plan (
                plan_name VARCHAR PRIMARY KEY,
                call_price_cents BIGINT NOT NULL,
                data_price_cents BIGINT NOT NULL,
                pre_paid BOOLEAN NOT NULL
            );
        `)

        await pool.query(`        
            INSERT into plan VALUES
            ('Internet Lover', 3, 700, false),
            ('Talker', 1, 900, false),
            ('Want it All', 2, 800, false),
            ('Pre-Paid', 4, 1000, true);
        `)

        await pool.query(`

            CREATE SEQUENCE phone_account_no_sequence
                start 10000000
                increment 1;

            CREATE TABLE IF NOT EXISTS phone_account (
                account_no SERIAL PRIMARY KEY,
                plan_type VARCHAR NOT NULL CHECK (plan_type <> '') REFERENCES plan(plan_name),
                auto_payment BOOLEAN NOT NULL,
                street_address VARCHAR NOT NULL CHECK (street_address <> ''),
                city VARCHAR NOT NULL CHECK (city <> ''),
                st CHAR(2) NOT NULL,
                zip_code CHAR(5) NOT NULL,
                balance_cents BIGINT DEFAULT 0
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS customer (
                ssn CHAR(9) PRIMARY KEY,
                account_no INT NOT NULL REFERENCES phone_account(account_no),
                first_name VARCHAR NOT NULL CHECK (first_name <> ''),
                last_name VARCHAR NOT NULL CHECK (last_name <> ''),
                birthday DATE NOT NULL
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS phone (
                number CHAR(10) PRIMARY KEY,
                user_ssn CHAR(9) NOT NULL REFERENCES customer(ssn),
                model VARCHAR NOT NULL CHECK (model <> '')
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS call (
                call_id SERIAL PRIMARY KEY,
                call_from CHAR(10) REFERENCES phone(number),
                call_to CHAR(10),
                call_length_mins INT,
                call_date TIMESTAMP
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS data (
                data_id SERIAL PRIMARY KEY,
                phone_number CHAR(10) REFERENCES phone(number),
                mb_used DECIMAL,
                data_date TIMESTAMP
            );
        `)

        await pool.query(`
            CREATE SEQUENCE bank_account_no_sequence
                start 1234578
                increment 13;

            CREATE TABLE IF NOT EXISTS bank_account (
                account_no SERIAL PRIMARY KEY,
                balance_cents BIGINT DEFAULT 0
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS payment (
                payment_id SERIAL PRIMARY KEY,
                phone_account_no INT NOT NULL REFERENCES phone_account(account_no),
                bank_account_no INT NOT NULL REFERENCES bank_account(account_no),
                payment_date TIMESTAMP NOT NULL,
                amount_cents BIGINT NOT NULL
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS payment_method (
                bank_account_no INT NOT NULL PRIMARY KEY,
                phone_account_no INT NOT NULL REFERENCES phone_account(account_no)
            );
        `)

    } catch (err) {
        console.log("Error 1: " + err.message)
    };

    console.log("Tables intialized")

    try {
        
        const accountCount = await pool.query(`
            SELECT COUNT(*) FROM phone_account;
        `)

        if (accountCount.rows[0].count == '0') {

            console.log("Intializing Accounts")

            for (let i = 0; i < 100; i++) {

                try {

                    const ssn = generateNumber(9)

                    await pool.query(`

                        BEGIN;
                    
                        INSERT INTO phone_account (account_no, plan_type, auto_payment, street_address, city, st, zip_code)
                        VALUES (
                            nextval('phone_account_no_sequence'),
                            '${list.planTypes[Math.round(Math.random() * (list.planTypes.length - 1))]}',
                            '${Math.round(Math.random()).toString()}',
                            '${randomStreetName()}',
                            '${list.city_names[Math.round(Math.random() * (list.city_names.length - 1))]}',
                            '${list.state_names[Math.round(Math.random() * (list.state_names.length - 1))]}',
                            '${generateNumber(5)}'
                        );

                        INSERT INTO bank_account 
                        VALUES(
                            nextval('bank_account_no_sequence'),
                            ${Number(generateNumber(5)) + 10000}
                        );

                        INSERT INTO customer VALUES
                            ('${ssn}',
                            currval('phone_account_no_sequence'),
                            '${randomName()}',
                            '${randomName()}',
                            '${randomBirthday()}');

                        INSERT INTO phone
                        VALUES (
                            '${generateNumber(10)}',
                            '${ssn}',
                            '${list.phone_models[Math.round(Math.random() * (list.phone_models.length - 1))]}'
                        );

                        INSERT INTO payment_method
                            VALUES(currval('bank_account_no_sequence'), currval('phone_account_no_sequence'));

                        INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
                            VALUES (currval('bank_account_no_sequence'), currval('phone_account_no_sequence'), NOW(), -3500);

                        COMMIT;

                        END;

                    `);



                } catch (err) {

                    await pool.query('ROLLBACK');
                    console.log("Error 2: " + err)
                    i--;

                }

            }

            console.log("Accounts intialized")
            console.log("Intializing Customers")

            for (let i = 0; i < 200; i++) {

                const accounts = await pool.query(`
                    SELECT account_no FROM phone_account;
                `)

                const ssn = generateNumber(9);
            
                try {
                    await pool.query(`

                        BEGIN;

                        INSERT INTO customer VALUES
                            ('${ssn}',
                            '${accounts.rows[Math.round(Math.random() * (accounts.rows.length - 1))].account_no}',
                            '${randomName()}',
                            '${randomName()}',
                            '${randomBirthday()}');

                        INSERT INTO phone
                        VALUES (
                            '${generateNumber(10)}',
                            '${ssn}',
                            '${list.phone_models[Math.round(Math.random() * (list.phone_models.length - 1))]}'
                        );

                        COMMIT;

                        END;

                    `);

                }
                catch (err) {
                    await pool.query('ROLLBACK');
                    console.log("Error 3: " + err.message);
                    i--;
                }

            }

            console.log("Customers intialized")

        }

        res.send(`
            Accounts & Customers Intialized.
        `);

    } catch (err) {

        return;

    }

})

app.get("/api/intializeCallsData/:month", async(req, res) => {

    try {

        const month = req.params.month;

        const phoneNumbers = await pool.query(`
            SELECT number FROM phone;
        `)

        for(let i = 0; i < phoneNumbers.rows.length; i++) {

            const account_info = await pool.query(`
                SELECT bank_account.account_no AS ban, phone_account.account_no AS pan, plan_type
                FROM bank_account
                JOIN payment_method ON bank_account.account_no = payment_method.bank_account_no
                JOIN phone_account ON phone_account.account_no = payment_method.phone_account_no
                JOIN customer ON phone_account.account_no = customer.account_no
                JOIN phone ON phone.user_ssn = customer.ssn
                WHERE phone.number = '${phoneNumbers.rows[i].number}'
                GROUP BY bank_account.account_no, phone_account.account_no, phone_account.plan_type;
            `)
            
            const prices = await pool.query(`
                SELECT call_price_cents, data_price_cents FROM plan
                WHERE plan_name = '${account_info.rows[0].plan_type}';
            `)

            for(let call_number = 0; call_number < Math.round(Math.random() * 50 + 1); call_number++) {
                
                var call_length = Math.round(360 / (Math.random() * 360 + 1))

                var day = (Math.round(Math.random() * (28 - 1) + 1)).toString().padStart(2, '0');
                var hour = (Math.round(Math.random() * (23 - 1) + 1)).toString().padStart(2, '0');
                var minute = (Math.round(Math.random() * 59)).toString().padStart(2, '0');
                var second = (Math.round(Math.random() * 59)).toString().padStart(2, '0');

                var phone_to = 0;

                do {
                    phone_to = Math.round(Math.random() * (phoneNumbers.rows.length - 1));
                } while(i === phone_to);

                let date = "2023-" + month.toString().padStart(2, '0') + "-" + day;
                let time = hour + ":" + minute + ":" + second;
                let call_cost = call_length * Number(prices.rows[0].call_price_cents);

                try {

                    await pool.query(`
                        BEGIN;

                        INSERT INTO call (call_from, call_to, call_length_mins, call_date)
                            VALUES ('${phoneNumbers.rows[i].number}', '${phoneNumbers.rows[phone_to].number}', ${call_length}, TIMESTAMP '${date} ${time}');

                        UPDATE phone_account
                            SET balance_cents = balance_cents - ${call_cost}
                            WHERE account_no = '${account_info.rows[0].pan}'
                            RETURNING balance_cents;

                        COMMIT;

                        END;

                    `)
                    .then(function (result) {

                        if(account_info.rows[0].plan_type == 'Pre-Paid' && result[2].rows[0].balance_cents < 0) {

                            payment(4000, account_info.rows[0].pan, account_info.rows[0].ban, date + " " + time, false, '');

                        }

                    });

                }
                catch (err) {
                    await pool.query(`ROLLBACK`);
                    console.log("Error 4: " + err.message)
                }

            }

            for(let data_use = 0; data_use < Math.round(Math.random() * 50 + 1); data_use++) {

                var mb_used = Math.floor(500 / (Math.random() * 500 + 1)) + Math.random();
                var day = (Math.round(Math.random() * (28 - 1) + 1)).toString().padStart(2, '0');
                var hour = (Math.round(Math.random() * (23 - 1) + 1)).toString().padStart(2, '0');
                var minute = (Math.round(Math.random() * 59)).toString().padStart(2, '0');
                var second = (Math.round(Math.random() * 59)).toString().padStart(2, '0');

                let date = "2023-" + month.toString().padStart(2, '0') + "-" + day;
                let time = hour + ":" + minute + ":" + second;

                let data_cost = Math.floor((mb_used / 1000) * Number(prices.rows[0].data_price_cents));

                try {

                    await pool.query(`
                        BEGIN;

                        INSERT INTO data (phone_number, mb_used, data_date)
                            VALUES ('${phoneNumbers.rows[i].number}', ${mb_used}, TIMESTAMP '${date} ${time}');

                        UPDATE phone_account
                            SET balance_cents = balance_cents - ${data_cost}
                            WHERE account_no = '${account_info.rows[0].pan}'
                            RETURNING balance_cents;

                        COMMIT;

                        END;

                    `)
                    .then(async function (result) {

                        if(account_info.rows[0].plan_type == 'Pre-Paid' && result[2].rows[0].balance_cents < 0) {

                            payment(4000, account_info.rows[0].pan, account_info.rows[0].ban, date + " " + time, false, '');

                        }

                    });

                }
                catch (err) {
                    await pool.query(`ROLLBACK`);
                    console.log("Error 5: " + err.message)
                }

            }

        }

        if (month != 10) {

            const account_info = await pool.query(`
                SELECT phone_account.account_no AS pan, bank_account.account_no AS ban, phone_account.balance_cents AS balance, plan_type FROM phone_account
                JOIN payment_method ON phone_account.account_no = phone_account_no
                JOIN bank_account ON bank_account.account_no = bank_account_no
                GROUP BY phone_account.account_no, bank_account.account_no, phone_account.balance_cents, plan_type;
            `);
            

            for (let i = 0; i < account_info.rows.length; i++) {

                try {

                    let date = "2023-" + month.toString().padStart(2, '0') + "-28";
                    var day = (Math.round(Math.random() * (28 - 1) + 1)).toString().padStart(2, '0');
                    var hour = (Math.round(Math.random() * (23 - 1) + 1)).toString().padStart(2, '0');
                    var minute = (Math.round(Math.random() * 59)).toString().padStart(2, '0');
                    var second = (Math.round(Math.random() * 59)).toString().padStart(2, '0');

                    let time = hour + ":" + minute + ":" + second;

                    if(account_info.rows[i].balance < 0 && account_info.rows[i].plan_type != 'Pre-Paid') {
                        payment(Number(account_info.rows[i].balance) * -1, account_info.rows[i].pan, account_info.rows[i].ban, date + " " + time, false, '');
                    }

                }
                catch (err) {
                    console.log("Error 7: " + err.message)
                }

            }
        }

        console.log("Calls & Data Uses for " + month + "/2023 intialized")

        res.send(`
            Calls & Data Uses for ${month}/2023 intialized
        `);
        
    } catch (err) {
        return;
    }

})

app.get("/api/getTable", async(req, res) => {

    try {
        const table = req.query.table;
        const order = req.query.order;

        await pool.query(`
            SELECT * FROM ${table}${order}
                LIMIT 4000;
        `)
        .then(result => {

            querySQL.write(`SELECT * FROM ${table}${order}\n`);
            querySQL.write(`LIMIT 4000;\n\n`);

            if (result.rows.length < 1) {
                res.send({name: "No results"})
                return;
            }
            
            res.send(result.rows)

        });
        
    }
    catch (err) {
        console.log(err)
        res.send(err)
    }

});

app.get("/api/delete/:table", async(req, res) => {

    try {
        const table = req.params.table;
        await pool.query(`DELETE FROM ${table};`);
        querySQL.write(`DELETE FROM ${table};\n\n`);
        res.send("table deleted")
    }
    catch (err) {
        console.log(err)
        res.send(err)
    }
});

app.get("/api/drop/:table", async(req, res) => {

    try {
        const table = req.params.table;
        await pool.query(`DROP TABLE ${table};`);
        querySQL.write(`DROP TABLE ${table};\n\n`);
        res.send("table dropped")
    }
    catch (err) {
        console.log(err)
        res.send(err)
    }
});

app.post("/api/createAccount", async (req,res) => {

    try {

        const ssn = req.body.ssn;
        const planType = req.body.planType;
        const autoPayment = req.body.autoPayment;
        const streetAddress = req.body.streetAddress;
        const city = req.body.city;
        const state = req.body.state;
        const zipCode = req.body.zipCode;

        const firstName = req.body.firstName;
        const lastName = req.body.lastName;
        const dob = req.body.dob;

        const phoneModel = req.body.phoneModel;

        var phone_number = generateNumber(10)

        await pool.query(`

            BEGIN;

            INSERT INTO phone_account VALUES
                (nextval('phone_account_no_sequence'), '${planType}', '${autoPayment}', '${streetAddress}', '${city}', '${state}', '${zipCode}')
                RETURNING account_no;

            INSERT INTO bank_account VALUES
                (nextval('bank_account_no_sequence'), ${Number(generateNumber(5)) + 10000});

            INSERT INTO customer VALUES
                ('${ssn}', currval('phone_account_no_sequence'), '${firstName}', '${lastName}', '${dob}');

            INSERT INTO phone VALUES
                ('${phone_number}', '${ssn}', '${phoneModel}');

            INSERT INTO payment_method VALUES
                (currval('bank_account_no_sequence'), currval('phone_account_no_sequence'));

            INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)
                VALUES (currval('bank_account_no_sequence'), currval('phone_account_no_sequence'), NOW(), -3500);

            COMMIT;

            END;

        `)
        .then(function (result) {

            transactionSQL.write(`BEGIN;\n\n`);
            transactionSQL.write(`INSERT INTO phone_account VALUES\n`);
            transactionSQL.write(`\t(nextval('phone_account_no_sequence'), '${planType}', '${autoPayment}', '${streetAddress}', '${city}', '${state}', '${zipCode}')\n`);
            transactionSQL.write(`\tRETURNING account_no;\n\n`)
            transactionSQL.write(`INSERT INTO bank_account VALUES\n`);
            transactionSQL.write(`\t(nextval('bank_account_no_sequence'), ${Number(generateNumber(5)) + 10000});\n\n`);
            transactionSQL.write(`INSERT INTO customer VALUES\n`);
            transactionSQL.write(`\t('${ssn}', currval('phone_account_no_sequence'), '${firstName}', '${lastName}', '${dob}');\n\n`);
            transactionSQL.write(`INSERT INTO phone VALUES\n`);
            transactionSQL.write(`\t('${phone_number}', '${ssn}', '${phoneModel}');\n\n`);
            transactionSQL.write(`INSERT INTO payment_method VALUES\n`);
            transactionSQL.write(`\t(currval('bank_account_no_sequence'), currval('phone_account_no_sequence'));\n\n`);
            transactionSQL.write(`INSERT INTO payment (bank_account_no, phone_account_no, payment_date, amount_cents)\n`);
            transactionSQL.write(`\tVALUES (currval('bank_account_no_sequence'), currval('phone_account_no_sequence'), NOW(), -3500);\n\n`);
            transactionSQL.write(`COMMIT;\n\n`);
            transactionSQL.write(`END;\n\n`);

            console.log("New account created: " + result[1].rows[0].account_no)
            res.send(['Account Created', result[1].rows[0].account_no])

        });

    } catch (err) {
        await pool.query('ROLLBACK');
        console.log("Error 8: " + err)
        res.send(err.code)
        return;
    }

})

app.get("/api/planRates/:plan", async (req,res) => {

    try {
        const plan = req.params.plan;
        console.log(plan)

        await pool.query(`
            SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice 
            FROM plan
            WHERE plan_name = '${plan}';
        `)
        .then(function (result) {

            querySQL.write(`SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice\n`);
            querySQL.write(`FROM plan\n`);
            querySQL.write(`WHERE plan_name = '${plan}';\n\n`);
        
            res.send([result.rows[0].callprice, result.rows[0].dataprice]);

        });

    } catch (err) {
        console.log("Error: " + err.message)
        return res.status(500).send("Error: " + err.message);
    }

});

app.get("/api/accounts/:type&:input", async (req,res) => {

    try {

        const type = req.params.type
        const input = req.params.input;

        console.log("Search for input: " + input)
        
        var searchColumn = '';
        if(type == "Phone Number") {
            searchColumn = 'number';
        }
        if(type == "First Name") {
            searchColumn = 'first_name';
        }
        else if(type == "Last Name") {
            searchColumn = 'last_name';
        }
        else if(type == "Account Number") {
            console.log("Search by account:")
            searchColumn = 'account_no';
        }

        const result = await pool.query(`
            SELECT number, first_name, last_name, account_no FROM customer
            JOIN phone ON customer.ssn = phone.user_ssn
            WHERE UPPER(${searchColumn}::varchar(255)) LIKE UPPER('${input}%');
        `, [])
        .then(function (result) {

            querySQL.write(`SELECT number, first_name, last_name, account_no FROM customer\n`);
            querySQL.write(`JOIN phone ON customer.ssn = phone.user_ssn\n`);
            querySQL.write(`WHERE UPPER(${searchColumn}) LIKE UPPER('${input}%');\n\n`);

            var accounts = []

            for(var i = 0; i < result.rows.length; i++) {
                accounts.push([
                    result.rows[i].number,
                    result.rows[i].first_name,
                    result.rows[i].last_name,
                    result.rows[i].account_no
                ])
            }

            console.log("Accounts: " + result.rows.length)
            res.send(accounts);

        });

    } catch (err) {
        console.log("Error: " + err.message)
        return res.status(500).send("Error: " + err.message);
    }
    
})

app.get("/api/accountDetails/:accountNo", async (req, res) => {

    try {
        const accountNo = req.params.accountNo;
        console.log(accountNo)

        await pool.query(`
            SELECT phone_account.account_no, first_name, last_name, street_address, city, st, zip_code, plan_type, balance_cents FROM phone_account
            JOIN customer ON customer.account_no = phone_account.account_no
            WHERE phone_account.account_no = '${accountNo}';
        `, [])
        .then(function (result) {

            querySQL.write(`SELECT phone_account.account_no, first_name, last_name, street_address, city, st, zip_code, plan_type, balance_cents FROM phone_account\n`);
            querySQL.write(`JOIN customer ON customer.account_no = phone_account.account_no\n`);
            querySQL.write(`WHERE phone_account.account_no = '${accountNo}';\n\n`);

            var row = []

            row.push(
                result.rows[0].plan_type,
                result.rows[0].street_address,
                result.rows[0].city,
                result.rows[0].st,
                result.rows[0].zip_code
            )

            res.send(row);

        });

    } catch (err) {
        console.log("Error: " + err.message)
        return res.status(500).send("Error: " + err.message);
    }

})

app.post("/api/updateAccountDetails", async(req,res) => {

    const accountNo = req.body.accountNo;
    const planType = req.body.planType;
    const streetAddress = req.body.streetAddress;
    const city = req.body.city;
    const state = req.body.state;
    const zipCode = req.body.zipCode;

    try {

        await pool.query(`
            BEGIN;

            UPDATE phone_account
                SET street_address = '${streetAddress}',
                city = '${city}',
                st = '${state}',
                zip_code = '${zipCode}',
                plan_type = '${planType}'
                WHERE account_no = '${accountNo}';

            COMMIT;

            END;

        `)
        .then(result => {

            transactionSQL.write(`BEGIN;\n\n`);
            transactionSQL.write(`UPDATE phone_account\n`);
            transactionSQL.write(`\tSET street_address = '${streetAddress}',\n`);
            transactionSQL.write(`\tcity = '${city}',\n`);
            transactionSQL.write(`\tst = '${state}',\n`);
            transactionSQL.write(`\tzip_code = '${zipCode}',\n`);
            transactionSQL.write(`\tplan_type = '${planType}'\n`);
            transactionSQL.write(`\tWHERE account_no = '${accountNo}';\n\n`);
            transactionSQL.write(`COMMIT;\n\n`);
            transactionSQL.write(`END;\n\n`);

            res.send("Account Updated");

        })


    } catch(err) {

        console.log("account update failed: " + err)
        await pool.query(`ROLLBACK;`)
        res.send(err.code)
    }

});

app.get("/api/accountBill", async (req, res) => {

    try {

        const accountNo = req.query.accountNumber;

        await pool.query(`
            SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd
                FROM phone_account
                JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
                JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
                WHERE phone_account.account_no = '${accountNo}'
                GROUP BY pbd, bbd;
        `)
        .then(function (result) {

            querySQL.write(`SELECT (phone_account.balance_cents / 100.00)::MONEY as pbd, (bank_account.balance_cents / 100.00)::MONEY as bbd\n`);
            querySQL.write(`\tFROM phone_account\n`);
            querySQL.write(`\tJOIN payment_method ON phone_account.account_no = payment_method.phone_account_no\n`);
            querySQL.write(`\tJOIN bank_account ON payment_method.bank_account_no = bank_account.account_no\n`);
            querySQL.write(`\tWHERE phone_account.account_no = '${accountNo}'\n`);
            querySQL.write(`\tGROUP BY pbd, bbd;\n\n`);

            res.send([result.rows[0].pbd, result.rows[0].bbd]);

        });

    } catch (err) {
        console.log("Error 9: " + err.message)
    }

});

app.get("/api/getLineInfo", async(req,res) => {

    const phoneNumber = req.query.phoneNumber;
    console.log(phoneNumber)

    try {

        await pool.query(`
            SELECT first_name, last_name, birthday, ssn, model
            FROM customer
            JOIN phone ON customer.ssn = phone.user_ssn
            WHERE number = '${phoneNumber}'
            GROUP BY first_name, last_name, birthday, ssn, model;
        `)
        .then(result => {

            querySQL.write(`SELECT first_name, last_name, birthday, ssn, model\n`);
            querySQL.write(`\tFROM customer\n`);
            querySQL.write(`\tJOIN phone ON customer.ssn = phone.user_ssn\n`);
            querySQL.write(`\tWHERE number = '${phoneNumber}'\n`);
            querySQL.write(`\tGROUP BY first_name, last_name, birthday, ssn, model;\n\n`);

            if(result.rows.length > 0) {
                res.send(result.rows);
            }
            else {
                res.send("No results")
            }
        })

    } catch(err) {
        console.log(err)
    }

});

app.post("/api/updateLine", async(req,res) => {

    const ssn = req.body.ssn;
    const firstName = req.body.firstName;
    const lastName = req.body.lastName;
    const phoneModel = req.body.phoneModel;

    try {

        await pool.query(`
            BEGIN;

            UPDATE customer
                SET first_name = '${firstName}',
                last_name = '${lastName}'
                WHERE ssn = '${ssn}';

            UPDATE phone
                SET model = '${phoneModel}'
                WHERE user_ssn = '${ssn}';
                
            COMMIT;

            END;
        `)
        .then(result => {

            transactionSQL.write(`BEGIN;\n\n`)
            transactionSQL.write(`UPDATE customer\n`)
            transactionSQL.write(`\tSET first_name = '${firstName}',\n`)
            transactionSQL.write(`\tlast_name = '${lastName}',\n`)
            transactionSQL.write(`\tWHERE ssn = '${ssn}';\n\n`)
            transactionSQL.write(`UPDATE phone\n`)
            transactionSQL.write(`\tSET model = '${phoneModel}'\n`)
            transactionSQL.write(`\tWHERE user_ssn = '${ssn}';\n\n`)
            transactionSQL.write(`COMMIT;\n\n`)
            transactionSQL.write(`END;\n\n`)

            res.send("Line Updated")
        })

    } catch(err) {
        await pool.query(`ROLLBACK;`)
        console.log(err)
        res.send(err.code)
    }

})

app.post("/api/createLine", async(req,res) => {

    const accountNo = req.body.accountNo;
    const ssn = req.body.ssn;
    const firstName = req.body.firstName;
    const lastName = req.body.lastName;
    const dob = req.body.dob;
    const phoneModel = req.body.phoneModel;
    var phone_number = generateNumber(10)

    try {

        await pool.query(`
            BEGIN;

            INSERT INTO customer 
                VALUES ('${ssn}', '${accountNo}', '${firstName}', '${lastName}', '${dob}');

            INSERT INTO phone
                VALUES('${phone_number}', '${ssn}', '${phoneModel}');
                
            COMMIT;

            END;
        `)
        .then(result => {

            transactionSQL.write(`BEGIN;\n\n`)
            transactionSQL.write(`INSERT INTO customer\n`)
            transactionSQL.write(`\tVALUES ('ssn', 'accountNo', 'firstName', 'lastName', dob);\n\n`)
            transactionSQL.write(`INSERT INTO phone\n`)
            transactionSQL.write(`\tVALUES('phone_number', 'ssn', 'phoneModel');\n\n`)
            transactionSQL.write(`COMMIT;\n\n`)
            transactionSQL.write(`END;\n\n`)

            res.send("Line Created")
        })

    } catch(err) {
        await pool.query(`ROLLBACK;`)
        console.log(err)
        res.send(err.code)
    }

})

app.get("/api/accountLines/:accountNo", async (req, res) => {

    try {

        const accountNo = req.params.accountNo;
        console.log("Account Lines: " + accountNo)

        await pool.query(`
            WITH calls AS (
                SELECT number, model, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
                FROM customer
                JOIN phone ON customer.ssn = phone.user_ssn
                LEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to
                WHERE account_no = '${accountNo}'
                GROUP BY number, first_name, last_name
            ),
            dataUsed AS (
                SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
                FROM data
                GROUP BY phone_number
            )
            SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
            FROM calls
            LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number;
        `, [])
        .then(function (result) {

            querySQL.write(`WITH calls AS (\n`);
            querySQL.write(`\tSELECT number, model, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes\n`);
            querySQL.write(`\tFROM customer\n`);
            querySQL.write(`\tJOIN phone ON customer.ssn = phone.user_ssn\n`);
            querySQL.write(`\tLEFT JOIN call ON phone.number = call.call_from OR phone.number = call.call_to\n`);
            querySQL.write(`\tWHERE account_no = '${accountNo}'\n`);
            querySQL.write(`\tGROUP BY number, first_name, last_name\n`);
            querySQL.write(`),\n`);
            querySQL.write(`dataUsed AS (\n`);
            querySQL.write(`\tSELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used\n`);
            querySQL.write(`\tFROM data\n`);
            querySQL.write(`\tGROUP BY phone_number\n`);
            querySQL.write(`)\n`);
            querySQL.write(`SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used\n`);
            querySQL.write(`FROM calls\n`);
            querySQL.write(`LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number;\n\n`);

            var lines = []

            for(var i = 0; i < result.rows.length; i++) {
                lines.push([
                    result.rows[i].number,
                    result.rows[i].model,
                    result.rows[i].first_name,
                    result.rows[i].last_name,
                    result.rows[i].minutes,
                    result.rows[i].data_used
                ])
            }
            console.log("Lines: " + result.rows.length)
            res.send(lines);

        });

    } catch (err) {
        console.log("Error: " + err.message)
        return res.send("Error: " + err.message);
    }

});

app.get("/api/getCalls", async (req, res) => {

    const accountNo = req.query.accountNo;
    const phone_num = req.query.phone_num;

    console.log("Get calls: " + accountNo + " " + phone_num);

    try {

        await pool.query(`
            SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time
                FROM call
                JOIN phone ON phone.number = call.call_from OR phone.number = call.call_to
                WHERE phone.number = '${phone_num}'
                GROUP BY call_from, call_to, minutes, Date, Time
                ORDER BY date DESC, time DESC;
        `)
        .then(function (result) {

            querySQL.write(`SELECT call_from, call_to, call_length_mins as minutes, TO_CHAR(call_date,'MM-DD-YYYY') as Date, TO_CHAR(call_date,'HH24:MI:SS') as Time\n`);
            querySQL.write(`\tFROM call\n`);
            querySQL.write(`\tJOIN phone ON phone.number = call.call_from OR phone.number = call.call_to\n`);
            querySQL.write(`\tWHERE phone.number = '${phone_num}'\n`);
            querySQL.write(`\tGROUP BY call_from, call_to, minutes, Date, Time\n`);
            querySQL.write(`\tORDER BY date DESC, time DESC;\n\n`);

            console.log("Number of Calls: " + result.rows.length)
            
            if(result.rows.length > 0) {

                var calls = []

                for(let i = 0; i < result.rows.length; i++) {
                    calls.push([
                        result.rows[i].call_from,
                        result.rows[i].call_to,
                        result.rows[i].minutes,
                        result.rows[i].date,
                        result.rows[i].time
                    ])
                }

                res.send(calls)

            }
            else {
                res.send("No results")
            }

        })

    } catch(err) {
        console.log(err);
    }

});

app.get("/api/getData", async (req, res) => {

    const accountNo = req.query.accountNo;
    const phone_num = req.query.phone_num;

    console.log("Get Data: " + accountNo);

    try {

        await pool.query(`
            SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time
            FROM data
            JOIN phone ON phone.number = data.phone_number
            WHERE phone.number = '${phone_num}'
            GROUP BY phone_number, mb_used, Date, Time
            ORDER BY date DESC, time DESC;
        `)
        .then(function (result) {

            querySQL.write(`SELECT phone_number, mb_used, TO_CHAR(data_date,'MM-DD-YYYY') as Date, TO_CHAR(data_date,'HH24:MI:SS') as Time\n`);
            querySQL.write(`\tFROM data\n`);
            querySQL.write(`\tJOIN phone ON phone.number = data.phone_number\n`);
            querySQL.write(`\tWHERE phone.number = '${phone_num}'\n`);
            querySQL.write(`\tGROUP BY phone_number, mb_used, Date, Time\n`);
            querySQL.write(`\tORDER BY date DESC, time DESC;\n\n`);

            console.log("Number of Data Use: " + result.rows.length)
            
            if(result.rows.length > 0) {

                var dataUse = []

                for(let i = 0; i < result.rows.length; i++) {
                    dataUse.push([
                        result.rows[i].phone_number,
                        result.rows[i].mb_used,
                        result.rows[i].date,
                        result.rows[i].time
                    ])
                }

                res.send(dataUse)

            }
            else {
                res.send("No results")
            }

        })

    } catch(err) {
        console.log(err);
    }

});

app.post("/api/makePayment", async (req,res) => {

    try {

        const accountNo = req.body.accountNo;
        const paymentAmount = Math.floor(Number(req.body.paymentAmount) * 100);

        console.log("Payment: " + paymentAmount)

        const date = new Date();

        let day = date.getDate();
        let month = date.getMonth() + 1;
        let year = date.getFullYear();

        await pool.query(`
            SELECT phone_account.account_no AS pan, bank_account.account_no AS ban
            FROM phone_account
            JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
            JOIN bank_account ON payment_method.bank_account_no = bank_account.account_no
            WHERE phone_account.account_no = '${accountNo}'
            GROUP BY pan, ban;
        `)
        .then(function (result) {

            querySQL.write(`SELECT phone_account.account_no AS pan, bank_account.account_no AS ban\n`);
            querySQL.write(`\tFROM phone_account\n`);
            querySQL.write(`\tJOIN payment_method ON phone_account.account_no = payment_method.phone_account_no\n`);
            querySQL.write(`\tJOIN bank_account ON payment_method.bank_account_no = bank_account.account_no\n`);
            querySQL.write(`\tWHERE phone_account.account_no = '${accountNo}'\n`);
            querySQL.write(`\tGROUP BY pan, ban;\n`);

            payment(paymentAmount, result.rows[0].pan, result.rows[0].ban, 'NOW()', true, res);

        })

        
        return;

    } catch (err) {
        console.log("Error on Making Payment: " + err.message)
        res.send(err.message)
        return;
    }

})

app.get("/api/getPayments", async(req,res) => {

    try {

        const accountNo = req.query.accountNo;

        await pool.query(`
            SELECT TO_CHAR(payment_date,'MM-DD-YYYY') as Date, TO_CHAR(payment_date,'HH24:MI:SS') as Time, (amount_cents / 100.00)::MONEY as Payment 
            FROM payment 
            WHERE phone_account_no = '${accountNo}'
            ORDER BY Date DESC, Time DESC;
        `)
        .then(function (result) {

            querySQL.write(`SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment\n`);
            querySQL.write(`FROM payment\n`);
            querySQL.write(`WHERE phone_account_no = '${accountNo}'\n`);
            querySQL.write(`ORDER BY Date DESC;\n\n`);

            res.send(result.rows)
        });

    } catch (err) {
        console.log("Error 10: " + err)
        return;
    }
})

app.post("/api/simulateCall", async (req,res) => {

    const phone_num = req.body.phone_num;
    const accountNo = req.body.accountNo;


    try {

        const account_info = await pool.query(`
            SELECT plan_type, bank_account.account_no AS ban FROM phone_account
            JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
            JOIN bank_account ON bank_account.account_no = payment_method.bank_account_no
            WHERE phone_account.account_no = '${accountNo}';
        `)
            
        const prices = await pool.query(`
            SELECT call_price_cents, data_price_cents FROM plan
            WHERE plan_name = '${account_info.rows[0].plan_type}';
        `)

        var call_length = Math.round(360 / (Math.random() * 360 + 1));
        let call_cost = call_length * Number(prices.rows[0].call_price_cents);

        await pool.query(`
            BEGIN;

            INSERT INTO call (call_from, call_to, call_length_mins, call_date)
                VALUES ('${phone_num}', '${generateNumber(10)}', ${call_length}, NOW());

            UPDATE phone_account
                SET balance_cents = balance_cents - ${call_cost}
                WHERE account_no = '${accountNo}'
                RETURNING balance_cents;

            COMMIT;

            END;

        `)
        .then(function (result) {

            transactionSQL.write(`BEGIN;\n\n`);
            transactionSQL.write(`INSERT INTO call (call_from, call_to, call_length_mins, call_date)\n`);
            transactionSQL.write(`\tVALUES ('${phone_num}', '${generateNumber(10)}', ${call_length}, NOW());\n\n`);
            transactionSQL.write(`UPDATE phone_account\n`);
            transactionSQL.write(`\tSET balance_cents = balance_cents - ${call_cost}\n`);
            transactionSQL.write(`\tWHERE account_no = '${accountNo}'\n`);
            transactionSQL.write(`\tRETURNING balance_cents;\n\n`);
            transactionSQL.write(`COMMIT;\n\n`);
            transactionSQL.write(`END;\n\n`);

            if(account_info.rows[0].plan_type == 'Pre-Paid' && result[2].rows[0].balance_cents < 0) {

                payment(4000, accountNo, account_info.rows[0].ban, 'NOW()', true, '');

            }

            console.log("call created")
            res.send("Call created")

        });

    } catch(err) {
        console.log(err)
    }

})

app.post("/api/simulateData", async (req,res) => {

    const phone_num = req.body.phone_num;
    const accountNo = req.body.accountNo;


    try {

        const account_info = await pool.query(`
            SELECT plan_type, bank_account.account_no AS ban FROM phone_account
            JOIN payment_method ON phone_account.account_no = payment_method.phone_account_no
            JOIN bank_account ON bank_account.account_no = payment_method.bank_account_no
            WHERE phone_account.account_no = '${accountNo}';
        `)
            
        const prices = await pool.query(`
            SELECT call_price_cents, data_price_cents FROM plan
            WHERE plan_name = '${account_info.rows[0].plan_type}';
        `)

        var mb_used = Math.floor(500 / (Math.random() * 500 + 1)) + Math.random();
        let data_cost = Math.floor((mb_used / 1000) * Number(prices.rows[0].data_price_cents));

        await pool.query(`
            BEGIN;

            INSERT INTO data (phone_number, mb_used, data_date)
                VALUES ('${phone_num}', ${mb_used}, NOW());

            UPDATE phone_account
                SET balance_cents = balance_cents - ${data_cost}
                WHERE account_no = '${accountNo}'
                RETURNING balance_cents;

            COMMIT;

            END;

        `)
        .then(function (result) {

            transactionSQL.write(`BEGIN;\n\n`);
            transactionSQL.write(`INSERT INTO data (phone_number, mb_used, data_date)\n`);
            transactionSQL.write(`\tVALUES ('${phone_num}', ${mb_used}, NOW());\n\n`);
            transactionSQL.write(`UPDATE phone_account\n`);
            transactionSQL.write(`\tSET balance_cents = balance_cents - ${data_cost}\n`);
            transactionSQL.write(`\tWHERE account_no = '${accountNo}'\n`);
            transactionSQL.write(`\tRETURNING balance_cents;\n\n`);
            transactionSQL.write(`COMMIT;\n\n`);
            transactionSQL.write(`END;\n\n`);

            if(account_info.rows[0].plan_type == 'Pre-Paid' && result[2].rows[0].balance_cents < 0) {

                payment(4000, accountNo, account_info.rows[0].ban, 'NOW()', true, '');

            }

            console.log("call created")
            res.send("Call created")

        });

    } catch(err) {
        console.log(err)
    }

})

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});