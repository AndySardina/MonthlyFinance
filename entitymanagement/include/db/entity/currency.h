#ifndef CURRENCY_H
#define CURRENCY_H

#include "entity.h"

#include <QString>

class ENTITYMANAGEMENTSHARED_EXPORT Currency : public Entity
{
    Q_OBJECT
    QML_WRITABLE_VAR_PROPERTY(QString, name)

public:
    Currency(QObject * parent = Q_NULLPTR);

    virtual ~Currency();

    // Entity interface
public:
    virtual QString entityName();
};

#endif // CURRENCY_H
