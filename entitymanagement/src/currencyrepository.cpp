#include "db/repository/currencyrepository.h"

#include <QVariant>

void CurrencyRepository::save(Currency *entity)
{
    QString query = QString("INSERT INTO %1 (id, name) VALUES (:id, :name)").arg(m_entityName);

    QSqlQuery q;

    q.prepare(query);
    q.bindValue(":id", entity->id());
    q.bindValue(":name", entity->name());

    q.exec();
}

Currency *CurrencyRepository::createEntity(const QSqlQuery &q)
{
    QSqlRecord record = q.record();

    int idIndex   = record.indexOf("id"),
        nameIndex = record.indexOf("name");

    Currency* entity = new Currency();

    int id = q.value(idIndex).toInt();
    QString name = q.value(nameIndex).toString();

    entity->set_id(id);
    entity->set_name(name);

    return entity;
}
