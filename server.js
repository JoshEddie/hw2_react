const list = require('./src/lists.js');

const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3002;

var fs = require("fs");
// var transactions = fs.createWriteStream("transactions.sql");
// var queries = fs.createWriteStream("query.sql");
// transactions = fs.createWriteStream("transactions.sql", {flags:'a'});
// queries = fs.createWriteStream("query.sql", {flags:'a'});

const creds = require('./creds.json');
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

async function createAccount(ssn, planType, autoPayment, streetAddress, city, state, zipCode, firstName, lastName, dob, phoneModel) {

    try {
        
        await pool.query(`
            INSERT into account VALUES
            ('${ssn}', '${planType}', '${autoPayment}', '${streetAddress}', '${city}', '${state}', '${zipCode}');
        `)

        await pool.query (`
            INSERT INTO bank_account VALUES
            ('${ssn}', ${Number(generateNumber(5)) + 100000})
        `)

        createCustomer(ssn, ssn, firstName, lastName, dob, phoneModel);

    }
    catch (err) {
        console.log("Error createAccount(): " + err.message)
    }

}

async function createCustomer(ssn, accountSSN, firstName, lastName, dob, phoneModel) {

    try {

        await pool.query(`
            INSERT into customer VALUES
            ('${firstName}', '${lastName}', '${ssn}', '${dob}', '${accountSSN}');
        `)

        createPhoneNumber(ssn, phoneModel)

    }
    catch (err) {
        console.log("Error createCustomer(): " + err.message)
    }

}

async function createPhoneNumber(ssn, phoneModel) {
    
    try {
        let phoneNumber = generateNumber(10);

        await pool.query(`
            INSERT into phone_number VALUES
            ('${phoneNumber}', '${ssn}');
        `)

        createPhoneModel(phoneNumber, phoneModel)
    }
    catch (err) {
        console.log("Error createPhoneNumber(): " + err.message)
    }
}

async function createPhoneModel(phoneNumber, phoneModel) {

    try {
        await pool.query(`
            INSERT into phone_model VALUES
            ('${phoneNumber}', '${phoneModel}');
        `)
    }
    catch (err) {
        console.log("Error createPhoneModel(): " + err.message)
    }

}

async function phoneCall(callFrom, callTo, callLengthMins, callDate) {

    try {
        await pool.query(`
            INSERT INTO call (call_from, call_to, call_length_mins, call_date)
            VALUES ('${callFrom}', '${callTo}', ${callLengthMins}, DATE '${callDate}');
        `)
    }
    catch (err) {
        console.log("Error phoneCall(): " + err.message)
    }
}

async function dataUse(phoneNumber, mbUsed, dataDate) {

    try {
        await pool.query(`
            INSERT INTO data (phone_number, mb_used, data_date)
            VALUES ('${phoneNumber}', ${mbUsed}, DATE '${dataDate}');
        `)
        return '';
    }
    catch (err) {
        console.log("Error dataUse(): " + err.message)
    }

}

async function chargeBalance(cost, ssn) {

    let retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
        try {

            await pool.query('BEGIN');
            // transactions.write('BEGIN\n\n')

            const updateBalance = await pool.query(`
                UPDATE account
                SET balance_cents = balance_cents + ${cost}
                WHERE account_ssn = '${ssn}'
                RETURNING (balance_cents / 100.00)::MONEY as balancedollar;
            `)

            // transactions.write(`UPDATE account\n`)
            // transactions.write(`SET balance_cents = balance_cents + ${cost}\n`)
            // transactions.write(`WHERE account_ssn = '${ssn}'\n`)
            // transactions.write(`RETURNING (balance_cents / 100.00)::MONEY as balancedollar;\n\n`)

            const updateBankBalance = await pool.query(`
                UPDATE bank_account
                SET balance_cents = balance_cents - ${cost}
                WHERE account_ssn = '${ssn}'
                RETURNING (balance_cents / 100.00)::MONEY as balancedollar;
            `)

            // transactions.write(`UPDATE bank_account\n`)
            // transactions.write(`SET balance_cents = balance_cents - ${cost}\n`)
            // transactions.write(`WHERE account_ssn = '${ssn}'\n`)
            // transactions.write(`RETURNING (balance_cents / 100.00)::MONEY as balancedollar;\n\n`)

            await pool.query('COMMIT');
            // transactions.write('COMMIT\n\n')

            return [updateBalance.rows[0].balancedollar, updateBankBalance.rows[0].balancedollar]; // Success, exit the loop
        } catch (err) {
            await pool.query('ROLLBACK');
            if (err.code === '40P01' && retryCount < maxRetries - 1) {
                // Deadlock detected, retry after a short delay
                retryCount++;
                await new Promise((resolve) => setTimeout(resolve, 1000)); // Wait for 1 second before retrying
            } else {
                console.error('Error updating balance:', err);
                break;
            }
        }
    }
    console.error('Max retries reached, unable to update balance');
    return "error";

}

async function payment(paymentDate, paymentAmount, acountSSN) {

    try {
        await pool.query(`
            INSERT INTO payment (payment_date, amount_cents, account_holder_ssn)
            VALUES (DATE '${paymentDate}', ${paymentAmount}, '${acountSSN}');
        `)
        return '';
    }
    catch (err) {
        console.log("Error payment(): " + err.message)
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
    await pool.query(`DROP TABLE IF EXISTS account`);
    await pool.query(`DROP TABLE IF EXISTS customer`);
    await pool.query(`DROP TABLE IF EXISTS phone_number`);
    await pool.query(`DROP TABLE IF EXISTS phone_model`);
    await pool.query(`DROP TABLE IF EXISTS call`);
    await pool.query(`DROP TABLE IF EXISTS data`);
    await pool.query(`DROP TABLE IF EXISTS payment`);
    await pool.query(`DROP TABLE IF EXISTS plan`);
    res.send("tables dropped")
    }
    catch (err) {
        res.send('error')
        return;
    }
    return;
})

app.get('/api/intializeDatabase', async (req, res) => {

    //Create Tables if they don't exist

    console.log("Intializing tables")

    try {
        await pool.query(`DROP TABLE IF EXISTS account`);
        await pool.query(`DROP TABLE IF EXISTS customer`);
        await pool.query(`DROP TABLE IF EXISTS phone_number`);
        await pool.query(`DROP TABLE IF EXISTS phone_model`);
        await pool.query(`DROP TABLE IF EXISTS call`);
        await pool.query(`DROP TABLE IF EXISTS data`);
        await pool.query(`DROP TABLE IF EXISTS payment`);
        await pool.query(`DROP TABLE IF EXISTS plan`);
        await pool.query(`DROP TABLE IF EXISTS bank_account`);
        }
        catch (err) {
            return;
        }

        try {
        await pool.query(`
            CREATE TABLE IF NOT EXISTS account (
                account_ssn CHAR(9) PRIMARY KEY CHECK (account_ssn <> ''),
                plan_type VARCHAR NOT NULL CHECK (plan_type <> ''),
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
                first_name VARCHAR NOT NULL CHECK (first_name <> ''),
                last_name VARCHAR NOT NULL CHECK (last_name <> ''),
                ssn CHAR(9) PRIMARY KEY,
                birthday DATE NOT NULL,
                account_holder_ssn CHAR(9) NOT NULL
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS phone_number (
                number CHAR(10) PRIMARY KEY,
                user_ssn CHAR(9) NOT NULL
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS phone_model (
                phone_number CHAR(10) PRIMARY KEY,
                model VARCHAR NOT NULL CHECK (model <> '')
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS call (
                call_id SERIAL PRIMARY KEY,
                call_from CHAR(10),
                call_to CHAR(10),
                call_length_mins INT,
                call_date DATE
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS data (
                data_id SERIAL PRIMARY KEY,
                phone_number CHAR(10),
                mb_used DECIMAL,
                data_date DATE
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS payment (
                payment_id SERIAL PRIMARY KEY,
                payment_date DATE NOT NULL,
                amount_cents BIGINT NOT NULL,
                account_holder_ssn CHAR(9) NOT NULL
            );
        `)

        await pool.query(`
            CREATE TABLE IF NOT EXISTS bank_account (
                account_ssn CHAR(9) PRIMARY KEY,
                balance_cents BIGINT DEFAULT 0
            )
        `)

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
    } catch (err) {
        console.log("Error 1: " + err.message)
    };

    console.log("Tables intialized")

    try {
        const accountCount = await pool.query(`
            SELECT COUNT(*) FROM account;
        `)

        if (accountCount.rows[0].count == '0') {

            console.log("Intializing Accounts")

            for (let i = 0; i < 100; i++) {

                try {

                    await pool.query(`BEGIN`);

                    createAccount(
                        generateNumber(9), 
                        list.planTypes[Math.round(Math.random() * (list.planTypes.length - 1))],
                        Math.round(Math.random()).toString(), 
                        randomStreetName(), 
                        list.city_names[Math.round(Math.random() * (list.city_names.length - 1))], 
                        list.state_names[Math.round(Math.random() * (list.state_names.length - 1))], 
                        generateNumber(5), 
                        randomName(), 
                        randomName(), 
                        randomBirthday(), 
                        list.phone_models[Math.round(Math.random() * (list.phone_models.length - 1))]
                    );

                    await pool.query(`COMMIT`);
                    await pool.query(`END`);

                }
                catch (err) {
                    await pool.query('ROLLBACK');
                    console.log("Error 2: " + err.message);
                }

            }

            console.log("Accounts intialized")
            console.log("Intializing Customers")

            for (let i = 0; i < 200; i++) {

                const accounts = await pool.query(`
                    SELECT account_ssn FROM account;
                `)
            
                try {
                    await pool.query(`BEGIN`);

                    createCustomer(
                        generateNumber(9),
                        accounts.rows[Math.round(Math.random() * (accounts.rows.length - 1))].account_ssn, 
                        randomName(), 
                        randomName(), 
                        randomBirthday(), 
                        list.phone_models[Math.round(Math.random() * (list.phone_models.length - 1))]
                    );

                    await pool.query(`COMMIT`);
                    await pool.query(`END`);
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
            SELECT number FROM phone_number;
        `)

        for(let i = 0; i < phoneNumbers.rows.length; i++) {

            const account_ssn_planType = await pool.query(`
                SELECT account.account_ssn, account.plan_type FROM account
                JOIN customer ON account.account_ssn = customer.account_holder_ssn
                JOIN phone_number ON phone_number.user_ssn = customer.ssn
                WHERE phone_number.number = '${phoneNumbers.rows[i].number}'
                GROUP BY account.account_ssn, account.plan_type;
            `)
            
            const prices = await pool.query(`
                SELECT call_price_cents, data_price_cents FROM plan
                WHERE plan_name = '${account_ssn_planType.rows[0].plan_type}';
            `)

            for(let call_number = 0; call_number < Math.round(Math.random() * 50 + 1); call_number++) {
                
                var call_length = Math.round(360 / (Math.random() * 360 + 1))
                var day = (Math.round(Math.random() * 28)).toString().padStart(2, '0');

                var phone_to = 0;

                do {
                    phone_to = Math.round(Math.random() * (phoneNumbers.rows.length - 1));
                } while(i === phone_to);

                let date = "2023-" + month.toString().padStart(2, '0') + "-" + (Math.round(Math.random() * (28 - 1) + 1)).toString().padStart(2, '0');
                let call_cost = call_length * Number(prices.rows[0].call_price_cents);

                try {
                    await pool.query(`BEGIN`);
                    phoneCall(phoneNumbers.rows[i].number, phoneNumbers.rows[phone_to].number, call_length, date);
                    chargeBalance(call_cost * -1, account_ssn_planType.rows[0].account_ssn)

                    const balance = await pool.query(`
                        SELECT balance_cents FROM account
                        WHERE account.account_ssn = '${account_ssn_planType.rows[0].account_ssn}';
                    `);
                    if(account_ssn_planType.rows[0].plan_type == 'Pre-Paid' && balance.rows[0].balance_cents < 0) {
                        payment(date, 4000, account_ssn_planType.rows[0].account_ssn);
                        chargeBalance(4000, account_ssn_planType.rows[0].account_ssn)
                    }

                    await pool.query(`COMMIT`);
                    await pool.query(`END`);

                }
                catch (err) {
                    await pool.query(`ROLLBACK`);
                    console.log("Error 4: " + err.message)
                }

            }

            for(let data_use = 0; data_use < Math.round(Math.random() * 50 + 1); data_use++) {
                var mb_used = Math.floor(500 / (Math.random() * 500 + 1)) + Math.random();
                var day = (Math.round(Math.random() * 28)).toString().padStart(2, '0');

                var phone_to = 0;

                do {
                    phone_to = Math.round(Math.random() * phoneNumbers.rows.length);
                } while(i === phone_to);

                let date = "2023-" + month.toString().padStart(2, '0') + "-" + (Math.round(Math.random() * (28 - 1) + 1)).toString().padStart(2, '0');
                let data_cost = Math.floor((mb_used / 1000) * Number(prices.rows[0].data_price_cents));

                try {
                    dataUse(phoneNumbers.rows[i].number, mb_used, date);
                }
                catch (err) {console.log("Error 5: " + err.message)}

                try {

                    await pool.query(`BEGIN`)

                    dataUse(phoneNumbers.rows[i].number, mb_used, date);
                    chargeBalance(data_cost * -1, account_ssn_planType.rows[0].account_ssn)

                    const balance = await pool.query(`
                        SELECT balance_cents FROM account
                        WHERE account.account_ssn = '${account_ssn_planType.rows[0].account_ssn}';
                    `);
                    if(account_ssn_planType.rows[0].plan_type == 'Pre-Paid' && balance.rows[0].balance_cents < 0) {
                        payment(date, 4000, account_ssn_planType.rows[0].account_ssn);
                        chargeBalance(4000, account_ssn_planType.rows[0].account_ssn)
                    }

                    await pool.query(`COMMIT`);
                    await pool.query(`END`);

                }
                catch (err) {
                    await pool.query(`ROLLBACK`);
                    console.log("Error 6: " + err.message)
                }

            }

            if (month != 10) {
                try {
                    const balance = await pool.query(`
                        SELECT balance_cents FROM account
                        WHERE account.account_ssn = '${account_ssn_planType.rows[0].account_ssn}';
                    `);

                    let date = "2023-" + month.toString().padStart(2, '0') + "-28";

                    if(balance.rows[0].balance_cents < 0 && account_ssn_planType.rows[0].plan_type != 'Pre-Paid') {

                        await pool.query(`BEGIN`);

                        payment(date, balance.rows[0].balance_cents * -1, account_ssn_planType.rows[0].account_ssn);
                        chargeBalance(balance.rows[0].balance_cents * -1, account_ssn_planType.rows[0].account_ssn)

                        await pool.query(`COMMIT`);
                        await pool.query(`END`);

                    }

                }
                catch (err) {
                    await pool.query(`ROLLBACK`);
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

        const result = await pool.query(`SELECT * FROM ${table}${order} LIMIT 4000;`);
        
        if (result.rows.length < 1) {
            res.send({name: "No results"})
            return;
        }
        res.send(result.rows)
    }
    catch (err) {
        console.log(err)
        res.send(err)
    }

});

app.get("/api/delete/:table", async(req, res) => {

    try {
        const table = req.params.table;
        await pool.query(`DELETE FROM ${table}`);
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
        await pool.query(`DROP TABLE ${table}`);
        res.send("table dropped")
    }
    catch (err) {
        console.log(err)
        res.send(err)
    }
});

app.post("/api/createAccount", async (req,res) => {

    try {

        const accountSSN = req.body.accountSSN;
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

        await pool.query(`BEGIN;`);

        await pool.query(`
            INSERT into account VALUES
            ('${accountSSN}', '${planType}', '${autoPayment}', '${streetAddress}', '${city}', '${state}', '${zipCode}');
        `)

        await pool.query(`
            INSERT into customer VALUES
            ('${firstName}', '${lastName}', '${accountSSN}', '${dob}', '${accountSSN}');
        `)

        var phone_number = generateNumber(10)

        await pool.query(`
            INSERT into phone_number VALUES
            ('${phone_number}', '${accountSSN}');
        `)

        await pool.query(`
            INSERT into phone_model VALUES
            ('${phone_number}', '${phoneModel}');
        `)

        await pool.query(`COMMIT;`);
        await pool.query(`END;`);

        res.send('')

    } catch (err) {
        await pool.query('ROLLBACK');
        console.log("Error 8: " + err.code)
        res.send(err.code)
        return;
    }

})

app.get("/api/planRates/:plan", async (req,res) => {

    try {
        const plan = req.params.plan;
        console.log(plan)
        const result = await pool.query(`
            SELECT (call_price_cents / 100.00)::MONEY as callprice, (data_price_cents / 100.00)::MONEY as dataprice FROM plan
            WHERE plan_name = '${plan}';
        `);
        console.log([result.rows[0].callprice, result.rows[0].dataprice]);
        res.send([result.rows[0].callprice, result.rows[0].dataprice]);

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
        const result = await pool.query(`
            SELECT number, first_name, last_name, account_holder_ssn FROM customer
            JOIN phone_number ON customer.ssn = phone_number.user_ssn
            WHERE UPPER(${searchColumn}) LIKE UPPER('${input}%')
        `, []);
        // queries.write(`SELECT number, first_name, last_name, account_holder_ssn FROM customer\n`)
        // queries.write(`JOIN phone_number ON customer.ssn = phone_number.user_ssn\n`)
        // queries.write(`WHERE UPPER(${searchColumn}) LIKE UPPER('${input}%');\n\n`)

        var accounts = []

        for(var i = 0; i < result.rows.length; i++) {
            accounts.push([
                result.rows[i].number,
                result.rows[i].first_name,
                result.rows[i].last_name,
                result.rows[i].account_holder_ssn
            ])
        }
        console.log("Accounts: " + result.rows.length)
        res.send(accounts);

    } catch (err) {
        console.log("Error: " + err.message)
        return res.status(500).send("Error: " + err.message);
    }
    
})

app.get("/api/accountDetails/:accountSSN", async (req, res) => {

    try {
        const ssn = req.params.accountSSN;
        console.log(ssn)

        const account = await pool.query(`
            SELECT account.account_ssn, first_name, last_name, street_address, city, st, zip_code, plan_type, balance_cents FROM account
            JOIN customer ON customer.ssn = account.account_ssn
            WHERE account.account_ssn = '${ssn}'
        `, []);

        // const call = await pool.query(`
        //     SELECT SUM(call_length_mins * call_price_cents / 100.00)::MONEY as call_cost FROM account
        //     JOIN plan ON plan_type = plan_name
        //     JOIN customer ON customer.account_holder_ssn = account.account_ssn
        //     JOIN phone_number ON customer.ssn = phone_number.user_ssn
        //     JOIN call ON phone_number.number = call.call_from OR phone_number.number = call.call_to
        //     WHERE account.account_ssn = '${ssn}'     
        // `, []);

        // const data = await pool.query(`
        //     SELECT SUM(mb_used * data_price_cents / 100.00)::MONEY as data_cost FROM account
        //     JOIN plan ON plan_type = plan_name
        //     JOIN customer ON customer.account_holder_ssn = account.account_ssn
        //     JOIN phone_number ON customer.ssn = phone_number.user_ssn
        //     JOIN data ON phone_number.number = data.phone_number
        //     WHERE account.account_ssn = '${ssn}'
        // `, []);

        // const payment = await pool.query(`
        //     SELECT sum(amount) as amount_paid FROM payment
        //     JOIN account ON payment.account_holder_ssn = account.account_ssn
        //     WHERE account.account_ssn = '${ssn}'
        // `, []);

        var row = []

        // var balance = Number(payment.rows[0].amount_paid) - (Number(call.rows[0].call_cost) + Number(data.rows[0].data_cost));

        row.push(
            account.rows[0].plan_type,
            account.rows[0].street_address,
            account.rows[0].city,
            account.rows[0].st,
            account.rows[0].zip_code
        )

        res.send(row);

    } catch (err) {
        console.log("Error: " + err.message)
        return res.status(500).send("Error: " + err.message);
    }

})

app.get("/api/accountBill", async (req, res) => {

    try {

        const ssn = req.query.accountNumber;
        const tableName = req.query.tableName;

        const result = await pool.query(`
            SELECT (balance_cents / 100.00)::MONEY as balancedollars FROM ${tableName}
            WHERE account_ssn = '${ssn}';
        `)

        console.log("Account Bill: " + result.rows[0].balancedollars)
        res.send(result.rows[0].balancedollars);

    } catch (err) {
        console.log("Error: " + err.message)
    }

})

app.get("/api/accountLines/:accountSSN", async (req, res) => {

    try {
        const ssn = req.params.accountSSN;
        console.log("Account Lines: " + ssn)

        const result = await pool.query(`
            WITH calls AS (
                SELECT number, first_name, last_name, TO_CHAR(SUM(COALESCE(call_length_mins, 0)), 'fm999G999') as minutes
                FROM customer
                JOIN phone_number ON customer.ssn = phone_number.user_ssn
                LEFT JOIN call ON phone_number.number = call.call_from OR phone_number.number = call.call_to
                WHERE account_holder_ssn = '${ssn}'
                GROUP BY number, first_name, last_name
            ),
            dataUsed AS (
                SELECT phone_number, TO_CHAR(SUM(mb_used), 'fm999G999') as data_used
                FROM data
                GROUP BY phone_number
            )
            SELECT number, model, first_name, last_name, minutes, COALESCE(data_used, '0') as data_used
            FROM calls
            LEFT JOIN dataUsed ON calls.number = dataUsed.phone_number
            JOIN phone_model ON calls.number = phone_model.phone_number;
        `, []);

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

    } catch (err) {
        console.log("Error: " + err.message)
        return res.send("Error: " + err.message);
    }

});

app.post("/api/makePayment", async (req,res) => {

    try {

        const accountSSN = req.body.accountSSN;
        const paymentAmount = Math.floor(Number(req.body.paymentAmount) * 100);

        console.log("Payment: " + paymentAmount)

        const date = new Date();

        let day = date.getDate();
        let month = date.getMonth() + 1;
        let year = date.getFullYear();

        await pool.query(`BEGIN`);

        await payment(`${year}-${month}-${day}`, paymentAmount, accountSSN);
        const balance = chargeBalance(paymentAmount, accountSSN)
        .then(function (result) {
            console.log("Balance result: " + result)
            res.send(result)
            return result;
        })

        await pool.query(`COMMIT`);
        await pool.query(`END`);

        return;

    } catch (err) {
        console.log("Error on Making Payment: " + err.message)
        res.send(err.message)
        return;
    }

})

app.get("/api/getPayments", async(req,res) => {

    try {

        const ssn = req.query.accountSSN;

        const results = await pool.query(`
            SELECT payment_date::DATE as Date, (amount_cents / 100.00)::MONEY as Payment 
            FROM payment 
            where account_holder_ssn = '${ssn}'
            ORDER BY Date DESC;
        `)

        res.send(results.rows)

    } catch (err) {
        return;
    }
})

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});