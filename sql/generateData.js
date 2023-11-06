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

        var data_instances = Math.round(Math.random() * (1000 - 5) + 5);
        // console.log("Phone: " + numbersResult.rows[i].number + " calls made: " + number_of_calls);

        for(var j = 0; j < data_instances; j++) {

            var mb_used = Math.round(1440 / (Math.random() * 1440 + 1))

            var year = (Math.round(Math.random() * (2023 - 2020) + 2020)).toString();
            var month = (Math.round(Math.random() * (12 - 1) + 1)).toString().padStart(2, '0');
            var day = (Math.round(Math.random() * (31 - 1) + 1)).toString().padStart(2, '0');
            // console.log(year + month + day)

            try {
                await pool.query(`
                START TRANSACTION;

                INSERT INTO data (phone_number, mb_used, data_date)
                VALUES('${numbersResult.rows[i].number}', ${mb_used}, DATE '${year}-${month}-${day}');

                COMMIT;

                END TRANSACTION;
            `)
            } catch (err) {
                console.log("Error " + err)
            }


        }

    }

});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});