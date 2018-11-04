#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <db/entity/currency.h>

#include "db/entitymanager.h"
#include "QtQmlTricksPlugin_SmartDataModels.h"
#include "QQmlObjectListModel.h"

#include "db/repository/currencyrepository.h"

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

    registerQtQmlTricksSmartDataModel (&engine);

    QQmlObjectListModel<Currency> currencyModel;

    CurrencyRepository currencyRep;

    currencyModel.append( currencyRep.findAll() );

    engine.rootContext ()->setContextProperty ("currencyModel", &currencyModel);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
