#ifndef NAMINGSTRATEGY_H
#define NAMINGSTRATEGY_H

#include <QString>

class NamingStrategy
{
public:
    static QString propertyToColumnName(const QString& property);
};

#endif // NAMINGSTRATEGY_H
