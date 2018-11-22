#include "db/entity/operationtype.h"

OperationType::OperationType(QObject *parent)
    : Entity (parent)
{

}

OperationType::~OperationType()
{

}

QString OperationType::entityName()
{
    return QLatin1Literal("operation_type");
}
