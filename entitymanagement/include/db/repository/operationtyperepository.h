#ifndef OPERATIONTYPEREPOSITORY_H
#define OPERATIONTYPEREPOSITORY_H

#include "repository.h"

#include <db/entity/operationtype.h>

class ENTITYMANAGEMENTSHARED_EXPORT OperationTypeRepository : public Repository<OperationType, int>
{
public:
    OperationTypeRepository() = default;

    virtual ~OperationTypeRepository() = default;

    // Repository interface
public:
    void save(OperationType* entity);

protected:
    OperationType* createEntity(const QSqlQuery &q);
};

#endif // OPERATIONTYPEREPOSITORY_H
