#include "db/repository/operationrepository.h"

#include <QVariant>


void OperationRepository::save(Operation *entity)
{
    QString query = QString("INSERT INTO %1 (id, type_id, timestamp, currency_id) VALUES (:id, :type_id, :timestamp, :currency_id)").arg(m_entityName);

    QSqlQuery q;

    q.prepare(query);
    q.bindValue(":id", entity->id());
    q.bindValue(":type_id", entity->type_id());
    q.bindValue(":timestamp", entity->timestamp());
    q.bindValue(":currency_id", entity->currency_id());

    q.exec();
}

Operation *OperationRepository::createEntity(const QSqlQuery &q)
{
    QSqlRecord record = q.record();

    int idIndex   = record.indexOf("id"),
        typdIndex = record.indexOf("type_id"),
        timeIndex = record.indexOf("timestamp"),
        currIndex = record.indexOf("currency_id");

    Operation* entity = new Operation();

    entity->set_id(q.value(idIndex).toInt());
    entity->set_type_id(q.value(typdIndex).toInt());
    entity->set_timestamp(q.value(timeIndex).toDate());
    entity->set_currency_id(q.value(currIndex).toInt());

    return entity;
}
