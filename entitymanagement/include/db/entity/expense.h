#ifndef EXPENSE_H
#define EXPENSE_H

#include <QDate>
#include <QString>

#include "entity.h"
#include "entitymanagement_global.h"
#include "expensecategory.h"

class ENTITYMANAGEMENTSHARED_EXPORT Expense : public Entity
{
    Q_OBJECT
    QML_WRITABLE_VAR_PROPERTY(ExpenseCategory*, category)
    QML_WRITABLE_VAR_PROPERTY(QDate, date)
    QML_WRITABLE_VAR_PROPERTY(double, amount)
    QML_WRITABLE_VAR_PROPERTY(QString, description)

public:
    Expense(QObject * parent = Q_NULLPTR);

    virtual ~Expense();

// Entity interface
public:
    virtual QString entityName();
};

#endif // EXPENSE_H
