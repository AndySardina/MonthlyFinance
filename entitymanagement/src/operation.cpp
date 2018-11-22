#include "db/entity/operation.h"

Operation::Operation(QObject *parent)
    : Entity (parent)
{

}

Operation::~Operation()
{

}

QString Operation::entityName()
{
    return QLatin1Literal("operation");
}
