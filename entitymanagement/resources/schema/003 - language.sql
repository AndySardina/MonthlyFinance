CREATE TABLE IF NOT EXISTS language (
    id           INTEGER PRIMARY KEY,
    name         VARCHAR(60) NOT NULL,
    type         INTEGER NOT NULL, 
    scope        INTEGER NOT NULL, 
    iso_6393     CHAR(3) NOT NULL, 
    iso_6392_B   CHAR(3) NOT NULL, 
    iso_6392_T   CHAR(3) NOT NULL, 
    iso_6391     CHAR(2) NOT NULL,

    FOREIGN KEY(type)  REFERENCES language_type(id),
    FOREIGN KEY(scope) REFERENCES language_scope(id)
);