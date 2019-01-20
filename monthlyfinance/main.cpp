#include <functional>
#include <iostream>

#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>

#include "app/appview.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QCoreApplication::setOrganizationName("ingenii");
    QCoreApplication::setOrganizationDomain("ingenii.com");
    QCoreApplication::setApplicationName("MonthlyFinance");

    QApplication app(argc, argv);

    EntityManager entityManager;

    try {

        entityManager.initConection();

    } catch (const std::runtime_error& e) {
        std::cerr << e.what();

        QApplication::exit(-1);
    }

    QQmlApplicationEngine engine;

    AppView appView;

    appView.registerElement(&engine);  

    engine.load(QUrl(QStringLiteral("qrc:/views/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return QApplication::exec();
}
