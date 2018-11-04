#-------------------------------------------------
#
# Project created by QtCreator 2018-11-03T22:21:07
#
#-------------------------------------------------

QT       += sql

QT       -= gui

TARGET = entitymanagement
TEMPLATE = lib

DEFINES += ENTITYMANAGEMENT_LIBRARY

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
INCLUDEPATH += \
    $$PWD/include/

SOURCES += \
    src/entitymanager.cpp \
    src/expensecategory.cpp \
    src/entity.cpp \
    src/expensecategoryrepository.cpp \
    src/expense.cpp \
    src/expenserepository.cpp

HEADERS += \
    include/entitymanagement_global.h \
    include/db/entitymanager.h \
    include/db/entity/expensecategory.h \
    include/db/entity/entity.h \
    include/db/repository/expensecategoryrepository.h \
    include/db/repository/repository.h \
    include/db/entity/expense.h \
    include/db/repository/expenserepository.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}

RESOURCES += \
    sql.qrc
