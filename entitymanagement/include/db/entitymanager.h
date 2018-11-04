#ifndef ENTITYMANAGER_H
#define ENTITYMANAGER_H

#include "entitymanagement_global.h"

class ENTITYMANAGEMENTSHARED_EXPORT EntityManager
{
public:
    EntityManager();

public:
    void initConection();

private:
    void initializeDB();
};

#endif // ENTITYMANAGER_H
