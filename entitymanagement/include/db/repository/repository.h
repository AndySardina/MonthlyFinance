#ifndef REPOSITORY_H
#define REPOSITORY_H

#include <memory>

#include <QList>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QVariantMap>
#include <QMetaProperty>

#include "db/querydsl/expression/expression.h"
#include "db/naming/namingstrategy.h"

template <typename Entity, typename ID>
class Repository
{
public:

    Repository(){
        std::shared_ptr<Entity> entity = std::make_shared<Entity>();
        const QMetaObject* metaObject = entity->metaObject();

        m_entityName = NamingStrategy::classToTableName( QString::fromLatin1(metaObject->className()) );
        getEntityProperties(metaObject);
    }

    Entity* findById(const ID& id){
        QSqlQuery q;

        q.prepare( QString("SELECT * FROM %1 WHERE id = :id").arg( m_entityName ) );
        q.bindValue(":id", id);

        return findOne(q);
    }

    QList<Entity*> findAll(){
        QSqlQuery q( QLatin1String("SELECT * FROM ") + m_entityName);
        return findAll(q);
    }

    /**
     * Returns a single entity matching the given {@link Predicate} or {@literal null} if none was found.
     *
     * @param predicate can be {@literal null}.
     * @return a single entity matching the given {@link Predicate} or {@literal null} if none was found.
     * @throws IncorrectResultSizeDataAccessException if the predicate yields more than one result.
     */
    Entity* findOne(Expression predicate){
        QSqlQuery q( QString("SELECT * FROM %1 WHERE %2").arg( m_entityName, predicate.getQuery() ) );

        return findOne(q);
    }

    /**
     * Returns all entities matching the given {@link Predicate}. In case no match could be found an empty
     * {@link QList} is returned.
     *
     * @param predicate can be {@literal null}.
     * @return all entities matching the given {@link Predicate}.
     */
    QList<Entity*> findAll(Expression predicate){
        QSqlQuery q( QString("SELECT * FROM %1 WHERE %2").arg( m_entityName, predicate.getQuery() ) );
        return findAll(q);
    }

    /**
     * Returns the number of instances matching the given {@link Predicate}.
     *
     * @param predicate the {@link Predicate} to count instances for, can be {@literal null}.
     * @return the number of instances matching the {@link Predicate}.
     */
    long count(Expression predicate){
        return count( QString("SELECT COUNT(id) AS count FROM %1 WHERE %2").arg(m_entityName, predicate.getQuery()) );
    }

    /**
     * Checks whether the data store contains elements that match the given {@link Predicate}.
     *
     * @param predicate the {@link Predicate} to use for the existance check, can be {@literal null}.
     * @return {@literal true} if the data store contains elements that match the given {@link Predicate}.
     */
    bool exists(Expression predicate);

    long count(){
        return count( QString("SELECT COUNT(id) AS count FROM %1").arg(m_entityName) );
    }

    void save(Entity* entity) {
        QStringList fieldHolders;

        std::fill_n(std::back_inserter(fieldHolders), m_properties.size(), "?");

        QString query =
            QString::fromLatin1("INSERT INTO %1 (%2) VALUES (%3)").arg(
                m_entityName,
                m_properties.join(QLatin1String(", ")), fieldHolders.join(QLatin1String(", "))
            );

        QSqlQuery q;
        q.prepare(query);
        for(auto& property: m_properties){
            QVariant value = entity->property(property.toLatin1());
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
    Entity* findOne(QSqlQuery& q){
        q.exec();

        Entity* entity = nullptr;

        if (q.first()) {
            entity = createEntity(q);
        }

        return entity;
    }

    QList<Entity*> findAll(QSqlQuery& q){
        q.exec();

        QList<Entity*> entities;

        while (q.next()) {
            entities.append( createEntity(q) );
        }

        return entities;
    }

    long count(const QString& query){
        long count = 0;

        QSqlQuery q( query  );

        if (q.first()) {
            QSqlRecord record = q.record();
            const int countIndex = record.indexOf("count");
            count = q.value(countIndex).toLongLong();
        }

        return count;
    }

    Entity* createEntity(const QSqlQuery& q) {
        auto* entity = new Entity();

        QSqlRecord record = q.record();

        for(auto& property: m_properties){
            QString columName = NamingStrategy::propertyToColumnName( property );
            const int fieldIndex = record.indexOf(columName);
            entity->setProperty(property.toLatin1(), q.value(fieldIndex));
        }

        return entity;
    }

    void getEntityProperties(const QMetaObject* metaObject){
        if( (metaObject != Q_NULLPTR) && (qstrcmp(metaObject->className(), "QObject") != 0)){
            int propertyCount = metaObject->propertyCount();

            for(int i = metaObject->propertyOffset(); i < propertyCount; ++i){
                m_properties <<  QString::fromLatin1(metaObject->property(i).name());
            }

            getEntityProperties(metaObject->superClass());
        }
    }

private:
    QString m_entityName;
    QStringList m_properties;
};

#endif // REPOSITORY_H
