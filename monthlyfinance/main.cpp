#include <functional>

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "app/appview.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QCoreApplication::setOrganizationName("ingenii");
    QCoreApplication::setOrganizationDomain("ingenii.com");
    QCoreApplication::setApplicationName("MonthlyFinance");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    AppView appView;

    appView.registerElement(&engine);  

    engine.load(QUrl(QStringLiteral("qrc:/views/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
