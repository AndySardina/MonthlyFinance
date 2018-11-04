#include "db/entity/entity.h"

int Entity::id() const
{
    return m_id;
}

void Entity::setId(int id)
{
    m_id = id;
}
