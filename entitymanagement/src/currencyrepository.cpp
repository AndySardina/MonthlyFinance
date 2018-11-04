#include "db/repository/currencyrepository.h"

#include <QVariant>

void CurrencyRepository::save(const std::shared_ptr<Currency> entity)
{
    QString query = QString("INSERT INTO %1 (id, name) VALUES (:id, :name)").arg(m_entityName);

    QSqlQuery q;

    q.prepare(query);
    q.bindValue(":id", entity->id());
    q.bindValue(":name", entity->name());

    q.exec();
}

std::shared_ptr<Currency> CurrencyRepository::createEntity(const QSqlQuery &q)
{
    QSqlRecord record = q.record();

    int idIndex   = record.indexOf("id"),
        nameIndex = record.indexOf("name");

    std::shared_ptr<Currency> entity = std::make_shared<Currency>();

    int id = q.value(idIndex).toInt();
    QString name = q.value(nameIndex).toString();

    entity->setId(id);
    entity->setName(name);

    return entity;
}
