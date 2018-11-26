#ifndef OPERATIONREPOSITORY_H
#define OPERATIONREPOSITORY_H

#include "repository.h"

#include <db/entity/operation.h>

class OperationRepository : public Repository<Operation, int>
{
public:
    OperationRepository() = default;

    virtual ~OperationRepository() = default;

};

#endif // OPERATIONREPOSITORY_H
