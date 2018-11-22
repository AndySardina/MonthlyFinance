#ifndef OPERATIONREPOSITORY_H
#define OPERATIONREPOSITORY_H

#include "repository.h"

#include <db/entity/operation.h>

class OperationRepository : public Repository<Operation, int>
{
public:
    OperationRepository() = default;

    virtual ~OperationRepository() = default;

    // Repository interface
public:
    void save(Operation* entity);

protected:
    Operation* createEntity(const QSqlQuery &q);
};

#endif // OPERATIONREPOSITORY_H
