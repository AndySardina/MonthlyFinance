#include "currencystore.h"

#include <QtQml>

#include "flux_qt/dispatcher.h"
#include "action/actiontypes.h"


CurrencyStore::CurrencyStore()
{
    m_model = new QQmlObjectListModel<Currency>(this, "name", "id");
}

Currency *CurrencyStore::getCurrentCurrency() const
{
    return m_currentCurrency;
}

void CurrencyStore::process(const QSharedPointer<flux_qt::Action> &action)
{
    switch (action->getType<ActionType>()) {

    case ActionType::CreateCurrency:
        create(action);
        break;
    case ActionType::ReadCurrency:
        read(action);
        break;
    case ActionType::UpdateCurrency:
        update(action);
        break;
    case ActionType::RemoveCurrency:
        remove(action);
        break;
    case ActionType::ListCurrency:
        list(action);
        break;
    case ActionType::AskRequesNewCurency:
        askRequestNewCurrency(action);
        break;
    case ActionType::AskRequesUpdateCurency:
        askRequesUpdateCurency(action);
        break;
    }
}

void CurrencyStore::create(const QSharedPointer<flux_qt::Action> &action)
{
    auto* currency = new Currency(this);
    currency->set_name(action->getPayload<QString>());
    currency->set_id(m_model->count()+1);
    m_model->append(currency);
    emit modelChange();
    emit saveCurrencyFinished();

    flux_qt::Dispatcher::instance().dispatch(flux_qt::Action::actionOf(ActionType::SaveCurrencyFinished));
}

void CurrencyStore::read(const QSharedPointer<flux_qt::Action> &action)
{
    auto id = action->getPayload<QString>();
    m_currentCurrency = qobject_cast<Currency*>(m_model->getByUid(id));

    if(m_currentCurrency != nullptr)
    {
        emit currentCurrencyChanged();
        emit readCurrencyFinished();
    }
    else{
        emit readCurrencyFinished(true, tr("Currency not found"));
    }
}

void CurrencyStore::update(const QSharedPointer<flux_qt::Action> &action)
{
    Q_UNUSED(action)
    emit modelChange();
    emit saveCurrencyFinished();
}

void CurrencyStore::remove(const QSharedPointer<flux_qt::Action> &action)
{
    auto id = action->getPayload<QString>();
    m_model->remove(m_model->indexOf(id));
    emit modelChange();
}

void CurrencyStore::list(const QSharedPointer<flux_qt::Action> &action)
{
    Q_UNUSED(action)

    if(m_model->count() > 0)
    {
        return;
    }

    auto* currency = new Currency();
    currency->set_name("CUP");
    currency->set_id(m_model->count()+1);

    m_model->append(currency);

    currency = new Currency();
    currency->set_name("CUC");
    currency->set_id(m_model->count()+1);

    m_model->append(currency);

    currency = new Currency();
    currency->set_name("USD");
    currency->set_id(m_model->count()+1);

    m_model->append(currency);

    currency = new Currency();
    currency->set_name("EUR");
    currency->set_id(m_model->count()+1);

    m_model->append(currency);

    emit modelChange();
}

void CurrencyStore::askRequestNewCurrency(const QSharedPointer<flux_qt::Action> &action)
{
    Q_UNUSED(action)
    emit askRequestNewCurrency();
}

void CurrencyStore::askRequesUpdateCurency(const QSharedPointer<flux_qt::Action> &action)
{
    emit askRequesUpdateCurency(action->getPayload<Currency*>());
}

QQmlObjectListModel<Currency> *CurrencyStore::getModel() const
{
    return m_model;
}
