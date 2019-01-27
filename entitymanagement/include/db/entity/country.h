#ifndef CURRENCYCOUNTRY_H
#define CURRENCYCOUNTRY_H

#include <QString>
#include "db/entity/entity.h"

class ENTITYMANAGEMENTSHARED_EXPORT Country:  public Entity
{
    Q_OBJECT
    DSL_WRITABLE_CSTREF_PROPERTY(QString, name)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, officialName)
    DSL_WRITABLE_VAR_PROPERTY(int, ccn3)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, cca3)
    DSL_WRITABLE_VAR_PROPERTY(int, callingCode)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, capital)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, region)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, subregion)

public:
    Country(QObject * parent = Q_NULLPTR): Entity(parent){}

    ~Country() override = default;

};

#endif // CURRENCYCOUNTRY_H
