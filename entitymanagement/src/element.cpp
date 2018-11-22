#include "db/entity/element.h"

Element::Element(QObject *parent)
    : Entity (parent)
{

}

Element::~Element()
{

}

QString Element::entityName()
{
    return QLatin1Literal("element");
}
