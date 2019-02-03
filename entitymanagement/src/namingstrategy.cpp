#include "db/naming/namingstrategy.h"

#include <QRegExp>
#include <QStringList>

QString NamingStrategy::propertyToColumnName(const QString& property)
{
    if( ! property.contains(QRegExp("[A-Z]")) )
        return property;

    return getName(property);
}

QString NamingStrategy::classToTableName(const QString &className)
{
    if( className.split(QRegExp("[A-Z]")).length() == 1 )
        return className;

    return className.at(0).toLower() + getName( className.right(className.size() - 1) );
}

QString NamingStrategy::getName(const QString &str)
{
    QString res;

    for (const QChar& ch: str) {
        if( ch.isUpper() )
            res.append(QStringLiteral("_") + ch.toLower());
        else
           res.append(ch);
    }

    return res;
}
