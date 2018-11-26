#ifndef OPERATIONREPOSITORY_H
#define OPERATIONREPOSITORY_H

#include "repository.h"

#include <db/entity/operation.h>

class ENTITYMANAGEMENTSHARED_EXPORT OperationRepository : public Repository<Operation, int>
{
};

#endif // OPERATIONREPOSITORY_H
