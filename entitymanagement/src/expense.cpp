#include "db/entity/expense.h"


std::shared_ptr<ExpenseCategory> Expense::category() const
{
    return m_category;
}

void Expense::setCategory(const std::shared_ptr<ExpenseCategory> &category)
{
    m_category = category;
}

QDate Expense::date() const
{
    return m_date;
}

void Expense::setDate(const QDate &date)
{
    m_date = date;
}

double Expense::amount() const
{
    return m_amount;
}

void Expense::setAmount(double amount)
{
    m_amount = amount;
}

QString Expense::description() const
{
    return m_description;
}

void Expense::setDescription(const QString &description)
{
    m_description = description;
}

QString Expense::entityName()
{
    return QLatin1Literal("expense");
}
