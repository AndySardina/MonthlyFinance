#include <utility>

#include <utility>

#include "db/querydsl/predicate/stringpredicate.h"

StringPredicate::StringPredicate(QString fieldName)
    : m_fieldName(std::move(fieldName))
{
}

StringPredicate &StringPredicate::contains(const QString &str)
{
    m_query.append( QString(" %1 LIKE \'\%%2\%\' ").arg(m_fieldName, str) );
    return *this;
}

StringPredicate &StringPredicate::containsIgnoreCase(const QString &str)
{
    m_query.append(  QString(" upper(\'%1\') LIKE \'\%%2\%\' ").arg(m_fieldName, str)  );
    return *this;
}

QString StringPredicate::getSqlQuery()
{
    return m_query;
}
