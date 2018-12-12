#ifndef INVOICE_H
#define INVOICE_H

#include "entity.h"

class ENTITYMANAGEMENTSHARED_EXPORT Invoice : public Entity
{
    Q_OBJECT
    DSL_WRITABLE_VAR_PROPERTY(int, element_id)
    DSL_WRITABLE_VAR_PROPERTY(double, amount)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, quantity)

public:
    Invoice(QObject * parent = Q_NULLPTR): Entity(parent), m_element_id(-1), m_amount(0.0){}

     ~Invoice() override = default;
};

#endif // INVOICE_H
