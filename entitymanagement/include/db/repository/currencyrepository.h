#ifndef CURRENCYREPOSITORY_H
#define CURRENCYREPOSITORY_H

#include "entitymanagement_global.h"
#include "repository.h"
#include "db/entity/currency.h"

class ENTITYMANAGEMENTSHARED_EXPORT CurrencyRepository : public Repository<Currency, int>
{
};

#endif // CURRENCYREPOSITORY_H
