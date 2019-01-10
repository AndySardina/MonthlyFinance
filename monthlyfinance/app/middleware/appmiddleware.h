#ifndef APPMIDDLEWARE_H
#define APPMIDDLEWARE_H

#include "flux_qt/action.h"
#include "flux_qt/middleware.h"

class AppMiddleware final : public flux_qt::Middleware
{
public:
    AppMiddleware();
    ~AppMiddleware();

    // Middleware interface
public:
    QSharedPointer<flux_qt::Action> process(const QSharedPointer<flux_qt::Action> &action);

private:
    AppMiddleware(const AppMiddleware&) = delete;
    AppMiddleware(AppMiddleware&&) = delete;
    AppMiddleware& operator=(const AppMiddleware&) = delete;
    AppMiddleware& operator=(AppMiddleware&&) = delete;

};

#endif // APPMIDDLEWARE_H
