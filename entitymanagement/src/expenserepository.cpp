#include "db/repository/expenserepository.h"

#include <QVariant>
#include <QDebug>
#include <QSqlError>

#include <db/repository/expensecategoryrepository.h>

void ExpenseRepository::save(const std::shared_ptr<Expense> entity)
{
    QString query = QString("INSERT INTO %1 (id, category_id, expenseDate, amount, description) VALUES (:id, :category_id, :expenseDate, :amount, :description)")
                     .arg(m_entityName);

    QSqlQuery q;

    q.prepare(query);
    q.bindValue(":id",           entity->id());
    q.bindValue(":category_id",  entity->category()->id());
    q.bindValue(":expenseDate",  entity->date());
    q.bindValue(":amount",       entity->amount());
    q.bindValue(":description",  entity->description());

    q.exec();
}

std::shared_ptr<Expense> ExpenseRepository::createEntity(const QSqlQuery &q)
{
    QSqlRecord record = q.record();

    int idIndex       = record.indexOf("id"),
        categoryIndex = record.indexOf("category_id"),
        dateIndex     = record.indexOf("expenseDate"),
        amontIndex    = record.indexOf("amount"),
        descIndex     = record.indexOf("description")
        ;

    std::shared_ptr<Expense> entity = std::make_shared<Expense>();

    entity->setId(q.value(idIndex).toInt());
    entity->setDate( q.value(dateIndex).toDate() );
    entity->setAmount( q.value(amontIndex).toDouble() );
    entity->setDescription( q.value(descIndex).toString() );

    ExpenseCategoryRepository categoryRepository;
    std::shared_ptr<ExpenseCategory> category = categoryRepository.findById(q.value(categoryIndex).toInt());
    entity->setCategory(category);

    return entity;
}
