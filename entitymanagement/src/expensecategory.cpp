#include "db/entity/expensecategory.h"


QString ExpenseCategory::name() const
{
    return m_name;
}

void ExpenseCategory::setName(const QString &name)
{
    m_name = name;
}

QString ExpenseCategory::description() const
{
    return m_description;
}

void ExpenseCategory::setDescription(const QString &description)
{
    m_description = description;
}

QString ExpenseCategory::entityName()
{
    return QLatin1Literal("expense_category");
}

