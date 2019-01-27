CREATE TABLE IF NOT EXISTS currency (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    numeric_code INTEGER,
    alphabetic_code INTEGER NOT NULL
);
