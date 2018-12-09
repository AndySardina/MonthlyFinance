#ifndef PREDICATE_H
#define PREDICATE_H

#include <QString>

class Predicate
{
public:
    Predicate() = default;

    virtual QString getSqlQuery() = 0;

    virtual ~Predicate() = default;
};

#endif // PREDICATE_H
