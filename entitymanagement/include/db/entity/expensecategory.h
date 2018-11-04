#ifndef EXPENSECATEGORY_H
#define EXPENSECATEGORY_H

#include <QString>

#include "entity.h"
#include "entitymanagement_global.h"

class ENTITYMANAGEMENTSHARED_EXPORT ExpenseCategory : public Entity
{
    Q_OBJECT
    QML_WRITABLE_VAR_PROPERTY(QString, name)
    QML_WRITABLE_VAR_PROPERTY(QString, description)

public:
    ExpenseCategory(QObject* parent = Q_NULLPTR);

    virtual ~ExpenseCategory();

// Entity interface
public:
    QString entityName();
};

#endif // EXPENSECATEGORY_H
