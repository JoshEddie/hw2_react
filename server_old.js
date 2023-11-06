//Download nodejs(https://nodejs.org/en/download)
//Run following command to install libraries: npm install express pg
//Alter ./creds.json with your local psql credentials
//Start server using command: node hw2.js
//Open browser and go to http://localhost:3002/;

const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3002;

const creds = require('./creds.json');
const pool = new Pool(creds);

app.use(express.json())
app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Access-Control-Allow-Headers');
  next();
});

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

app.get("/api/planRates/:plan", async (req,res) => {

    try {
        const plan = req.params.plan;
        const result = await pool.query(`
            SELECT call_price, data_price FROM plan
            WHERE plan_name = '${plan}';
        `);

        console.log("Call price: " + result.rows[0].call_price + " & Data Price: " + result.rows[0].data_price)
        res.send([result.rows[0].call_price, result.rows[0].data_price]);

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

        //WHERE ssn = customer.account_holder_ssn

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

        // const result = await pool.query(`
        // SELECT account.account_holder_ssn, first_name, last_name, street_address, city, st, zip_code, plan_type FROM account
        // JOIN customer ON customer.ssn = account.account_holder_ssn
        // WHERE account.account_holder_ssn = '${ssn}'  
        // `, []);

        const account = await pool.query(`
            SELECT account.account_holder_ssn, first_name, last_name, street_address, city, st, zip_code, plan_type FROM account
            JOIN customer ON customer.ssn = account.account_holder_ssn
            WHERE account.account_holder_ssn = '${ssn}'
        `, []);

        const call = await pool.query(`
            SELECT round( CAST(sum(call_length_mins * call_price) as numeric), 2) as call_cost FROM account
            JOIN plan ON plan_type = plan_name
            JOIN customer ON customer.account_holder_ssn = account.account_holder_ssn
            JOIN phone_number ON customer.ssn = phone_number.user_ssn
            JOIN call ON phone_number.number = call.call_from OR phone_number.number = call.call_to
            WHERE account.account_holder_ssn = '${ssn}'     
        `, []);

        const data = await pool.query(`
            SELECT round( CAST(sum(mb_used * data_price) as numeric), 2) as data_cost FROM account
            JOIN plan ON plan_type = plan_name
            JOIN customer ON customer.account_holder_ssn = account.account_holder_ssn
            JOIN phone_number ON customer.ssn = phone_number.user_ssn
            JOIN data ON phone_number.number = data.phone_number
            WHERE account.account_holder_ssn = '${ssn}'
        `, []);

        const payment = await pool.query(`
            SELECT sum(amount) as amount_paid FROM payment
            JOIN account ON payment.account_holder_ssn = account.account_holder_ssn
            WHERE account.account_holder_ssn = '${ssn}'
        `, []);

        var row = []

        var balance = Number(payment.rows[0].amount_paid) - (Number(call.rows[0].call_cost) + Number(data.rows[0].data_cost));

        row.push(
            account.rows[0].street_address + " " + account.rows[0].city + " " + account.rows[0].st + " " + account.rows[0].zip_code,
            account.rows[0].plan_type,
            call.rows[0].call_cost,
            data.rows[0].data_cost,
            balance
        )

        res.send(row);

    } catch (err) {
        console.log("Error: " + err.message)
        return res.status(500).send("Error: " + err.message);
    }

})

app.get("/api/accountLines/:accountSSN", async (req, res) => {

    try {
        const ssn = req.params.accountSSN;
        console.log("Account Lines: " + ssn)

        const result = await pool.query(`
            SELECT a.number, a.first_name, a.last_name, a.minutes, sum(mb_used) as data_used, model FROM (
                SELECT number, first_name, last_name, sum(call_length_mins) as minutes
                FROM customer
                JOIN phone_number ON customer.ssn = phone_number.user_ssn
                JOIN call ON phone_number.number = call.call_from OR phone_number.number = call.call_to
                WHERE account_holder_ssn = '${ssn}'
                GROUP BY number, first_name, last_name
            ) a
            JOIN data ON a.number = data.phone_number
            JOIN phone_model ON a.number = phone_model.phone_number
            GROUP BY a.number, a.first_name, a.last_name, a.minutes, model;
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
        return res.status(500).send("Error: " + err.message);
    }

});

app.get("/api/getMinutes/:number", async (req,res) => {

    try {
        const number = req.params.number;
        const result = await pool.query(`
            SELECT sum(call_length_mins) FROM call
            JOIN phone_number on phone_number.number = call_from 
            OR phone_number.number = call_to
            WHERE phone_number.number = '${number}'; 
        `, []);
        
        res.send(result.rows[0].sum)

    } catch (err) {
        console.log("Error: " + err.message)
        return res.status(500).send("Error: " + err.message);
    }

});

app.post("/api/createAccount", async (req,res) => {

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

    var phone_number = Math.floor(Math.random() * 9 + 1).toString() + Math.floor(Math.random() * 1000000000).toString().padStart(9, '0')

    console.log(accountSSN + '\n'
                + planType + '\n'
                + autoPayment + '\n'
                + streetAddress + '\n'
                + city + '\n'
                + state + '\n'
                + zipCode + '\n'
                + firstName + '\n'
                + lastName + '\n'
                + dob + '\n'
                + phone_number)

    try {

        const createAccountTransaction = await pool.query(`
            START TRANSACTION;

            INSERT into account VALUES
            ('${accountSSN}', '${planType}', '${autoPayment}', '${streetAddress}', '${city}', '${state}', '${zipCode}');

            INSERT into customer VALUES
            ('${firstName}', '${lastName}', '${accountSSN}', '${dob}', '${accountSSN}');

            INSERT into phone_number VALUES
            ('${phone_number}', '${accountSSN}');

            COMMIT;

            END TRANSACTION;
        `)

    } catch (err) {
        console.log("Error on CREATING ACCOUNT: " + err.message)
        return;
    }

})

app.post("/api/makePayment", async (req,res) => {

    const accountSSN = req.body.accountSSN;
    const paymentAmount = req.body.paymentAmount;

    console.log(accountSSN + '\n'
                + paymentAmount)

    try {

        const makePaymentTransaction = await pool.query(`
            START TRANSACTION;

            INSERT into payment (payment_date, amount, account_holder_ssn)
            VALUES (current_timestamp, ${Number(paymentAmount)}, '${accountSSN}');

            COMMIT;

            END TRANSACTION;
        `)

    } catch (err) {
        console.log("Error on Making Payment: " + err.message)
        return;
    }

})

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});

