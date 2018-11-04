#ifndef CURRENCYREPOSITORY_H
#define CURRENCYREPOSITORY_H

#include "entitymanagement_global.h"
#include "repository.h"
#include "db/entity/currency.h"

class ENTITYMANAGEMENTSHARED_EXPORT CurrencyRepository : public Repository<Currency, int>
{
public:
    CurrencyRepository() = default;

    virtual ~CurrencyRepository() = default;

    // Repository interface
public:
    void save(const std::shared_ptr<Currency> entity);

protected:
    std::shared_ptr<Currency> createEntity(const QSqlQuery &q);
};

#endif // CURRENCYREPOSITORY_H
