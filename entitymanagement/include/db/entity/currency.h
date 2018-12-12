#ifndef CURRENCY_H
#define CURRENCY_H

#include "entity.h"

#include <QString>

class ENTITYMANAGEMENTSHARED_EXPORT Currency : public Entity
{
    Q_OBJECT
    DSL_WRITABLE_CSTREF_PROPERTY(QString, name)

public:
    Currency(QObject * parent = Q_NULLPTR): Entity(parent){}

     ~Currency() override = default;
};

#endif // CURRENCY_H
