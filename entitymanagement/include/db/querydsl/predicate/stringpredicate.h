#ifndef STRINGPREDICATE_H
#define STRINGPREDICATE_H

#include "db/querydsl/predicate/predicate.h"

class Expression;

class StringPredicate : public Predicate {

public:
    StringPredicate(QString fieldName);

    StringPredicate& contains(const QString& str);
    StringPredicate& containsIgnoreCase(const QString& str);

    // Predicate interface
public:
    QString getSqlQuery() override;

private:
    QString m_fieldName;
    QString m_query;
};

#endif // STRINGPREDICATE_H

