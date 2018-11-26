#ifndef ELEMENTREPOSITORY_H
#define ELEMENTREPOSITORY_H

#include "repository.h"
#include <db/entity/element.h>

class ElementRepository : public Repository<Element, int>
{
public:
    ElementRepository() = default;

    virtual ~ElementRepository() = default;
};

#endif // ELEMENTREPOSITORY_H
