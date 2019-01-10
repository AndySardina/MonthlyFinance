#ifndef APPVIEW_H
#define APPVIEW_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QJSValue>

#include "db/entitymanager.h"

class AppView : public QObject
{
    Q_OBJECT
public:
    explicit AppView(QObject *parent = nullptr);

    QQmlApplicationEngine* engine();

signals:

public slots:

    void registerElement(QQmlApplicationEngine* engine);
    void init();

private slots:
    void onDispatched(QString type, QJSValue message);

private:

    EntityManager manager;
    QQmlApplicationEngine* m_engine;

};

#endif // APPVIEW_H
