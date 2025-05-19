const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const multer = require('multer');
const upload = multer();

const productRoute = require('./routes/api/productRoute');

// Connecting to the Database
let mongodb_url = 'mongodb://mongodb:27017/';
let dbName = 'yolomy';
// define a url to connect to the database
const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://mongodb-service:27017/yolomy'; // Corrected connection string
mongoose.connect(MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true });
let db = mongoose.connection;

// Check Connection
db.once('open', () => {
  console.log('Database connected successfully');
});
// Check for DB Errors
db.on('error', (error) => {
  console.log(error);
});

// Initializing express
const app = express();

// Body parser middleware
app.use(express.json());

//
app.use(upload.array());

// Cors
app.use(cors());
// Use Route
app.use('/api/products', productRoute);

//  Add this route handler for the root path ("/")
app.get('/', (req, res) => {
  res.send('Welcome to my Yolo Application!'); //  <---  Customize this message
});

// Corrected /health endpoint
app.get('/health', (req, res) => {
  res.sendStatus(200); // Respond with a simple 200 OK status
});

// Define the PORT
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
