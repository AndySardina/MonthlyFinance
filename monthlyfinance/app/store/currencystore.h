#ifndef CURRENCYSTORE_H
#define CURRENCYSTORE_H

#include <QObject>
#include <QScopedPointer>
#include <QSharedPointer>

#include <flux_qt/action.h>
#include <flux_qt/store.h>

#include "store/declaremetatype.h"

class CurrencyStore final: public QObject, public flux_qt::Store
{
    Q_OBJECT
    Q_PROPERTY(QQmlObjectListModel<Currency>* model
               READ getModel
               NOTIFY modelChange)
    Q_PROPERTY(Currency* currency READ getCurrentCurrency NOTIFY currentCurrencyChanged)


public:

    static CurrencyStore& instance() {
        static CurrencyStore self;
        return self;
    }

    // Store interface
public:
    void process(const QSharedPointer<flux_qt::Action> &action);
    QQmlObjectListModel<Currency>* getModel() const;

    Currency *getCurrentCurrency() const;

signals:
    void modelChange();
    void saveCurrencyFinished(bool hasError=false, const QString& msg="");
    void askRequestNewCurrency();
    void askRequestCurrency();
    void askRequesUpdateCurency(Currency* currency);
    void currentCurrencyChanged();
    void readCurrencyFinished(bool hasError=false, const QString& msg="");

private:
    CurrencyStore();
    QQmlObjectListModel<Currency>* m_model = nullptr;
    Currency* m_currentCurrency = nullptr;

    void create(const QSharedPointer<flux_qt::Action>& action);
    void read(const QSharedPointer<flux_qt::Action>& action);
    void update(const QSharedPointer<flux_qt::Action>& action);
    void remove(const QSharedPointer<flux_qt::Action>& action);
    void list(const QSharedPointer<flux_qt::Action>& action);
    void askRequestNewCurrency(const QSharedPointer<flux_qt::Action>& action);
    void askRequesUpdateCurency(const QSharedPointer<flux_qt::Action>& action);

};

#endif // CURRENCYSTORE_H
