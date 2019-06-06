#ifndef CURRENCY_H
#define CURRENCY_H

#include <QString>
#include "db/entity/entity.h"


class ENTITYMANAGEMENTSHARED_EXPORT Currency : public Entity
{
    Q_OBJECT
    DSL_WRITABLE_CSTREF_PROPERTY(QString, name)
    DSL_WRITABLE_VAR_PROPERTY(int, numericCode)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, wikiPage)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, description)
    DSL_WRITABLE_CSTREF_PROPERTY(QString, alphabeticCode)

public:
    Currency(QObject * parent = Q_NULLPTR): Entity(parent){}

    ~Currency() override = default;

    Q_DISABLE_COPY (Currency)
};

Q_DECLARE_METATYPE(Currency*)

#endif // CURRENCY_H
