const express = require('express');
const path = require('path');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
require('dotenv').config();

const ADMIN_USER = process.env.ADMIN_USER;
const ADMIN_HASH = process.env.ADMIN_HASH;
const JWT_SECRET = process.env.JWT_SECRET;
const app = express();
const BASE = '/template_app'; // PATH ENDPOINT
const PORT = 3000;

// CORS middleware
app.use(cors());

// Middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// static files (js, css, images, favicon, etc)
app.use(BASE, express.static(path.join(__dirname)));

// login page
app.get(`${BASE}/`, (req, res) => {
    res.sendFile(path.join(__dirname, 'login.html'));
});
app.get(`${BASE}/login.html`, (req, res) => {
    res.sendFile(path.join(__dirname, 'login.html'));
});


// main application page
app.get(`${BASE}/app`, (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});
app.get(`${BASE}/index.html`, (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// API login endpoint
app.post(`${BASE}/api/login`, async (req, res) => {
    const { username, password } = req.body;
    if (username !== ADMIN_USER) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    try {
      const match = await bcrypt.compare(password, ADMIN_HASH);
      if (match) {
        const token = jwt.sign({ username }, JWT_SECRET, { expiresIn: '1h' });
        return res.json({ token });
      }
    } catch (e) {
      // fall through to error
    }
    res.status(401).json({ error: 'Invalid credentials' });
});


app.get(new RegExp(`^${BASE}(/.*)?$`), (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/', (req, res) => {
    res.redirect(`${BASE}/`);
});


app.listen(PORT, '0.0.0.0', () => {
    const interfaces = require('os').networkInterfaces();
    const addresses = [];
    
    for (const k in interfaces) {
      for (const addr of interfaces[k]) {
        if (addr.family === 'IPv4' && !addr.internal) {
          addresses.push(addr.address);
        }
      }
    }
    
    console.log('Server online on:');
    console.log(`- http://localhost:${PORT}${BASE}/`);
    addresses.forEach(addr => console.log(`- http://${addr}:${PORT}${BASE}/`));
  });