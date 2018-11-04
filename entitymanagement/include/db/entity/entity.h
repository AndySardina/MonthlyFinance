#ifndef ENTITY_H
#define ENTITY_H

#include "entitymanagement_global.h"

#include "QQmlVarPropertyHelpers.h"

class ENTITYMANAGEMENTSHARED_EXPORT Entity : public QObject
{
    Q_OBJECT
    QML_WRITABLE_VAR_PROPERTY(int, id)

public:
    Entity(QObject * parent = Q_NULLPTR);

    virtual QString entityName() = 0;

    virtual ~Entity() = default;

};

#endif // ENTITY_H


