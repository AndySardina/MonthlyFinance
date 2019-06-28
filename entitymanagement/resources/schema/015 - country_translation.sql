CREATE TABLE IF NOT EXISTS country_translation (
    id              INTEGER PRIMARY KEY,
    country_id      INTEGER NOT NULL,
    translation_id  INTEGER NOT NULL,

    FOREIGN KEY(country_id) REFERENCES country(id),
    FOREIGN KEY(translation_id) REFERENCES translation(id)
 )
