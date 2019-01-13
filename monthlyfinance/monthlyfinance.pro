QT += core quick qml sql
CONFIG += c++14

DEFINES += QT_DEPRECATED_WARNINGS

include($$PWD/../3dparty/flux_qt/flux_qt.pri)

INCLUDEPATH += \
    $$PWD/include/

INCLUDEPATH += $$PWD/app

HEADERS += \
   app/action/actiontypes.h \
   app/store/mainstore.h \
   app/action/actionprovider.h \
   app/appview.h \
   app/store/currencystore.h \
   app/store/declaremetatype.h \
   app/middleware/appmiddleware.h

SOURCES += \
   main.cpp \
   app/store/mainstore.cpp \
   app/action/actionprovider.cpp \
   app/appview.cpp \
   app/store/currencystore.cpp \
   app/middleware/appmiddleware.cpp

ROOT_DIR = $$PWD

RESOURCES += \
    assets.qrc \
    qml.qrc \
    images.qrc \
    components.qrc \
    views.qrc

OTHER_FILES += images/black/*.png \
    images/black/x18/*.png \
    images/black/x36/*.png \
    images/black/x48/*.png \
    images/white/*.png \
    images/white/x18/*.png \
    images/white/x36/*.png \
    images/white/x48/*.png \
    images/extra/*.png \
    translations/*.* \

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $$PWD
#QML2_IMPORT_PATH += $$PWD/views

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH = $$PWD


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

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../3dparty/QtSuperMacros/release/ -lQtSuperMacros
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../3dparty/QtSuperMacros/debug/ -lQtSuperMacros
else:unix: LIBS += -L$$OUT_PWD/../3dparty/QtSuperMacros/ -lQtSuperMacros

INCLUDEPATH += $$PWD/../3dparty/QtQmlModels \
               $$PWD/../3dparty/QtSuperMacros

DEPENDPATH += $$PWD/../3dparty/QtQmlModels \
               $$PWD/../3dparty/QtSuperMacros

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtQmlModels/release/libQtQmlModels.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtQmlModels/debug/libQtQmlModels.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtQmlModels/release/QtQmlModels.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtQmlModels/debug/QtQmlModels.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtQmlModels/libQtQmlModels.a

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtSuperMacros/release/libQtSuperMacros.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtSuperMacros/debug/libQtSuperMacros.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtSuperMacros/release/QtSuperMacros.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtSuperMacros/debug/QtSuperMacros.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../3dparty/QtSuperMacros/libQtSuperMacros.a


