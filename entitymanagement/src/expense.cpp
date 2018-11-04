#include "db/entity/expense.h"

Expense::Expense(QObject *parent)
    : Entity (parent)
{}

Expense::~Expense()
{}

QString Expense::entityName()
{
    return QLatin1Literal("expense");
}
