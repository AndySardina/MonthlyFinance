#ifndef CURRENCY_H
#define CURRENCY_H

#include "entity.h"
#include "entitymanagement_global.h"

#include <QString>

class ENTITYMANAGEMENTSHARED_EXPORT Currency : public Entity
{
public:
    Currency() = default;

    QString name() const;
    void setName(const QString &name);

private:
    QString m_name;

    // Entity interface
public:
    QString entityName();
};

#endif // CURRENCY_H
