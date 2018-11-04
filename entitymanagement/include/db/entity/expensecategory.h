#ifndef EXPENSECATEGORY_H
#define EXPENSECATEGORY_H

#include <QString>

#include "entity.h"
#include "entitymanagement_global.h"

class ENTITYMANAGEMENTSHARED_EXPORT ExpenseCategory : public Entity
{
public:
    ExpenseCategory() = default;

    QString name() const;
    void setName(const QString &name);

    QString description() const;
    void setDescription(const QString &description);

private:
    QString m_name;
    QString m_description;

// Entity interface
public:
    QString entityName();
};

#endif // EXPENSECATEGORY_H
