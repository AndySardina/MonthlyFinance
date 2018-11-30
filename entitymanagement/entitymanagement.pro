QT       += sql

QT       -= gui

TARGET = entitymanagement
TEMPLATE = lib

CONFIG += c++1z

DEFINES += ENTITYMANAGEMENT_LIBRARY \
           QT_DEPRECATED_WARNINGS \
           QTQMLTRICKS_NO_PREFIX_ON_GETTERS

INCLUDEPATH += \
    $$PWD/include/ \
    $$PWD/../3dparty/QtSuperMacros

SOURCES += \
    src/entitymanager.cpp

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
    include/db/repository/predicate.h \
    include/exception/incorrectresultsizedataaccessexception.h \
    include/db/querydsl/predicate.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}

RESOURCES += \
    sql.qrc

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../3dparty/QtSuperMacros/release/ -lQtSuperMacros
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../3dparty/QtSuperMacros/debug/ -lQtSuperMacros
else:unix: LIBS += -L$$OUT_PWD/../3dparty/QtSuperMacros/ -lQtSuperMacros

INCLUDEPATH += $$PWD/../3dparty/QtSuperMacros
DEPENDPATH += $$PWD/../3dparty/QtSuperMacros

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtSuperMacros/release/libQtSuperMacros.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtSuperMacros/debug/libQtSuperMacros.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtSuperMacros/release/QtSuperMacros.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtSuperMacros/debug/QtSuperMacros.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtSuperMacros/libQtSuperMacros.a
