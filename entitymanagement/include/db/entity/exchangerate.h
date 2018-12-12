#ifndef EXCHANGERATE_H
#define EXCHANGERATE_H

#include "entity.h"

#include <QDate>

class ENTITYMANAGEMENTSHARED_EXPORT ExchangeRate: public Entity
{
    Q_OBJECT
    DSL_WRITABLE_VAR_PROPERTY(int, currency_from)
    DSL_WRITABLE_VAR_PROPERTY(int, currency_to)
    QML_WRITABLE_VAR_PROPERTY(QDate, timestamp)
    DSL_WRITABLE_VAR_PROPERTY(double, amount)

public:
    ExchangeRate(QObject * parent = Q_NULLPTR): Entity(parent){}

     ~ExchangeRate() override = default;
};

#endif // EXCHANGERATE_H
