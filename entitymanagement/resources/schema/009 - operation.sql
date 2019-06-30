CREATE TABLE IF NOT EXISTS operation (
    id INTEGER PRIMARY KEY,
    type_id INTEGER NOT NULL,
    timestamp DATE NOT NULL,
    currency_id INTEGER NOT NULL,
    FOREIGN KEY(type_id) REFERENCES operation_type(id),
    FOREIGN KEY(currency_id) REFERENCES currency(id)
);
