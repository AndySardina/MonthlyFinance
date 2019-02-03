#ifndef COUNTRY_CURRENCY_H
#define COUNTRY_CURRENCY_H

#include "db/entity/entity.h"

class ENTITYMANAGEMENTSHARED_EXPORT CountryCurrency:  public Entity {

    Q_OBJECT

    DSL_WRITABLE_VAR_PROPERTY(int, countryCode)
    DSL_WRITABLE_VAR_PROPERTY(int, currencyCode)

public:
    CountryCurrency(QObject * parent = Q_NULLPTR): Entity(parent){}

    ~CountryCurrency() override = default;

};


#endif // COUNTRY_CURRENCY_H
