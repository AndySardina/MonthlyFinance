#ifndef PREDICATE_H
#define PREDICATE_H

#include "entitymanagement_global.h"

#include <QVariant>

QString eq(const QVariant& value){
    return QString("= %1").arg(value.toString());
}

QString ne(const QVariant& value){
    return QString("!= %1").arg(value.toString());
}

QString in(const QVariantList& values){
    QStringList elements;
    for(QVariant value: values)
        elements << value.toString();

    return QString::fromLatin1("IN (%1)").arg(elements.join(QLatin1String(", ")));
}

QString notIn(const QVariantList& values){
    return QString("NOT %1").arg(in(values));
}

QString gt(const QVariant& value){
    return QString("> %1").arg(value.toString());
}

QString goe(const QVariant& value){
    return QString(">= %1").arg(value.toString());
}

QString lt(const QVariant& value){
    return QString("<= %1").arg(value.toString());
}

QString loe(const QVariant& value){
    return QString("<= %1").arg(value.toString());
}



class Predicate
{
public:


public:
    Predicate& filter(const QString& column, const Operation& op, const QVariant& value){
        return *this;
    }

};

#endif // PREDICATE_H
