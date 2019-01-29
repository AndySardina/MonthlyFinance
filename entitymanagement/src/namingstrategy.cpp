#include "db/naming/namingstrategy.h"

#include <QRegExp>
#include <QStringList>

QString NamingStrategy::propertyToColumnName(const QString& property)
{
    if( ! property.contains(QRegExp("[A-Z]")) )
        return property;

    QString columnName;

    for(const QChar& ch : property){
        if( ch.isUpper() )
            columnName.append(QStringLiteral("_") + ch.toLower());
        else
           columnName.append(ch);
    }

    return columnName;
}
