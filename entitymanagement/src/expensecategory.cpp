#include "db/entity/expensecategory.h"

ExpenseCategory::ExpenseCategory(QObject *parent)
    : Entity (parent)
{}

ExpenseCategory::~ExpenseCategory()
{}

QString ExpenseCategory::entityName()
{
    return QLatin1Literal("expense_category");
}

