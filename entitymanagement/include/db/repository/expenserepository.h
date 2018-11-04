#ifndef EXPENSEREPOSITORY_H
#define EXPENSEREPOSITORY_H

#include "entitymanagement_global.h"
#include "repository.h"
#include "db/entity/expense.h"

class ENTITYMANAGEMENTSHARED_EXPORT ExpenseRepository : public Repository<Expense, int>
{
public:
    ExpenseRepository() = default;

    virtual ~ExpenseRepository() = default;

    // Repository interface
public:
    void save(const std::shared_ptr<Expense> entity);

protected:
    std::shared_ptr<Expense> createEntity(const QSqlQuery &q);
};

#endif // EXPENSEREPOSITORY_H
