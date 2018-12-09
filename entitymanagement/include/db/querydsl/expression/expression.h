#ifndef EXPRESSION_H
#define EXPRESSION_H

#include <QString>

class Expression
{
public:
    Expression() = default;

    Expression& AND(Expression *rigth);
    Expression& OR(Expression *rigth);
    Expression& NOT(Expression *rigth);

    QString getQuery();

private:
    QString m_query;
};

#endif // EXPRESSION_H
