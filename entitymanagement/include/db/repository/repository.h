#ifndef REPOSITORY_H
#define REPOSITORY_H

#include <memory>

#include <QList>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QVariantMap>
#include <QMetaProperty>

template <typename Entity, typename ID>
class Repository
{
public:
    Repository(){
        std::shared_ptr<Entity> entity = std::make_shared<Entity>();
        m_meta = entity->metaObject();
        m_entityName = QString::fromLatin1(m_meta->className()).toLower();
        m_propertyCount = m_meta->propertyCount();
    }

    Entity* findById(const ID& id){
        QSqlQuery q;

        q.prepare( QString("SELECT * FROM %1 WHERE id = :id").arg( m_entityName ) );
        q.bindValue(":id", id);
        q.exec();

        QSqlRecord record = q.record();

        Entity* entity = nullptr;

        if (q.first()) {
            entity = createEntity(q);
        }

        return entity;
    }

    QList<Entity*> findAll(){
        QSqlQuery q( QLatin1String("SELECT * FROM ") + m_entityName);

        QList<Entity*> entities;

        while (q.next()) {
            entities.append( createEntity(q) );
        }

        return entities;
    }

    void save(Entity* entity) {
        QStringList fieldHolders;
        QVariantMap fields;
        for(int i = m_meta->propertyOffset(); i < m_propertyCount; ++i){
            const QString fieldName = QString::fromLatin1(m_meta->property(i).name());
            fields.insert(fieldName, entity->property(fieldName.toLatin1()));
            fieldHolders << QLatin1String("?");
        }

        QString query =
            QString::fromLatin1("INSERT INTO %1 (%2) VALUES (%3)").arg(
                m_entityName,
                fields.keys().join(QLatin1String(", ")), fieldHolders.join(QLatin1String(", "))
        );

        QSqlQuery q;
        q.prepare(query);
        for(QString column: fields.keys()){
            QVariant value = entity->property(column.toStdString().c_str());
            q.addBindValue(value);
        }

        q.exec();

    }

    void saveAll(QList<Entity*> entities){
        for(auto entity: entities)
            save(entity);
    }

    void deleteById(const ID& id){
        QSqlQuery q;
        q.prepare(QString("DELETE FROM %1 WHERE id = :id").arg(m_entityName));
        q.bindValue(":id", id);
        q.exec();
    }

    void deleteAll(){
        QSqlQuery q;
        q.exec(QString("DELETE FROM %1").arg(m_entityName));
    }

private:
    Entity* createEntity(const QSqlQuery& q) {
        Entity* entity = new Entity();

        QSqlRecord record = q.record();

        for(int i = m_meta->propertyOffset(); i < m_propertyCount; ++i){
            const QString fieldName = QString::fromLatin1(m_meta->property(i).name());
            const int fieldIndex = record.indexOf(fieldName);
            entity->setProperty(fieldName.toLatin1(), q.value(fieldIndex));
        }

        return entity;
    }

private:
    const QMetaObject* m_meta;
    QString m_entityName;
    int m_propertyCount;
};

#endif // REPOSITORY_H
