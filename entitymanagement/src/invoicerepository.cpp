#include "db/repository/invoicerepository.h"

#include <QVariant>

void InvoiceRepository::save(Invoice *entity)
{
    QString query = QString("INSERT INTO %1 (id, element_id, amount, quantity) VALUES (:id, :element_id, :amount, :quantity)").arg(m_entityName);

    QSqlQuery q;

    q.prepare(query);
    q.bindValue(":id", entity->id());
    q.bindValue(":element_id", entity->element_id());
    q.bindValue(":amount", entity->amount());
    q.bindValue(":quantity", entity->quantity());

    q.exec();
}

Invoice *InvoiceRepository::createEntity(const QSqlQuery &q)
{
    QSqlRecord record = q.record();

    int idIndex   = record.indexOf("id"),
        elIdIndex = record.indexOf("element_id"),
        amotIndex = record.indexOf("amount"),
        quttIndex = record.indexOf("quantity");

    Invoice* entity = new Invoice();

    entity->set_id(q.value(idIndex).toInt());
    entity->set_element_id(q.value(elIdIndex).toInt());
    entity->set_amount(q.value(amotIndex).toDouble());
    entity->set_quantity(q.value(quttIndex).toString());

    return entity;
}
