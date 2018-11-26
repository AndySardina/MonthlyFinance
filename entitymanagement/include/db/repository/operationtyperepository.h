#ifndef OPERATIONTYPEREPOSITORY_H
#define OPERATIONTYPEREPOSITORY_H

#include "repository.h"

#include <db/entity/operationtype.h>

class ENTITYMANAGEMENTSHARED_EXPORT OperationTypeRepository : public Repository<OperationType, int>
{
};

#endif // OPERATIONTYPEREPOSITORY_H
