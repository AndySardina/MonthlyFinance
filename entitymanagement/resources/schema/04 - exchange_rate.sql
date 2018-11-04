CREATE TABLE IF NOT EXISTS exchange_rate (
    id INTEGER PRIMARY KEY,
    base_currency INTEGER NOT NULL,
    currency INTEGER NOT NULL,
    FOREIGN KEY(base_currency) REFERENCES currency(id),
    FOREIGN KEY(currency) REFERENCES currency(id)
);
