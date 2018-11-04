#ifndef EXPENSECATEGORYREPOSITORY_H
#define EXPENSECATEGORYREPOSITORY_H

#include "entitymanagement_global.h"
#include "repository.h"

#include <db/entity/expensecategory.h>

class ENTITYMANAGEMENTSHARED_EXPORT ExpenseCategoryRepository : public Repository<ExpenseCategory, int>
{
public:
    ExpenseCategoryRepository() = default;

    virtual ~ExpenseCategoryRepository() = default;

    // Repository interface
public:
    void save(const std::shared_ptr<ExpenseCategory> entity);

protected:
    std::shared_ptr<ExpenseCategory> createEntity(const QSqlQuery &q);
};

#endif // EXPENSECATEGORYREPOSITORY_H
