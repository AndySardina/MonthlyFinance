#ifndef APPMIDDLEWARE_H
#define APPMIDDLEWARE_H

#include "flux_qt/action.h"
#include "flux_qt/middleware.h"

class AppMiddleware final : public flux_qt::Middleware
{
public:
    AppMiddleware() = default;

    ~AppMiddleware() override = default;

    AppMiddleware(const AppMiddleware&) = delete;
    AppMiddleware(AppMiddleware&&) = delete;
    AppMiddleware& operator=(const AppMiddleware&) = delete;
    AppMiddleware& operator=(AppMiddleware&&) = delete;

    // Middleware interface
    QSharedPointer<flux_qt::Action> process(const QSharedPointer<flux_qt::Action> &action) override;

};

#endif // APPMIDDLEWARE_H
