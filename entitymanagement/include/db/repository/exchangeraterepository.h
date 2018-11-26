#ifndef EXCHANGERATEREPOSITORY_H
#define EXCHANGERATEREPOSITORY_H

#include "repository.h"
#include "db/entity/exchangerate.h"

class ENTITYMANAGEMENTSHARED_EXPORT ExchangeRateRepository : public Repository<ExchangeRate, int>
{
};

#endif // EXCHANGERATEREPOSITORY_H
