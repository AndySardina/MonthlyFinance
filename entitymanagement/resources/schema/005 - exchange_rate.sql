CREATE TABLE IF NOT EXISTS exchange_rate (
    id INTEGER PRIMARY KEY,
    currency_from INTEGER NOT NULL,
    currency_to INTEGER NOT NULL,
    timestamp DATE NOT NULL,
    amount REAL NOT NULL,
    FOREIGN KEY(currency_from) REFERENCES currency(id),
    FOREIGN KEY(currency_to) REFERENCES currency(id)
);
