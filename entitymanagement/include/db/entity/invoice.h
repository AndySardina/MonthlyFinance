#ifndef INVOICE_H
#define INVOICE_H

#include "entity.h"

class ENTITYMANAGEMENTSHARED_EXPORT Invoice : public Entity
{
    Q_OBJECT
    QML_WRITABLE_VAR_PROPERTY(int, element_id)
    QML_WRITABLE_VAR_PROPERTY(double, amount)
    QML_WRITABLE_VAR_PROPERTY(QString, quantity)

public:
    Invoice(QObject * parent = Q_NULLPTR): Entity(parent){}

    virtual ~Invoice() = default;
};

#endif // INVOICE_H
