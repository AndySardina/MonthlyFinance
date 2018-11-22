#include "db/repository/exchangeraterepository.h"

#include <QVariant>

void ExchangeRateRepository::save(ExchangeRate *entity)
{
    QString query = QString("INSERT INTO %1 (id, currency_from, currency_to, timestamp, amount) VALUES (:id, :currency_from, :currency_to, :timestamp, :amount)").arg(m_entityName);

    QSqlQuery q;

    q.prepare(query);
    q.bindValue(":id", entity->id());
    q.bindValue(":currency_from", entity->currency_from());
    q.bindValue(":currency_to", entity->currency_to());
    q.bindValue(":timestamp", entity->timestamp());
    q.bindValue(":amount", entity->amount());

    q.exec();
}

ExchangeRate *ExchangeRateRepository::createEntity(const QSqlQuery &q)
{
    QSqlRecord record = q.record();

    int idIndex   = record.indexOf("id"),
        curFIndex = record.indexOf("currency_from"),
        curTIndex = record.indexOf("currency_to"),
        dateIndex = record.indexOf("timestamp"),
        amotIndex = record.indexOf("amount");

    ExchangeRate* entity = new ExchangeRate();

    entity->set_id( q.value(idIndex).toInt() );
    entity->set_currency_from(q.value(curFIndex).toInt());
    entity->set_currency_to(q.value(curTIndex).toInt());
    entity->set_timestamp(q.value(dateIndex).toDate());
    entity->set_amount(q.value(amotIndex).toDouble());

    return entity;
}
