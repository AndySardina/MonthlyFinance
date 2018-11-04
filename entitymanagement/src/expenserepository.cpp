#include "db/repository/expenserepository.h"

#include <QVariant>
#include <QDebug>
#include <QSqlError>

#include <db/repository/expensecategoryrepository.h>

void ExpenseRepository::save(Expense* entity)
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

Expense* ExpenseRepository::createEntity(const QSqlQuery &q)
{
    QSqlRecord record = q.record();

    int idIndex       = record.indexOf("id"),
        categoryIndex = record.indexOf("category_id"),
        dateIndex     = record.indexOf("expenseDate"),
        amontIndex    = record.indexOf("amount"),
        descIndex     = record.indexOf("description")
        ;

    Expense* entity = new Expense();

    entity->set_id(q.value(idIndex).toInt());
    entity->set_date( q.value(dateIndex).toDate() );
    entity->set_amount( q.value(amontIndex).toDouble() );
    entity->set_description( q.value(descIndex).toString() );

    ExpenseCategoryRepository categoryRepository;
    ExpenseCategory* category = categoryRepository.findById(q.value(categoryIndex).toInt());
    entity->set_category(category);

    return entity;
}
