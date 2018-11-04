#include <db/repository/expensecategoryrepository.h>

#include <QVariant>

void ExpenseCategoryRepository::save(const std::shared_ptr<ExpenseCategory> entity)
{
    QString query = QString("INSERT INTO %1 (id, name, description) VALUES (:id, :name, :description)").arg(m_entityName);

    QSqlQuery q;

    q.prepare(query);
    q.bindValue(":id",           entity->id());
    q.bindValue(":name",         entity->name());
    q.bindValue(":description",  entity->description());

    q.exec();
}

std::shared_ptr<ExpenseCategory> ExpenseCategoryRepository::createEntity(const QSqlQuery &q)
{
    QSqlRecord record = q.record();

    int idIndex   = record.indexOf("id"),
        nameIndex = record.indexOf("name"),
        descIndex = record.indexOf("description")
    ;

    std::shared_ptr<ExpenseCategory> entity = std::make_shared<ExpenseCategory>();

    entity->setId( q.value(idIndex).toInt() );
    entity->setName( q.value(nameIndex).toString() );
    entity->setDescription( q.value(descIndex).toString() );

    return entity;
}
