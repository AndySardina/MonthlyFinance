#include <utility>

#include <utility>

#include "db/querydsl/predicate/stringpredicate.h"

StringPredicate::StringPredicate(QString fieldName)
    : m_fieldName(std::move(fieldName))
{
}

Expression StringPredicate::contains(const QString &str)
{
    return Expression(Type::LIKE, m_fieldName, QString("\%%1\%").arg(str), Type::STRING);
}

Expression StringPredicate::containsIgnoreCase(const QString &str)
{
   return Expression(Type::LIKE, QString("upper(%1)").arg(m_fieldName), QString("\%%1\%").arg(str.toUpper()), Type::STRING);
}

Expression StringPredicate::eq(const QString &str)
{
   return Expression(Type::EQ, m_fieldName, str, Type::STRING);
}

Expression StringPredicate::eqIgnoreCase(const QString &str)
{
    return Expression(Type::EQ, QString("upper(%1)").arg(m_fieldName), str.toUpper(), Type::STRING);
}

Expression StringPredicate::neq(const QString &str)
{
    return Expression(Type::NEQ, m_fieldName, str, Type::STRING);
}

Expression StringPredicate::neqIgnoreCase(const QString &str)
{
     return Expression(Type::NEQ, QString("upper(%1)").arg(m_fieldName), str.toUpper(), Type::STRING);
}

Expression StringPredicate::startWith(const QString &str)
{
    return Expression(Type::LIKE, m_fieldName, QString("%1\%").arg(str), Type::STRING);
}

Expression StringPredicate::endWith(const QString &str)
{
    return Expression(Type::LIKE, m_fieldName, QString("\%%1").arg(str), Type::STRING);
}
