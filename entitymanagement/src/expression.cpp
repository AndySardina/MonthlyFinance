#include "db/querydsl/expression/expression.h"

Expression &Expression::AND(Expression *rigth)
{
    return *this;
}

Expression &Expression::OR(Expression *rigth)
{
    return *this;
}

Expression &Expression::NOT(Expression *rigth)
{
    return *this;
}

QString Expression::getQuery()
{
    return m_query;
}
