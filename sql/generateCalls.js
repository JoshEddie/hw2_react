const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3002;

const creds = require('../creds.json');
const pool = new Pool(creds);

app.get('/', async (req, res) => {

    const numbersResult = await pool.query(`
        SELECT number FROM phone_number
        `)

    for (var i = 0; i < numbersResult.rows.length; i++) {

        var number_of_calls = Math.round(Math.random() * (1000 - 5) + 5);
        console.log("Phone: " + numbersResult.rows[i].number + " calls made: " + number_of_calls);

        for(var j = 0; j < number_of_calls; j++) {

            var phone_to = 0;

            do {
                phone_to = Math.round(Math.random() * numbersResult.rows.length);
            } while(i === phone_to);

            var call_length = Math.round(1440 / (Math.random() * 1440 + 1))

            var year = (Math.round(Math.random() * (2023 - 2020) + 2020)).toString();
            var month = (Math.round(Math.random() * 12 + 1)).toString().padStart(2, '0');
            var day = (Math.round(Math.random() * 30 + 1)).toString().padStart(2, '0');

            try {

                var phone_to_array = [numbersResult.rows[phone_to].number,
                        Math.floor(Math.random() * 9 + 1).toString() + Math.floor(Math.random() * 100000000).toString().padStart(9, '0'),
                        Math.floor(Math.random() * 9 + 1).toString() + Math.floor(Math.random() * 100000000).toString().padStart(9, '0')
                    ]

                await pool.query(`
                START TRANSACTION;

                INSERT INTO call (call_from, call_to, call_length_mins, call_date)
                VALUES('${numbersResult.rows[i].number}', '${numbersResult.rows[phone_to].number}', ${call_length}, DATE '${year}-${month}-${day}');

                END TRANSACTION;
            `)
            } catch (err) {
                
            }


        }

    }

});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});