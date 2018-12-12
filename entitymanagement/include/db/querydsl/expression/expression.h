#ifndef EXPRESSION_H
#define EXPRESSION_H

#include <QString>

#include "db/querydsl/private/tree.h"

class Expression
{
    using stringtree_t = btree<QString>;

public:
    Expression(const Type &opr, const QString &column, const QString &value, const Type& valueType);

    static Expression create_expression(const Type& opr, const QString& column, const QString& value , const Type &valueType);

    Expression& AND(const Expression& rigth);
    Expression& OR(const Expression& rigth);

    QString getQuery();

private:
    stringtree_t m_tree;
};

#endif // EXPRESSION_H
