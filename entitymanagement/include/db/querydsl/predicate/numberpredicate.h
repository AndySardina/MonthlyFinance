#ifndef NUMBERPREDICATE_H
#define NUMBERPREDICATE_H

#include "db/querydsl/expression/expression.h"

#include <exception/illegalargumentexception.h>

template<typename T>
class NumberPredicate {

public:
    NumberPredicate(QString fieldName)
        : m_fieldName(std::move(fieldName))
    {}

    Expression eq(const T &value)
    {
        return createExpr(Type::EQ, value);
    }

    Expression neq(const T &value)
    {
        return createExpr(Type::NEQ, value);
    }

    Expression gt(const T &value)
    {
        return createExpr(Type::GT, value);
    }

    Expression goe(const T &value)
    {
        return createExpr(Type::GOE, value);
    }

    Expression lt(const T &value)
    {
        return createExpr(Type::LT, value);
    }

    Expression loe(const T &value)
    {
        return createExpr(Type::LOE, value);
    }

    Expression between(const T &ini, const T &end)
    {
        return createExpr(Type::BETWEEN, ini, end);
    }

private:
    Expression createExpr(const Type opr, const T &value){
        if( value < 0 )
            throw IllegalArgumentException();

        return Expression(opr, m_fieldName, QString::number(value), Type::NUMBER);
    }

    Expression createExpr(const Type opr, const T &v1, const T &v2){
        if( (v1 < 0) || (v2 < 0)  )
            throw IllegalArgumentException();

        return Expression(opr, m_fieldName, QString::number(v1) + " AND " + QString::number(v2) , Type::NUMBER);
    }

    QString m_fieldName;
};


#endif // NUMBERPREDICATE_H
