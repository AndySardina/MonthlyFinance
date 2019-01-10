#ifndef ENTITY_H
#define ENTITY_H

#include "entitymanagement_global.h"
#include "db/querydsl/dsldefs.h"

class ENTITYMANAGEMENTSHARED_EXPORT Entity : public QObject
{
    Q_OBJECT
//    DSL_WRITABLE_VAR_PROPERTY(int, id)
    DSL_WRITABLE_CSTREF_PROPERTY(int, id)

public:
    Entity(QObject * parent = Q_NULLPTR) : QObject(parent), m_id(0) {}

     ~Entity() override = default;
};

#endif // ENTITY_H


