#ifndef ENTITY_H
#define ENTITY_H

#include "entitymanagement_global.h"

class ENTITYMANAGEMENTSHARED_EXPORT Entity
{
public:
    Entity() = default;

    int id() const;
    void setId(int id);

    virtual QString entityName() = 0;

    virtual ~Entity() = default;
protected:
    int m_id;
};

#endif // ENTITY_H


