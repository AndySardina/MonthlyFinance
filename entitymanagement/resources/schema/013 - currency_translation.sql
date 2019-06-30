CREATE TABLE IF NOT EXISTS currency_translation (
    id               INTEGER PRIMARY KEY,
    currency_id      CHAR NOT NULL,
    translation_id   VARCHAR(20) NOT NULL,

    FOREIGN KEY(currency_id)     REFERENCES currency(id),
    FOREIGN KEY(translation_id)  REFERENCES translation(id)
);