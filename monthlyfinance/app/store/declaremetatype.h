#ifndef DECLAREMETATYPE_H
#define DECLAREMETATYPE_H

#include <QtQml>
#include "QQmlObjectListModel.h"
#include "db/entity/currency.h"

Q_DECLARE_METATYPE(QQmlObjectListModel<Currency>*)
Q_DECLARE_OPAQUE_POINTER(QQmlObjectListModel<Currency>)


#endif // DECLAREMETATYPE_H
