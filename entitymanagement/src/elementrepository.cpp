#include "db/repository/elementrepository.h"

#include <QVariant>

void ElementRepository::save(Element *entity)
{
    QString query = QString("INSERT INTO %1 (id, name, description) VALUES (:id, :name, :description)").arg(m_entityName);

    QSqlQuery q;

    q.prepare(query);
    q.bindValue(":id", entity->id());
    q.bindValue(":name", entity->name());
    q.bindValue(":description", entity->description());

    q.exec();
}

Element *ElementRepository::createEntity(const QSqlQuery &q)
{
    QSqlRecord record = q.record();

    int idIndex   = record.indexOf("id"),
        nameIndex = record.indexOf("name"),
        descIndex = record.indexOf("description");

    Element* entity = new Element();

    entity->set_id(q.value(idIndex).toInt());
    entity->set_name(q.value(nameIndex).toString());
    entity->set_description(q.value(descIndex).toString());

    return entity;
}
