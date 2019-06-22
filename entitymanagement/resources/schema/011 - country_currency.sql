CREATE TABLE IF NOT EXISTS country_currency (
    id             INTEGER PRIMARY KEY,
    country_code   INTEGER NOT NULL,
    currency_code  INTEGER NOT NULL,
    FOREIGN KEY(country_code) REFERENCES country(id),
    FOREIGN KEY(currency_code) REFERENCES currency(id)
 )
