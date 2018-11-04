CREATE TABLE IF NOT EXISTS expense (
    id INTEGER PRIMARY KEY,
    category_id INTEGER NOT NULL,
    expenseDate DATE NOT NULL,
    amount DOUBLE NOT NULL,
    description TEXT,
    FOREIGN KEY(category_id) REFERENCES expense_category(id)
);
