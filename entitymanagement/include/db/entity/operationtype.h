#ifndef OPERATIONTYPE_H
#define OPERATIONTYPE_H

#include "entity.h"

class ENTITYMANAGEMENTSHARED_EXPORT OperationType : public Entity
{
    Q_OBJECT
    QML_WRITABLE_VAR_PROPERTY(QString, name)
    QML_WRITABLE_VAR_PROPERTY(QString, description)

public:
    OperationType(QObject * parent = Q_NULLPTR);

    virtual ~OperationType();

    // Entity interface
public:
    virtual QString entityName();
};

#endif // OPERATIONTYPE_H
