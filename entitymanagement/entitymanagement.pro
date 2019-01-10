QT       += sql

QT       -= gui

TARGET = entitymanagement
TEMPLATE = lib

#CONFIG += c++1z
CONFIG += c++14

DEFINES += ENTITYMANAGEMENT_LIBRARY \
           QT_DEPRECATED_WARNINGS \
           QTQMLTRICKS_NO_PREFIX_ON_GETTERS

include($$PWD/../3dparty/QtSuperMacros/QtSuperMacros.pri)

INCLUDEPATH += \
    $$PWD/include/ \
#    $$PWD/../3dparty/QtSuperMacros

SOURCES += \
    src/entitymanager.cpp \
    src/stringpredicate.cpp \
    src/expression.cpp

HEADERS += \
    include/entitymanagement_global.h \
    include/db/entitymanager.h \
    include/db/entity/entity.h \
    include/db/repository/repository.h \
    include/db/entity/currency.h \
    include/db/repository/currencyrepository.h \
    include/db/entity/exchangerate.h \
    include/db/entity/operationtype.h \
    include/db/entity/element.h \
    include/db/entity/invoice.h \
    include/db/entity/operation.h \
    include/db/repository/exchangeraterepository.h \
    include/db/repository/operationtyperepository.h \
    include/db/repository/elementrepository.h \
    include/db/repository/invoicerepository.h \
    include/db/repository/operationrepository.h \
    include/exception/incorrectresultsizedataaccessexception.h \
    include/db/querydsl/dsldefs.h \
    include/db/querydsl/expression/expression.h \
    include/db/querydsl/private/tree.h \
    include/db/querydsl/constants.h \
    include/db/querydsl/predicate/numberpredicate.h \
    include/exception/illegalargumentexception.h \
    include/db/querydsl/predicate/stringpredicate.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}

RESOURCES += \
    sql.qrc

DISTFILES += \
    db.qmodel
