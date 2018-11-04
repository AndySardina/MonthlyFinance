#ifndef EXPENSE_H
#define EXPENSE_H

#include <QDate>
#include <QString>

#include "entity.h"
#include "entitymanagement_global.h"
#include "expensecategory.h"

class ENTITYMANAGEMENTSHARED_EXPORT Expense : public Entity
{
public:
    Expense() = default;

public:
    std::shared_ptr<ExpenseCategory> category() const;
    void setCategory(const std::shared_ptr<ExpenseCategory> &category);

    QDate date() const;
    void setDate(const QDate &date);

    double amount() const;
    void setAmount(double amount);

    QString description() const;
    void setDescription(const QString &description);

private:
    std::shared_ptr<ExpenseCategory> m_category;
    QDate m_date;
    double m_amount;
    QString m_description;

// Entity interface
public:
    QString entityName();
};

#endif // EXPENSE_H
