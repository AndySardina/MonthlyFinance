#include "db/entity/currency.h"

Currency::Currency(QObject *parent)
    : Entity(parent)
{}

Currency::~Currency()
{}

QString Currency::entityName()
{
    return QLatin1Literal("currency");
}
