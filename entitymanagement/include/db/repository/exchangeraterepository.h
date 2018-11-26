#ifndef EXCHANGERATEREPOSITORY_H
#define EXCHANGERATEREPOSITORY_H

#include "repository.h"
#include "db/entity/exchangerate.h"

class ENTITYMANAGEMENTSHARED_EXPORT ExchangeRateRepository : public Repository<ExchangeRate, int>
{
public:
    ExchangeRateRepository() = default;

    virtual ~ExchangeRateRepository() = default;
};

#endif // EXCHANGERATEREPOSITORY_H
