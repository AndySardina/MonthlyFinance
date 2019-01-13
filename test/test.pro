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

INCLUDEPATH += \
    $$PWD/../entitymanagement/include \

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../entitymanagement/release/ -lentitymanagement
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../entitymanagement/debug/ -lentitymanagement
else:unix: LIBS += -L$$OUT_PWD/../entitymanagement/ -lentitymanagement

DEPENDPATH += $$PWD/../entitymanagement

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
