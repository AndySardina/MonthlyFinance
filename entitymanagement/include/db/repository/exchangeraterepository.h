#ifndef EXCHANGERATEREPOSITORY_H
#define EXCHANGERATEREPOSITORY_H

#include "repository.h"
#include "db/entity/exchangerate.h"

class ENTITYMANAGEMENTSHARED_EXPORT ExchangeRateRepository : public Repository<ExchangeRate, int>
{
public:
    ExchangeRateRepository() = default;

    virtual ~ExchangeRateRepository() = default;

    // Repository interface
public:
    void save(ExchangeRate* entity);

protected:
    ExchangeRate* createEntity(const QSqlQuery &q);
};

#endif // EXCHANGERATEREPOSITORY_H
