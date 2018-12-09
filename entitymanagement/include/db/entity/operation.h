#ifndef OPERATION_H
#define OPERATION_H

#include "entity.h"

#include <QDate>

class  ENTITYMANAGEMENTSHARED_EXPORT Operation : public Entity
{
    Q_OBJECT
    QML_WRITABLE_VAR_PROPERTY(int, type_id)
    QML_WRITABLE_VAR_PROPERTY(QDate, timestamp)
    QML_WRITABLE_VAR_PROPERTY(int, currency_id)

public:
    Operation(QObject * parent = Q_NULLPTR): Entity(parent){}

     ~Operation() override = default;
};

#endif // OPERATION_H
