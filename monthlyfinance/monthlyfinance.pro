QT += quick sql
CONFIG += c++1z

DEFINES += QT_DEPRECATED_WARNINGS

INCLUDEPATH += \
    $$PWD/include/ \
    $$PWD/../3dparty/QtQmlModels  \
    $$PWD/../3dparty/QtSuperMacros

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../entitymanagement/release/ -lentitymanagement
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../entitymanagement/debug/ -lentitymanagement
else:unix: LIBS += -L$$OUT_PWD/../entitymanagement/ -lentitymanagement

INCLUDEPATH += $$PWD/../entitymanagement/include
DEPENDPATH += $$PWD/../entitymanagement

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../3dparty/QtQmlModels/release/ -lQtQmlModels
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../3dparty/QtQmlModels/debug/ -lQtQmlModels
else:unix: LIBS += -L$$OUT_PWD/../3dparty/QtQmlModels/ -lQtQmlModels

INCLUDEPATH += $$PWD/../3dparty/QtQmlModels
DEPENDPATH += $$PWD/../3dparty/QtQmlModels

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtQmlModels/release/libQtQmlModels.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtQmlModels/debug/libQtQmlModels.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtQmlModels/release/QtQmlModels.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtQmlModels/debug/QtQmlModels.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtQmlModels/libQtQmlModels.a
