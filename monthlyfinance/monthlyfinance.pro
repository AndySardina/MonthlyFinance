QT += core quick qml sql
CONFIG += c++1z
#CONFIG += c++14

DEFINES += QT_DEPRECATED_WARNINGS

include($$PWD/../3dparty/QtSuperMacros/QtSuperMacros.pri)
include($$PWD/../3dparty/QtQmlModels/QtQmlModels.pri)
include($$PWD/../3dparty/flux_qt/flux_qt.pri)
#include(app/app.pri)

INCLUDEPATH += $$PWD/app

HEADERS += \
   app/action/actiontypes.h \
   app/middleware/ftpmiddleware.h \
   app/service/ftpservice.h \
   app/store/mainstore.h \
   app/service/ftpserviceworker.h \
   app/action/actionprovider.h \
   app/appview.h \
   app/store/currencystore.h \
    app/store/declaremetatype.h \
    app/middleware/appmiddleware.h

SOURCES += \
        main.cpp \
   app/middleware/ftpmiddleware.cpp \
   app/service/ftpservice.cpp \
   app/store/mainstore.cpp \
   app/service/ftpserviceworker.cpp \
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


