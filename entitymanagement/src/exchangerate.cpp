#include "db/entity/exchangerate.h"

ExchangeRate::ExchangeRate(QObject *parent) :
    Entity (parent)
{

}


ExchangeRate::~ExchangeRate()
{

}

QString ExchangeRate::entityName()
{
    return QLatin1Literal("exchange_rate");
}

