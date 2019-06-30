CREATE TABLE IF NOT EXISTS invoice (
    id INTEGER PRIMARY KEY,
    element_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    quantity TEXT NOT NULL,
    FOREIGN KEY(element_id) REFERENCES element(id)
);
