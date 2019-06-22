CREATE TABLE IF NOT EXISTS translation (
    id           INTEGER PRIMARY KEY,
    language_id  INTEGER NOT NULL,
    data         TEXT,

    FOREIGN KEY(language_id)  REFERENCES language(id)
);
