#ifndef STRINGPREDICATE_H
#define STRINGPREDICATE_H

#include "db/querydsl/expression/expression.h"

class StringPredicate {

public:
    StringPredicate(QString fieldName);

    Expression contains(const QString& str);
    Expression containsIgnoreCase(const QString& str);
    Expression eq(const QString& str);
    Expression eqIgnoreCase(const QString& str);
    Expression neq(const QString& str);
    Expression neqIgnoreCase(const QString& str);
    Expression startWith(const QString& str);
    Expression endWith(const QString& str);

private:
    QString m_fieldName;
};

#endif // STRINGPREDICATE_H

