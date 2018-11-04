#ifndef REPOSITORY_H
#define REPOSITORY_H

#include <memory>

#include <QList>
#include <QSqlQuery>
#include <QSqlRecord>

template <typename Entity, typename ID>
class Repository
{
public:
    Repository(){
        std::shared_ptr<Entity> entity = std::make_shared<Entity>();
        m_entityName = entity->entityName();
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

    virtual QList<Entity*> findAll(){
        QSqlQuery q( QLatin1String("SELECT * FROM ") + m_entityName);

        QList<Entity*> entities;

        while (q.next()) {
            entities.append( createEntity(q) );
        }

        return entities;
    }

    virtual void save(Entity* entity) = 0;

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

protected:
    virtual Entity* createEntity(const QSqlQuery& q) = 0;

    QString m_entityName;
};

#endif // REPOSITORY_H
