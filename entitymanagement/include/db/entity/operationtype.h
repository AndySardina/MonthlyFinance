#ifndef OPERATIONTYPE_H
#define OPERATIONTYPE_H

#include "entity.h"

class ENTITYMANAGEMENTSHARED_EXPORT OperationType : public Entity
{
    Q_OBJECT
    DSL_WRITABLE_CSTREF_PROPERTY(QString, name)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, description)

public:
    OperationType(QObject * parent = Q_NULLPTR): Entity(parent){}

    ~OperationType() override = default;

    Q_DISABLE_COPY (OperationType)
};

#endif // OPERATIONTYPE_H
