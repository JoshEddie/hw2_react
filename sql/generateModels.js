const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3002;

const creds = require('../creds.json');
const pool = new Pool(creds);

var models = [
        "iPhone 15",
        "iPhone 15 Plus",
        "iPhone 15 Pro",
        "iPhone 15 Pro Max",
        "iPhone 14",
        "iPhone 14 Plus",
        "iPhone 14 Pro",
        "iPhone 14 Pro Max",
        "iPhone 13",
        "iPhone 13 Mini",
        "iPhone 13 Pro",
        "iPhone 13 Pro Max",
        "iPhone 12",
        "iPhone 12 Mini",
        "iPhone 12 Pro",
        "iPhone 12 Pro Max",
        "iPhone 11",
        "iPhone 11 Pro",
        "iPhone 11 Pro Max",
        "iPhone SE",
        "Galaxy Z Fold 5",
        "Galaxy Z Flip 5",
        "Galaxy S23 Ultra",
        "Galaxy S23+",
        "Galaxy S23",
        "Galaxy A54",
        "Galaxy A34",
        "Galaxy A24",
        "Galaxy A14",
        "Galaxy A04s",
        "Galaxy A04",
        "Galaxy M54",
        "Galaxy M34",
        "Galaxy M14",
        "Galaxy M04",
        "Pixel 8",
        "Pixel 8 Pro",
        "Pixel 7",
        "Pixel 7 Pro",
        "Pixel 7a",
        "Pixel 6",
        "Pixel 6 Pro",
        "Pixel 6a",
        "Pixel Fold",
        "Pixel 5",
        "Pixel 5a"
    ]



app.get('/', async (req, res) => {

    const numbersResult = await pool.query(`
        SELECT number FROM phone_number
        `)

    for (var i = 0; i < numbersResult.rows.length; i++) {

        var number = Math.round(Math.random() * (models.length - 1));
        var model = models[number];

        console.log(model)

        try {

            await pool.query(`
            START TRANSACTION;

            INSERT INTO phone_model
            VALUES('${numbersResult.rows[i].number}', '${model}');

            COMMIT;

            END TRANSACTION;
        `)
        } catch (err) {
            
        }

    }

});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});