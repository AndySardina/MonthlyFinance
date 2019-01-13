#ifndef QML_ACTION_PROVIDER_H
#define QML_ACTION_PROVIDER_H

#include <QObject>
#include <QString>

class Currency;
class ActionProvider final : public QObject
{
    Q_OBJECT

public:
    static ActionProvider& instance() {
        static ActionProvider self;
        return self;
    }

    Q_INVOKABLE void showFileDialog(bool show);
    Q_INVOKABLE void selectFile(const QString& filename);
    Q_INVOKABLE void uploadFtp(const QString& filename);

    Q_INVOKABLE void createCurrency(const QString& name);
    Q_INVOKABLE void readCurrency(int id);
    Q_INVOKABLE void updateCurrency(Currency* currency);
    Q_INVOKABLE void removeCurrency(int id);
    Q_INVOKABLE void listCurrency(); // Provide also parameter to filter result
    Q_INVOKABLE void askRequesNewCurency();
    Q_INVOKABLE void askRequesUpdateCurency(Currency* currency);

    ActionProvider() = default;
    ActionProvider(const ActionProvider&) = delete;
    ActionProvider(ActionProvider&&) = delete;
    ActionProvider& operator=(const ActionProvider&) = delete;
    ActionProvider& operator=(ActionProvider&&) = delete;
    ~ActionProvider() override = default;
};

#endif
