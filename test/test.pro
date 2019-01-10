QT += sql testlib

CONFIG += c++1z console
CONFIG -= app_bundle

DEFINES += QT_DEPRECATED_WARNINGS \
           QTQMLTRICKS_NO_PREFIX_ON_GETTERS

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

SOURCES += \
    entitiestest.cpp

include($$PWD/../3dparty/QtQmlModels/QtQmlModels.pri)


INCLUDEPATH += \
    $$PWD/../entitymanagement/include \


win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../entitymanagement/release/ -lentitymanagement
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../entitymanagement/debug/ -lentitymanagement
else:unix: LIBS += -L$$OUT_PWD/../entitymanagement/ -lentitymanagement

DEPENDPATH += $$PWD/../entitymanagement
