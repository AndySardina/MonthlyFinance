#ifndef ELEMENT_H
#define ELEMENT_H

#include "entity.h"

class ENTITYMANAGEMENTSHARED_EXPORT Element : public Entity
{
    Q_OBJECT
    QML_WRITABLE_CSTREF_PROPERTY(QString, name)
    QML_WRITABLE_CSTREF_PROPERTY(QString, description)

public:
    Element(QObject * parent = Q_NULLPTR): Entity(parent){}

     ~Element() override = default;
};
#endif // ELEMENT_H
