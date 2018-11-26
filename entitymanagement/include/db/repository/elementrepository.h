#ifndef ELEMENTREPOSITORY_H
#define ELEMENTREPOSITORY_H

#include "repository.h"
#include <db/entity/element.h>

class ENTITYMANAGEMENTSHARED_EXPORT ElementRepository : public Repository<Element, int>
{
};

#endif // ELEMENTREPOSITORY_H
