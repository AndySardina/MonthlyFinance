#ifndef NAMINGSTRATEGY_H
#define NAMINGSTRATEGY_H

#include <QString>

class NamingStrategy
{
public:
    static QString propertyToColumnName(const QString& property);
    static QString classToTableName(const QString& className );

private:
    static QString getName(const QString& str);
};

#endif // NAMINGSTRATEGY_H
