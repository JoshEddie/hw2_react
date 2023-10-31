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
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3000');
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

app.get("/api/accounts/:number", async (req,res) => {
    try {
        const number = req.params.number;
        console.log("Search for number: " + number)
        const result = await pool.query(`
            SELECT number, first_name, last_name, account_holder_ssn FROM customer
            JOIN phone_number ON customer.ssn = phone_number.user_ssn
            WHERE UPPER(number) LIKE UPPER('${number}%')
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
        const accountQuery = await pool.query(`
            INSERT into account VALUES
            ('${accountSSN}', 'false', '${autoPayment}', '${streetAddress}', '${city}', '${state}', '${zipCode}')
        `, []);
    } catch (err) {
        console.log("Error on account insert: " + res.statusCode)
        res.send("Test");
        // return res.status(500).send("Error: " + err.message);
        return;
    }
    try {
        const customerQuery = await pool.query(`
            INSERT into customer VALUES
            ('${firstName}', '${lastName}', '${accountSSN}', '${dob}', '${accountSSN}')
        `, []);
    } catch (err) {
        console.log("Error on customer insert: " + err.message)
        return;
    }
    try {
        const phoneQuery = await pool.query(`
            INSERT into phone_number VALUES
            ('${phone_number}', '${accountSSN}')
        `, []);

    } catch (err) {
        console.log("Error on phone insert: " + err.message)
        return;
    }


})

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});

