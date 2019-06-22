CREATE TABLE IF NOT EXISTS country (
    id            INTEGER PRIMARY KEY,
    name          TEXT NOT NULL,
    officialName  TEXT NOT NULL,
    ccn3          INTEGER,
    cca3          TEXT NOT NULL,
    callingCode   INTEGER,
    capital       TEXT,
    region        TEXT,
    subregion     TEXT
)
