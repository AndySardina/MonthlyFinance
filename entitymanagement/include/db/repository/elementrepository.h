#ifndef ELEMENTREPOSITORY_H
#define ELEMENTREPOSITORY_H

#include "repository.h"
#include <db/entity/element.h>

class ElementRepository : public Repository<Element, int>
{
public:
    ElementRepository() = default;

    virtual ~ElementRepository() = default;

    // Repository interface
public:
    void save(Element* entity);

protected:
    Element* createEntity(const QSqlQuery &q);
};

#endif // ELEMENTREPOSITORY_H
