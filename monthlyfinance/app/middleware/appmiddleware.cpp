#include "appmiddleware.h"
#include "action/actiontypes.h"

#include "store/currencystore.h"


QSharedPointer<flux_qt::Action> AppMiddleware::process(const QSharedPointer<flux_qt::Action> &action)
{

//    switch (action->getType<ActionType>()) {
//    case ActionType::CreateCurrency:
//        return QSharedPointer<flux_qt::Action>(new flux_qt::Action(ActionType::CreateCurrency, action->getPayload<QString>()));
//    case ActionType::AskRequesNewCurency:
//        return QSharedPointer<flux_qt::Action>(new flux_qt::Action(ActionType::AskRequesNewCurency));
//    }

    return action;

}
