#ifndef ELEMENT_H
#define ELEMENT_H

#include "entity.h"

class ENTITYMANAGEMENTSHARED_EXPORT Element : public Entity
{
    Q_OBJECT
    DSL_WRITABLE_CSTREF_PROPERTY(QString, name)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, description)

public:
    Element(QObject * parent = Q_NULLPTR): Entity(parent){}

    ~Element() override = default;

    Q_DISABLE_COPY (Element)
};
#endif // ELEMENT_H
