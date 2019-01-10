#include <QCoreApplication>
#include <QQmlContext>
#include <QDir>
#include <QStandardPaths>
#include <QSharedPointer>

#include "appview.h"

#include "flux_qt/dispatcher.h"
#include "action/actionprovider.h"
#include "middleware/ftpmiddleware.h"
#include "store/mainstore.h"
#include "store/currencystore.h"
#include "middleware/appmiddleware.h"

AppView::AppView(QObject *parent) : QObject(parent), m_engine(nullptr)
{

}

void AppView::onDispatched(QString type, QJSValue message)
{
    Q_UNUSED(type);
    Q_UNUSED(message);
}

void AppView::registerElement(QQmlApplicationEngine* engine)
{
    Q_UNUSED(engine)
//    registerQtQmlTricksSmartDataModel(engine);

    qmlRegisterSingletonType<ActionProvider>("Flux", 1, 0, "ActionProvider",
                                             [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject* {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        QQmlEngine::setObjectOwnership(&ActionProvider::instance(), QQmlEngine::CppOwnership);
        return &ActionProvider::instance();
    });

    qmlRegisterSingletonType<MainStore>("Flux", 1, 0, "MainStore",
                                        [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject* {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        QQmlEngine::setObjectOwnership(&MainStore::instance(), QQmlEngine::CppOwnership);
        return &MainStore::instance();
    });


    qmlRegisterSingletonType<CurrencyStore>("Flux", 1, 0, "CurrencyStore",
                                        [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject* {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        QQmlEngine::setObjectOwnership(&CurrencyStore::instance(), QQmlEngine::CppOwnership);
        return &CurrencyStore::instance();
    });

    qmlRegisterSingletonType<CurrencyStore>("Flux", 1, 0, "CurrencyStore",
                                            [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject* {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        QQmlEngine::setObjectOwnership(&CurrencyStore::instance(), QQmlEngine::CppOwnership);
        return &CurrencyStore::instance();
    });

    flux_qt::Dispatcher::instance().registerMiddleware(new FtpMiddleware);
    flux_qt::Dispatcher::instance().registerMiddleware(new AppMiddleware);

    flux_qt::Dispatcher::instance().registerStore(QSharedPointer<flux_qt::Store>(&MainStore::instance(),
                                                                                 [](flux_qt::Store*) {}));

    flux_qt::Dispatcher::instance().registerStore(QSharedPointer<flux_qt::Store>(&CurrencyStore::instance(),
                                                                                 [](flux_qt::Store*) {}));
}

void AppView::init()
{
    manager.initConection();
}

QQmlApplicationEngine* AppView::engine()
{
    return m_engine;
}
