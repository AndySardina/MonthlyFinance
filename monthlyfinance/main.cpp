#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "db/entitymanager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QCoreApplication::setOrganizationName("Nautam");
    QCoreApplication::setOrganizationDomain("nautam.com");
    QCoreApplication::setApplicationName("MonthlyFinance");

    QGuiApplication app(argc, argv);

    EntityManager manager;
    manager.initConection();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
