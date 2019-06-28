CREATE TABLE IF NOT EXISTS currency_translation (
    id              INTEGER PRIMARY KEY,
    currency_id     INTEGER NOT NULL,
    translation_id  INTEGER NOT NULL,

    FOREIGN KEY(currency_id) REFERENCES currency(id),
    FOREIGN KEY(translation_id) REFERENCES translation(id)
 )
