const sqlite3 = require('sqlite3').verbose();
const path = require('path');

// Reference the DB_PATH from .env
const dbPath = process.env.DB_PATH || './database.sqlite';

const db = new sqlite3.Database(dbPath, (err) => {
  if (err) console.error('DB Connection Error:', err.message);
});

db.serialize(() => {
  db.run(`CREATE TABLE IF NOT EXISTS items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
    )`);
});

module.exports = db;
