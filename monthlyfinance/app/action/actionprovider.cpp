#include <action/actionprovider.h>

#include <QVariant>
#include <flux_qt/action.h>
#include <flux_qt/dispatcher.h>

#include <action/actiontypes.h>
#include <db/entity/currency.h>

void ActionProvider::showFileDialog(bool show)
{
    flux_qt::Dispatcher::instance().dispatch(new flux_qt::Action(ActionType::ShowFileDialog, show));
}

void ActionProvider::selectFile(const QString &filename)
{
    flux_qt::Dispatcher::instance().dispatch(new flux_qt::Action(ActionType::SelectFile, filename));
}

void ActionProvider::uploadFtp(const QString &filename)
{
    flux_qt::Dispatcher::instance().dispatch(new flux_qt::Action(ActionType::UploadFtp, filename));
}

void ActionProvider::createCurrency(const QString& name)
{
    flux_qt::Dispatcher::instance().dispatch(new flux_qt::Action(ActionType::CreateCurrency, name));
}

void ActionProvider::readCurrency(int id)
{
    flux_qt::Dispatcher::instance().dispatch(new flux_qt::Action(ActionType::ReadCurrency,id));
}

void ActionProvider::updateCurrency(Currency* currency)
{
    flux_qt::Dispatcher::instance().dispatch(new flux_qt::Action(ActionType::UpdateCurrency,
                                                                 QVariant::fromValue(currency)));
}

void ActionProvider::removeCurrency(int id)
{
    flux_qt::Dispatcher::instance().dispatch(new flux_qt::Action(ActionType::RemoveCurrency, id));
}

void ActionProvider::listCurrency()
{
    flux_qt::Dispatcher::instance().dispatch(new flux_qt::Action(ActionType::ListCurrency));
}

void ActionProvider::askRequesNewCurency()
{
    flux_qt::Dispatcher::instance().dispatch(new flux_qt::Action(ActionType::AskRequesNewCurency));
}

void ActionProvider::askRequesUpdateCurency(Currency* currency)
{
    flux_qt::Dispatcher::instance().dispatch(new flux_qt::Action(ActionType::AskRequesUpdateCurency,
                                                                 QVariant::fromValue(currency)));
}
