#ifndef ELEMENT_H
#define ELEMENT_H

#include "entity.h"

class ENTITYMANAGEMENTSHARED_EXPORT Element : public Entity
{
    Q_OBJECT
    QML_WRITABLE_VAR_PROPERTY(QString, name)
    QML_WRITABLE_VAR_PROPERTY(QString, description)

public:
    Element(QObject * parent = Q_NULLPTR);

    virtual ~Element();

    // Entity interface
public:
    virtual QString entityName();
};
#endif // ELEMENT_H
