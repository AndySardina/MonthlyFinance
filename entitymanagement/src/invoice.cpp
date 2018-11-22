#include "db/entity/invoice.h"

Invoice::Invoice(QObject *parent)
    : Entity (parent)
{

}

Invoice::~Invoice()
{

}

QString Invoice::entityName()
{
    return QLatin1Literal("invoice");
}
