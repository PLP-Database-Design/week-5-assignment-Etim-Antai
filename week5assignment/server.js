// Importig dependencies
// framework for handling HTTP requests and responses
const express = require('express');

// creating the instance of the framework
const app = express();

// Database management library for MySQL
const mysql = require('mysql2');

// cross respource originsharing 
const cors = require('cors');

// Environment variables document
const dotenv = require('dotenv');

//configuring the environment variables
dotenv.config();

// Configuring the database connection 
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

// Testing the connection to the database and handling errors
db.connect((err) => {
    if (err) {
        // if there is an error, log it and exit the program
        return console.error('Error connecting to database, check your codes: ', err);

    }
    // if connection is successful, log it to the console
    console.log('Connected to database successfully, congratulations!', db.threadId);
});

// QUESTION 1. Retrieve all patients


app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');


app.get('/patients', (req, res) => {
    db.query("SELECT patient_id, first_name, last_name, date_of_birth FROM patients  ", (err, data) => {
        if (err) {
            console.error(err);
            res.status(400).send("Failed to retrieve patients", err)
        }
        else {
            res.render('patients', { data: data })
        }
    });
}); // end of get endpoint

// QUESTION 2. Retrieve all providers
// Create a GET endpoint that displays all providers with their:
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');

app.get('/providers', (req, res) => {
    db.query("SELECT first_name, last_name, provider_specialty FROM providers  ", (err, results) => {
        if (err) {
            console.error(err);
            res.status(400).send("Failed to retrieve providers", err)
        }
        else {
            res.render('providers', { results: results })
        }
    });
}); // end of get endpoint


// QUESTION 3. Filter patients by First Name
// Create a GET endpoint that retrieves all patients by their first name
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');

app.get('/patient_firstname', (req, res) => {
    db.query("SELECT first_name FROM patients", (err, data) => {
        if (err) {
            console.error(err);
            res.status(400).send("Failed to retrieve first names", err);
        } else {
            return res.render('patient_firstname', { data: data });
        }
    });
}); // end of get endpoint


// end of get endpoint
// QUESTION 4. Retrieve all providers by their specialty
// a pediatric specialty
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');

app.get('/specialty/pediatrics', (req, res) => {
    db.query("SELECT first_name, last_name, provider_specialty FROM providers where provider_specialty = 'pediatrics'", (err, results) => {
        if (err) {
            console.error(err);
            res.status(400).send("Failed to retrieve specialties", err);
        } else {
            return res.render('specialty', { results: results });
        }
    });
}); // end of get endpoint

// b surgical specialty


app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');

app.get('/specialty/surgery', (req, res) => {
    db.query("SELECT first_name, last_name, provider_specialty FROM providers where provider_specialty = 'surgery'", (err, results) => {
        if (err) {
            console.error(err);
            res.status(400).send("Failed to retrieve specialties", err);
        } else {
            return res.render('specialty', { results: results });
        }
    });
}); // end of get endpoint

// c cardiology specialty


app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');

app.get('/specialty/cardiology', (req, res) => {
    db.query("SELECT first_name, last_name, provider_specialty FROM providers where provider_specialty = 'cardiology'", (err, results) => {
        if (err) {
            console.error(err);
            res.status(400).send("Failed to retrieve specialties", err);
        } else {
            return res.render('specialty', { results: results });
        }
    });
}); // end of get endpoint

// d primary care specialty

app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');

app.get('/specialty/primaryCare', (req, res) => {
    db.query("SELECT first_name, last_name, provider_specialty FROM providers where provider_specialty = 'primaryCare'", (err, results) => {
        if (err) {
            console.error(err);
            res.status(400).send("Failed to retrieve specialties", err);
        } else {
            return res.render('specialty', { results: results });
        }
    });
}); // end of get endpoint




// listening to the server
const PORT = process.env.PORT // fron .env file
app.listen(PORT, () => {
    console.log(`server is runnig on http://localhost:${PORT}`)
})




// select all providers from the providers table 
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');

app.get('/provider_all', (req, res) => {
    db.query("SELECT * FROM providers", (err, results) => {
        if (err) {
            console.error(err);
            res.status(400).send("Failed to retrieve providers", err);
        } else {
            return res.render('providers', { results: results });
        }
    });
}); // end of get endpoint

