#include "db/entity/currency.h"

QString Currency::name() const
{
    return m_name;
}

void Currency::setName(const QString &name)
{
    m_name = name;
}

QString Currency::entityName()
{
    return QLatin1Literal("currency");
}
