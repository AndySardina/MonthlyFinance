CREATE TABLE IF NOT EXISTS currency (
    id                INTEGER PRIMARY KEY,
    numeric_code      INTEGER NOT NULL,
    alphabetic_code   CHAR(3)
);
