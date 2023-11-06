//Download nodejs(https://nodejs.org/en/download)
//Run following command to install libraries: npm install express pg
//Alter ./creds.json with your local psql credentials
//Start server using command: node hw2.js
//Open browser and go to http://localhost:3000/;

const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3002;

const creds = require('../creds.json');
const pool = new Pool(creds);

app.get('/', async (req, res) => {

    var phone_number = "";
    var ssn = "";

    const result = await pool.query(`
        SELECT ssn FROM customer
        `)

    for (var i = 0; i < result.rows.length; i++) {

        ssn = result.rows[i].ssn;
        phone_number = Math.floor(Math.random() * 9 + 1).toString() + Math.floor(Math.random() * 100000000).toString().padStart(9, '0')
        console.log(result.rows[i].ssn + " - (" + phone_number.slice(0,3) + ") " + phone_number.slice(3,6) + "-" + phone_number.slice(6));
        
        console.log(ssn.length)
        console.log(phone_number.length)
        // console.log(first_name + " " + last_name + " " + dob + " " + ssn + " " + accountssn)
        const insert = await pool.query(`
            INSERT INTO phone_number VALUES
            ($1, $2);
        `, [phone_number, ssn]);
    }
    // try {
    //     const result = await pool.query(`
    //         SELECT t.*, p.name AS product_name, p.price AS product_price, c.name AS customer_name 
    //         FROM transactions t 
    //         JOIN product p ON t.product_id = p.product_id 
    //         JOIN customer c ON t.customer_id = c.customer_id
    //         WHERE t.customer_id = $1
    //     `, [customerId]);

    //     if (result.rows.length > 0) {
    //         customerName = result.rows[0].customer_name; 
    //         transactionsHtml = result.rows.map(row => {
    //             totalPrice += row.product_price;
    //             return `<p>ID: ${row.t_id}, Product: ${row.product_name}, Price: ${row.product_price}, Date: ${row.transaction_date}</p>`;
    //         }).join('');
    //     }
    // } catch (err) {
    //     return res.status(500).send("Error: " + err.message);
    // }
    
    res.send(`
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Transactions</title>
        </head>
        <body>
            <div>
                <h3>Customers Randomly Created</h3>
            </div>
        </body>
        </html>
    `);
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});

